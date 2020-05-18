package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.entity.UserEntity;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
	UserEntity findOneByUserNameAndStatus(String name, int status);
	List<UserEntity> findByStatus(int status);
}
