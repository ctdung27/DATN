package com.example.service;

import com.example.dto.OrderDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ReportDTO;
import com.example.dto.TableDTO;

import java.sql.Date;
import java.util.List;

public interface IOrderService {
    List<TableDTO> findTable();
    List<OrderDTO> findByTableCode(String name);
    List<ProductDTO> findBySeatCodeAndCategory(String seatCode, String productCategory);
    void saveBill(long[] products, String seatCode);
    void updateQuantity(OrderDTO orderDTO);
    void deleteProduct(long[] ids);
    void checkout(long[] ids, String seatCode);
    ReportDTO report(String fromDate, String toDate);
 
    String exportBill(String tableCode);
    List<OrderDTO> findByCode(String code);
}
