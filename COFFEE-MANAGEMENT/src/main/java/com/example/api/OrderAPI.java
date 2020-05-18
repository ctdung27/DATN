package com.example.api;

import com.example.dto.OrderDTO;
import com.example.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
}
