package com.example.service.impl;

import com.example.converter.TableConverter;
import com.example.dto.TableDTO;
import com.example.entity.SeatEntity;
import com.example.repository.SeatRepository;
import com.example.service.ITableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TableService implements ITableService {

    @Autowired
    private SeatRepository seatRepository;

    @Autowired
    private TableConverter tableConverter;

    @Override
    public List<TableDTO> findAll() {
        List<SeatEntity> results = seatRepository.findAll();
        return results.stream().map(item -> tableConverter.convertToDto(item)).collect(Collectors.toList());
    }

    @Override
    public TableDTO findById(long id) {
        SeatEntity seatEntity = seatRepository.findOne(id);
        TableDTO tableDTO = tableConverter.convertToDto(seatEntity);
        return tableDTO;
    }

    @Override
    @Transactional
    public TableDTO insert(TableDTO tableDTO) {
        SeatEntity seatEntity = tableConverter.convertToEntity(tableDTO);
        return tableConverter.convertToDto(seatRepository.save(seatEntity));
    }

    @Override
    @Transactional
    public TableDTO update(TableDTO tableDTO) {
        SeatEntity oldTable = seatRepository.findOne(tableDTO.getId());
        oldTable.setName(tableDTO.getName());
        oldTable.setCode(tableDTO.getCode());
        return tableConverter.convertToDto(seatRepository.save(oldTable));
    }

    @Override
    @Transactional
    public void deleteTable(long[] ids) {
        for (Long item : ids) {
            seatRepository.delete(item);
        }
    }
}
