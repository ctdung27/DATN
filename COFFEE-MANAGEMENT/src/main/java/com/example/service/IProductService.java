package com.example.service;

import com.example.dto.ProductDTO;

import java.util.List;

public interface IProductService {
    List<ProductDTO> findAll();
    ProductDTO findById(long id);
    ProductDTO insert(ProductDTO productDTO);
    ProductDTO update(ProductDTO productDTO);
    void deleteEvent(long[] ids);
}
