package com.example.api;

import com.example.dto.OrderDTO;
import com.example.dto.output.ReportOutput;
import com.example.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/order")
public class OrderAPI {

    @Autowired
    private IOrderService orderService;

    @PostMapping("/{seatCode}")
    public ResponseEntity<Void> addProductToTable(@PathVariable("seatCode") String seatCode, @RequestBody long[] products) {
        orderService.saveBill(products, seatCode);
        return ResponseEntity.noContent().build();
    }

    @PutMapping
    public ResponseEntity<Void> updatePrice(@RequestBody OrderDTO orderDTO) {
        orderService.updateQuantity(orderDTO);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteProduct(@RequestBody long[] ids) {
        if (ids.length > 0) {
            orderService.deleteProduct(ids);
        }
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/checkout")
    public ResponseEntity<Void> checkout(@RequestParam("seatCode") String seatCode, @RequestBody long[] ids) {
        orderService.checkout(ids, seatCode);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/bill")
    public String exportBill(@RequestParam(value = "tableCode", required = false) String tableCode) {
        return orderService.exportBill(tableCode);
    }

    @GetMapping("/details")
    public ReportOutput orderDetail(@RequestParam(value = "code") String code) {
        ReportOutput result = new ReportOutput();
        List<OrderDTO> reports = orderService.findByCode(code);
        int total = 0;
        for (OrderDTO item: reports) {
            total += item.getTotalPrice();
        }
        result.setTotal(total);
        result.setOrders(reports);
        return result;
    }
}