package com.example.api;

import com.example.dto.AreaDTO;
import com.example.dto.ProductCategoryDTO;
import com.example.service.IAreaService;
import com.example.service.IProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/productcategory")
public class ProductCategoryAPI {

    @Autowired
    private IProductCategoryService productCategoryService;

    @PostMapping
    public ResponseEntity<ProductCategoryDTO> createProductCategory(@RequestBody ProductCategoryDTO dto) {
        return ResponseEntity.ok(productCategoryService.insert(dto));
    }

    @PutMapping
    public ResponseEntity<ProductCategoryDTO> updateProductCategory(@RequestBody ProductCategoryDTO dto) {
        return ResponseEntity.ok(productCategoryService.update(dto));
    }

    @DeleteMapping
    public ResponseEntity<String> deleteProductCategory(@RequestBody long[] ids) {
        if (ids.length > 0) {
            productCategoryService.deleteProductCategory(ids);
        }
        return ResponseEntity.ok("success");
    }
}
