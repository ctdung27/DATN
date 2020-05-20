package com.example.service;

import com.example.dto.ProductCategoryDTO;

import java.util.List;
import java.util.Map;

public interface IProductCategoryService {
    List<ProductCategoryDTO> findAll();
    ProductCategoryDTO findById(long id);
    ProductCategoryDTO insert(ProductCategoryDTO dto);
    ProductCategoryDTO update(ProductCategoryDTO dto);
    void deleteProductCategory(long[] ids);
    Map<String, String> getProductCategories();
}
