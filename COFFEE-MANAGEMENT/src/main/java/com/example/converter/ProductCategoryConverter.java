package com.example.converter;

import com.example.dto.AreaDTO;
import com.example.dto.ProductCategoryDTO;
import com.example.entity.AreaEntity;
import com.example.entity.ProductCategoryEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductCategoryConverter {
	// ModelMapper là thư viện chuyển đổi đối tượng ban đầu sang dto
    @Autowired
    private ModelMapper modelMapper;

    public ProductCategoryDTO convertToDto (ProductCategoryEntity entity){
        ProductCategoryDTO result = modelMapper.map(entity, ProductCategoryDTO.class);
        return result;
    }

    public ProductCategoryEntity convertToEntity (ProductCategoryDTO dto){
        ProductCategoryEntity result = modelMapper.map(dto, ProductCategoryEntity.class);
        return result;
    }
}
