package com.example.service.impl;

import com.example.converter.ProductCategoryConverter;
import com.example.dto.ProductCategoryDTO;
import com.example.entity.ProductCategoryEntity;
import com.example.repository.ProductCategoryRepository;
import com.example.service.IProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class ProductCategoryService implements IProductCategoryService {

    @Autowired
    private ProductCategoryRepository productCategoryRepository;

    @Autowired
    private ProductCategoryConverter productCategoryConverter;

    @Override
    public List<ProductCategoryDTO> findAll() {
        List<ProductCategoryEntity> results = productCategoryRepository.findAll();
        return results.stream().map(item -> productCategoryConverter.convertToDto(item)).collect(Collectors.toList());
    }

    @Override
    public ProductCategoryDTO findById(long id) {
        ProductCategoryEntity entity = productCategoryRepository.findOne(id);
        ProductCategoryDTO dto = productCategoryConverter.convertToDto(entity);
        return dto;
    }

    @Override
    @Transactional
    public ProductCategoryDTO insert(ProductCategoryDTO dto) {
        ProductCategoryEntity entity = productCategoryConverter.convertToEntity(dto);
        return productCategoryConverter.convertToDto(productCategoryRepository.save(entity));
    }

    @Override
    @Transactional
    public ProductCategoryDTO update(ProductCategoryDTO dto) {
        ProductCategoryEntity oldEntity = productCategoryRepository.findOne(dto.getId());
        oldEntity.setName(dto.getName());
        oldEntity.setCode(dto.getCode());
        return productCategoryConverter.convertToDto(productCategoryRepository.save(oldEntity));
    }

    @Override
    @Transactional
    public void deleteProductCategory(long[] ids) {
        for (Long item : ids) {
            productCategoryRepository.delete(item);
        }
    }

    @Override
    public Map<String, String> getProductCategories() {
        Map<String, String> results = new HashMap<>();
        productCategoryRepository.findAll().forEach(item -> results.put(item.getCode(), item.getName()));
        return results;
    }
}
