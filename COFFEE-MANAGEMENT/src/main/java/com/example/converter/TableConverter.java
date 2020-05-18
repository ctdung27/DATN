package com.example.converter;

import com.example.dto.TableDTO;
import com.example.entity.SeatEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TableConverter {

    @Autowired
    private ModelMapper modelMapper;

    public TableDTO convertToDto(SeatEntity entity) {
        TableDTO result = modelMapper.map(entity, TableDTO.class);
        return result;
    }

    public SeatEntity convertToEntity(TableDTO dto) {
        SeatEntity result = modelMapper.map(dto, SeatEntity.class);
        return result;
    }
}
