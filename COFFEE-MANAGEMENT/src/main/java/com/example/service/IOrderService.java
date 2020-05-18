package com.example.service;

import com.example.dto.OrderDTO;
import com.example.dto.ProductDTO;
import com.example.dto.TableDTO;

import java.util.List;

public interface IOrderService {
    List<TableDTO> findTable();
    List<OrderDTO> findByTableCode(String name);
    List<ProductDTO> findBySeatCode(String seatCode);
    void saveBill(long[] products, String seatCode);
    void updateQuantity(OrderDTO orderDTO);
    void deleteProduct(long[] ids);
    void checkout(long[] ids, String seatCode);
    List<OrderDTO> report(String fromDate, String toDate);
}
