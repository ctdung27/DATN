package com.example.converter;

import com.example.dto.AreaDTO;
import com.example.entity.AreaEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AreaConverter {

    @Autowired
    private ModelMapper modelMapper;

    public AreaDTO convertToDto (AreaEntity entity){
        AreaDTO result = modelMapper.map(entity, AreaDTO.class);
        return result;
    }

    public AreaEntity convertToEntity (AreaDTO dto){
        AreaEntity result = modelMapper.map(dto, AreaEntity.class);
        return result;
    }
}