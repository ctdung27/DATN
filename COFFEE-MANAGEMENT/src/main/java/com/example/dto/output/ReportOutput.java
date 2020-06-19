package com.example.dto.output;

import com.example.dto.OrderDTO;

import java.util.ArrayList;
import java.util.List;

public class ReportOutput {

    private Integer total;
    private List<OrderDTO> orders = new ArrayList<>();

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<OrderDTO> getOrders() {
        return orders;
    }

    public void setOrders(List<OrderDTO> orders) {
        this.orders = orders;
    }
}
