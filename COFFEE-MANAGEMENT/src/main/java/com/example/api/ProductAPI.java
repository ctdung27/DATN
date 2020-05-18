package com.example.api;

import com.example.dto.ProductDTO;
import com.example.service.IOrderService;
import com.example.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/product")
public class ProductAPI {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IProductService productService;

    @GetMapping("/order")
    public ResponseEntity<List<ProductDTO>> loadProductBySeat(@RequestParam(value = "seatCode", required = false) String seatCode) {
        return ResponseEntity.ok(orderService.findBySeatCode(seatCode));
    }

    @PostMapping
    public ResponseEntity<ProductDTO> createProduct(@RequestBody ProductDTO productDTO) {
        return ResponseEntity.ok(productService.insert(productDTO));
    }

    @PutMapping
    public ResponseEntity<ProductDTO> updateProduct(@RequestBody ProductDTO productDTO) {
        return ResponseEntity.ok(productService.update(productDTO));
    }

    @DeleteMapping
    public ResponseEntity<String> deleteProduct(@RequestBody long[] ids) {
        if (ids.length > 0) {
            productService.deleteEvent(ids);
        }
        return ResponseEntity.ok("success");
    }
}
