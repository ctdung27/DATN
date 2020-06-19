package com.example.repository;

import com.example.entity.BillEntity;
import com.example.entity.SeatEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Date;
import java.util.List;

public interface BillRepository extends JpaRepository<BillEntity, Long> {
    List<BillEntity> findBySeat_CodeAndStatus(String code, String status);
    boolean existsByProduct_IdAndSeat_CodeAndStatus(long productId, String seatCode, String status);
    List<BillEntity> findByCreatedDateBefore(Date to);
    List<BillEntity> findByCreatedDateAfter(Date from);
    List<BillEntity> findByCreatedDateBetween(Date from, Date to);
    List<BillEntity> findByCreatedDate(Date date);
    List<BillEntity> findByCode(String code);
}
