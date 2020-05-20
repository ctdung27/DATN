package com.example.repository;

import com.example.entity.SeatEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SeatRepository extends JpaRepository<SeatEntity, Long> {
    SeatEntity findOneByCode(String code);
    List<SeatEntity> findByArea_Code(String code);
}
