package com.example.repository;

import com.example.entity.SeatEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SeatRepository extends JpaRepository<SeatEntity, Long> {
    SeatEntity findOneByCode(String code);
}
