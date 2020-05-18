package com.example.service.impl;

import com.example.constant.SystemConstant;
import com.example.dto.OrderDTO;
import com.example.dto.ProductDTO;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
    public List<ProductDTO> findBySeatCode(String seatCode) {
        if (StringUtils.isNotBlank(seatCode)) {
            return productRepository.findAll().stream().map(item -> {
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
        for (long item: ids) {
            BillEntity billEntity = billRepository.findOne(item);
            billEntity.setStatus(SystemConstant.ORDER_DONE);
            billRepository.save(billEntity);
        }
        seatEntity.setStatus(SystemConstant.EMPTY_SEAT);
        seatRepository.save(seatEntity);
    }

    @Override
    public List<OrderDTO> report(String fromDateStr, String toDateStr) {
        List<OrderDTO> results = new ArrayList<>();
        Date fromDate = StringUtils.isNotBlank(fromDateStr) ? DateUtils.convertStringToDate("dd-MM-yyyy", fromDateStr) : null;
        Date toDate = StringUtils.isNotBlank(toDateStr) ? DateUtils.convertStringToDate("dd-MM-yyyy", toDateStr) : null;
        List<BillEntity> billEntities = new ArrayList<>();
        if (fromDate != null && toDate == null) {
            billEntities = billRepository.findByCreatedDateAfter(fromDate);
        } else if (toDate != null && fromDate == null) {
            billEntities = billRepository.findByCreatedDateBefore(toDate);
        } else if (fromDate != null && toDate != null && (fromDate.compareTo(toDate) < 0)) {
            billEntities = billRepository.findByCreatedDateBetween(fromDate, toDate);
        } /*else if (fromDate != null && toDate != null && (fromDate.compareTo(toDate) == 0)) {
            billEntities = billRepository.findByCreatedDate(fromDate);
        }*/
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
