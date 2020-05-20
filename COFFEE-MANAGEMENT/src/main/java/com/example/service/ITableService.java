package com.example.service;

import com.example.dto.TableDTO;

import java.util.List;

public interface ITableService {
    List<TableDTO> findAll();
    TableDTO findById(long id);
    TableDTO insert(TableDTO tableDTO);
    TableDTO update(TableDTO tableDTO);
    List<TableDTO> findByAreaCode(String areaCode);
	void deleteTable(long[] ids);
}
