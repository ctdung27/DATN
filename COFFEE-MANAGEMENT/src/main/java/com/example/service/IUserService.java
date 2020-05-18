package com.example.service;

import com.example.dto.UserDTO;

import java.util.List;

public interface IUserService {
    List<UserDTO> findAll();
    UserDTO findById(long id);
    UserDTO insert(UserDTO userDTO);
    UserDTO update(UserDTO userDTO);
    void deleteUser(long[] ids);
    UserDTO updateProfile(UserDTO userDTO);
}
