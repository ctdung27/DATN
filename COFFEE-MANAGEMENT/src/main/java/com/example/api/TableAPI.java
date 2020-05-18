package com.example.api;

import com.example.dto.TableDTO;
import com.example.service.ITableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/table")
public class TableAPI {

    @Autowired
    private ITableService tableService;

    @PostMapping
    public ResponseEntity<TableDTO> createTable(@RequestBody TableDTO tableDTO) {
        return ResponseEntity.ok(tableService.insert(tableDTO));
    }

    @PutMapping
    public ResponseEntity<TableDTO> updateTable(@RequestBody TableDTO tableDTO) {
        return ResponseEntity.ok(tableService.update(tableDTO));
    }

    @DeleteMapping
    public ResponseEntity<String> deleteTable(@RequestBody long[] ids) {
        if (ids.length > 0) {
            tableService.deleteTable(ids);
        }
        return ResponseEntity.ok("success");
    }
}
