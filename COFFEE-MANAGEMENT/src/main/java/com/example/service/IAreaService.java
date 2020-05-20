package com.example.service;

import com.example.dto.AreaDTO;

import java.util.List;
import java.util.Map;

public interface IAreaService {
    List<AreaDTO> findAll();
    AreaDTO findById(long id);
    AreaDTO insert(AreaDTO productDTO);
    AreaDTO update(AreaDTO productDTO);
    void deleteArea(long[] ids);
    Map<String, String> getAreas();
}
