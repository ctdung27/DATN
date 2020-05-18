package com.example.service.impl;

import com.example.converter.ProductConverter;
import com.example.dto.ProductDTO;
import com.example.entity.ProductEntity;
import com.example.repository.ProductRepository;
import com.example.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductService implements IProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductConverter productConverter;

    @Override
    public List<ProductDTO> findAll() {
        List<ProductEntity> results = productRepository.findAll();
        return results.stream().map(item -> productConverter.convertToDto(item)).collect(Collectors.toList());
    }

    @Override
    public ProductDTO findById(long id) {
        ProductEntity productEntity = productRepository.findOne(id);
        ProductDTO productDTO = productConverter.convertToDto(productEntity);
        return productDTO;
    }

    @Override
    @Transactional
    public ProductDTO insert(ProductDTO productDTO) {
        ProductEntity productEntity = productConverter.convertToEntity(productDTO);
        return productConverter.convertToDto(productRepository.save(productEntity));
    }

    @Override
    @Transactional
    public ProductDTO update(ProductDTO productDTO) {
        ProductEntity oldProduct = productRepository.findOne(productDTO.getId());
        oldProduct.setName(productDTO.getName());
        oldProduct.setCode(productDTO.getCode());
        oldProduct.setPrice(productDTO.getPrice());
        return productConverter.convertToDto(productRepository.save(oldProduct));
    }

    @Override
    @Transactional
    public void deleteEvent(long[] ids) {
        for (Long item : ids) {
            productRepository.delete(item);
        }
    }
}
