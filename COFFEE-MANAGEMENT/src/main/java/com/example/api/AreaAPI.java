package com.example.api;

import com.example.dto.AreaDTO;
import com.example.service.IAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/area")
public class AreaAPI {

    @Autowired
    private IAreaService areaService;

    @PostMapping
    public ResponseEntity<AreaDTO> createArea(@RequestBody AreaDTO dto) {
        return ResponseEntity.ok(areaService.insert(dto));
    }

    @PutMapping
    public ResponseEntity<AreaDTO> updateArea(@RequestBody AreaDTO dto) {
        return ResponseEntity.ok(areaService.update(dto));
    }

    @DeleteMapping
    public ResponseEntity<String> deleteArea(@RequestBody long[] ids) {
        if (ids.length > 0) {
            areaService.deleteArea(ids);
        }
        return ResponseEntity.ok("success");
    }
}
