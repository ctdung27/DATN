package com.example.service.impl;

import com.example.converter.AreaConverter;
import com.example.dto.AreaDTO;
import com.example.entity.AreaEntity;
import com.example.repository.AreaRepository;
import com.example.service.IAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class AreaService implements IAreaService {

    @Autowired
    private AreaRepository areaRepository;

    @Autowired
    private AreaConverter areaConverter;

    @Override
    public List<AreaDTO> findAll() {
        List<AreaEntity> results = areaRepository.findAll();
        return results.stream().map(item -> areaConverter.convertToDto(item)).collect(Collectors.toList());
    }

    @Override
    public AreaDTO findById(long id) {
        AreaEntity entity = areaRepository.findOne(id);
        AreaDTO dto = areaConverter.convertToDto(entity);
        return dto;
    }

    @Override
    @Transactional
    public AreaDTO insert(AreaDTO dto) {
        AreaEntity entity = areaConverter.convertToEntity(dto);
        return areaConverter.convertToDto(areaRepository.save(entity));
    }

    @Override
    @Transactional
    public AreaDTO update(AreaDTO dto) {
        AreaEntity oldEntity = areaRepository.findOne(dto.getId());
        oldEntity.setName(dto.getName());
        oldEntity.setCode(dto.getCode());
        return areaConverter.convertToDto(areaRepository.save(oldEntity));
    }

    @Override
    @Transactional
    public void deleteArea(long[] ids) {
        for (Long item : ids) {
            areaRepository.delete(item);
        }
    }

    @Override
    public Map<String, String> getAreas() {
        Map<String, String> results = new HashMap<>();
        areaRepository.findAll().forEach(item -> results.put(item.getCode(), item.getName()));
        return results;
    }
}
