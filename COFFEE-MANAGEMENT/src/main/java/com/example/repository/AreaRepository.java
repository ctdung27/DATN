package com.example.repository;

import com.example.entity.AreaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AreaRepository extends JpaRepository<AreaEntity, Long> {
    AreaEntity findByCode(String code);
}