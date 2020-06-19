package com.example.service.impl;

import com.example.constant.SystemConstant;
import com.example.dto.OrderDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ReportDTO;
import com.example.dto.TableDTO;
import com.example.entity.BillEntity;
import com.example.entity.ProductEntity;
import com.example.entity.SeatEntity;
import com.example.repository.BillRepository;
import com.example.repository.ProductRepository;
import com.example.repository.SeatRepository;
import com.example.service.IOrderService;
import com.example.util.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.FileOutputStream;
import java.util.*;
import java.util.stream.Collectors;
@Service
public class OrderService implements IOrderService {

    @Autowired
    private SeatRepository seatRepository;

    @Autowired
    private BillRepository billRepository;

    @Autowired
    private ProductRepository productRepository;

    @Override
    public List<TableDTO> findTable() {
        List<TableDTO> results = new ArrayList<>();
        List<SeatEntity> seats = seatRepository.findAll();
        for (SeatEntity item: seats) {
            TableDTO tableDTO = new TableDTO();
            tableDTO.setName(item.getName());
            tableDTO.setCode(item.getCode());
            tableDTO.setStatus(item.getStatus());
            results.add(tableDTO);
        }
        return results;
    }

    @Override
    public List<OrderDTO> findByTableCode(String tableCode) {
        List<OrderDTO> results = new ArrayList<>();
        List<BillEntity> bills = billRepository.findBySeat_CodeAndStatus(tableCode, SystemConstant.ORDER_PROCESSING);
        for (BillEntity item: bills) {
            OrderDTO orderDTO = new OrderDTO();
            orderDTO.setId(item.getId());
            orderDTO.setName(item.getProduct().getName());
            orderDTO.setQuantity(item.getQuantity());
            orderDTO.setPrice(item.getProduct().getPrice());
            orderDTO.setTotalPrice(item.getTotalPrice());
            orderDTO.setNote(item.getNote());
            results.add(orderDTO);
        }
        return results;
    }

    @Override
    public List<ProductDTO> findBySeatCodeAndCategory(String seatCode, String productCategory) {
        if (StringUtils.isNotBlank(seatCode)) {
        	return productRepository.findByProductCategory_Code(productCategory).stream().map(item -> {
                ProductDTO productDTO = new ProductDTO();
                productDTO.setId(item.getId());
                productDTO.setName(item.getName());
                if (billRepository.existsByProduct_IdAndSeat_CodeAndStatus(item.getId(), seatCode, SystemConstant.ORDER_PROCESSING)) {
                    productDTO.setChecked(SystemConstant.CHECKED);
                }
                return productDTO;
            }).collect(Collectors.toList());
        }
        return null;
    }

    @Override
    @Transactional
    public void saveBill(long[] products, String seatCode) {
        SeatEntity seatEntity = seatRepository.findOneByCode(seatCode);
        for (long item: products) {
            boolean existBill = billRepository.existsByProduct_IdAndSeat_CodeAndStatus(item, seatCode, SystemConstant.ORDER_PROCESSING);
            if (!existBill) {
                ProductEntity productEntity = productRepository.findOne(item);
                BillEntity billEntity = new BillEntity();
                billEntity.setSeat(seatEntity);
                billEntity.setProduct(productEntity);
                billEntity.setStatus(SystemConstant.ORDER_PROCESSING);
                billRepository.save(billEntity);
            }
        }
        seatEntity.setStatus(SystemConstant.FULL_SEAT);
        seatRepository.save(seatEntity);
    }

    @Override
    @Transactional
    public void updateQuantity(OrderDTO orderDTO) {
        BillEntity billEntity = billRepository.findOne(orderDTO.getId());
        billEntity.setQuantity(orderDTO.getQuantity());
        billEntity.setTotalPrice(orderDTO.getQuantity() * billEntity.getProduct().getPrice());
        billRepository.save(billEntity);
    }

    @Override
    @Transactional
    public void deleteProduct(long[] ids) {
        for (long item: ids) {
            billRepository.delete(item);
        }
    }

    @Override
    @Transactional
    public void checkout(long[] ids, String seatCode) {
        SeatEntity seatEntity = seatRepository.findOneByCode(seatCode);
        Random objGenerator = new Random();
        int randomNumber = objGenerator.nextInt(1000);
        for (long item: ids) {
            BillEntity billEntity = billRepository.findOne(item);
            billEntity.setStatus(SystemConstant.ORDER_DONE);
            billEntity.setCode(String.valueOf(randomNumber));
            billRepository.save(billEntity);
        }
        seatEntity.setStatus(SystemConstant.EMPTY_SEAT);
        seatRepository.save(seatEntity);
    }

    @Override
    public ReportDTO report(String fromDateStr, String toDateStr) {
        ReportDTO result = new ReportDTO();
        List<OrderDTO> orders = new ArrayList<>();
        Date fromDate = StringUtils.isNotBlank(fromDateStr) ? DateUtils.convertStringToDate("dd-MM-yyyy", fromDateStr) : null;
        Date toDate = StringUtils.isNotBlank(toDateStr) ? DateUtils.convertStringToDate("dd-MM-yyyy", toDateStr) : null;
        List<BillEntity> billEntities = new ArrayList<>();
        if (fromDate != null && toDate == null) {
            billEntities = billRepository.findByCreatedDateAfter(fromDate);
        } else if (toDate != null && fromDate == null) {
            billEntities = billRepository.findByCreatedDateBefore(toDate);
        } else if (fromDate != null && toDate != null && (fromDate.compareTo(toDate) < 0)) {
            billEntities = billRepository.findByCreatedDateBetween(fromDate, toDate);
        } 
        Map<String, Object> maps = new HashMap<>();
        int totalPrice = 0;
        for (BillEntity item: billEntities) {
            OrderDTO orderDTO = new OrderDTO();
           
            //orderDTO.setTotalPrice(item.getProduct().getPrice() * item.getQuantity());
           
            orderDTO.setCreatedDate(item.getCreatedDate());
         
            maps.put(item.getCode(), orderDTO);
            totalPrice += item.getTotalPrice();
        }
        for (Map.Entry<String, Object> entry : maps.entrySet()) {
            OrderDTO orderDTO = (OrderDTO) entry.getValue();
            orderDTO.setCode(entry.getKey());
            orders.add(orderDTO);
        }
        result.setOrders(orders);
        result.setTotalPrice(totalPrice);
        return result;
    }
    @Override
    public String exportBill(String tableCode) {
        
        List<BillEntity> bills = billRepository.findBySeat_CodeAndStatus(tableCode, SystemConstant.ORDER_PROCESSING);
        try {
        	//Tạo đối tượng file word;
        	XWPFDocument document = new XWPFDocument();
        	
        	
        	XWPFParagraph titleGraph = document.createParagraph();
        	 titleGraph.setAlignment(ParagraphAlignment.CENTER);
        	 
        	 String title = "HOMIE COFFEE HOUSE ";
        	 XWPFRun titleRun = titleGraph.createRun();
        	 titleRun.setFontSize(20);
        	 titleRun.setBold(true);
             titleRun.setText(title);
           
             
             XWPFParagraph titleGraph2 = document.createParagraph();
        	 titleGraph2.setAlignment(ParagraphAlignment.CENTER);
        	 String title2 = "Địa chỉ: 54 Nguyễn Lương Bằng - TP Đà Nẵng";
        	 XWPFRun titleRun2 = titleGraph2.createRun();
             titleRun2.setText(title2);
            
        	
             XWPFParagraph titleGraph3 = document.createParagraph();
        	 titleGraph3.setAlignment(ParagraphAlignment.CENTER);
        	 String title3 = "\n------------------------------------";
        	 XWPFRun titleRun3 = titleGraph3.createRun();
             titleRun3.setText(title3);
            
             
             
             XWPFParagraph titleGraph4 = document.createParagraph();
        	 titleGraph4.setAlignment(ParagraphAlignment.CENTER);
        	 String title4 = "PHIẾU THANH TOÁN ";
        	 XWPFRun titleRun4 = titleGraph4.createRun();
        	 titleRun4.setBold(true);
             titleRun4.setText(title4);
             
             
             XWPFParagraph titleGraph5 = document.createParagraph();
             titleGraph5.setAlignment(ParagraphAlignment.CENTER);
             String title5 = "Thu ngân: "+ "Tiến Dũng";
             XWPFRun titleRun5 = titleGraph5.createRun();
             titleRun5.setText(title5);
            
           //create table
             XWPFTable table = document.createTable();
             table.setCellMargins(20, 700, 20,700);
             table.setWidth(100);
             XWPFTableRow tableRowOne = table.getRow(0);
            
             tableRowOne.getCell(0).setText("Tên Đồ Uống");
             tableRowOne.addNewTableCell().setText("Số lượng");
             tableRowOne.addNewTableCell().setText("Giá");
             tableRowOne.addNewTableCell().setText("Thành tiền");
             
           double tog = 0;
             for(BillEntity bill: bills) {
            	 XWPFTableRow tableRow = table.createRow();
            	 tableRow.getCell(0).setText(bill.getProduct().getName());
            	 tableRow.getCell(1).setText(String.valueOf(bill.getQuantity()));
            	 tableRow.getCell(2).setText(String.valueOf(bill.getProduct().getPrice()));
            	 tableRow.getCell(3).setText(String.valueOf(bill.getQuantity()*bill.getProduct().getPrice())+" VNĐ");
            	 tog = tog + bill.getQuantity()*bill.getProduct().getPrice();
             }
        
             
             XWPFParagraph paragraph2 = document.createParagraph();
             paragraph2.setAlignment(ParagraphAlignment.CENTER);
             XWPFRun run = paragraph2.createRun();
             run.setBold(true);
             run.setText("Tổng tiền:    "+ tog+" VNĐ");
             
             
           
             XWPFParagraph titleGraph6 = document.createParagraph();
             titleGraph6.setAlignment(ParagraphAlignment.CENTER);
             String title6 = "Cảm ơn quý khách. Hẹn gặp lại";
             XWPFRun titleRun6 = titleGraph6.createRun();
             titleRun6.setText(title6);


      

            FileOutputStream fileOut = new FileOutputStream("C:/home/coffemanagement/bill.docx");
            document.write(fileOut);
            fileOut.close();
            document.close();
            return "C:/home/coffemanagement/bill.docx";
        } catch (Exception e) {
            return null;
        }
    }
    
    
    @Override
    public List<OrderDTO> findByCode(String code) {
        List<OrderDTO> results = new ArrayList<>();
        List<BillEntity> billEntities = billRepository.findByCode(code);
        for (BillEntity item: billEntities) {
            OrderDTO orderDTO = new OrderDTO();
            orderDTO.setId(item.getId());
            orderDTO.setName(item.getProduct().getName());
            orderDTO.setPrice(item.getProduct().getPrice());
            orderDTO.setQuantity(item.getQuantity());
            orderDTO.setTotalPrice(item.getProduct().getPrice() * item.getQuantity());
            orderDTO.setCreatedDate(item.getCreatedDate());
            results.add(orderDTO);
        }
        return results;
    }

}
