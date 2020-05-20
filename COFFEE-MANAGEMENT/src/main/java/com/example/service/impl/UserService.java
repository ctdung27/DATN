package com.example.service.impl;

import com.example.converter.UserConverter;
import com.example.dto.UserDTO;
import com.example.entity.RoleEntity;
import com.example.entity.UserEntity;
import com.example.repository.RoleRepository;
import com.example.repository.UserRepository;
import com.example.service.IUserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class UserService implements IUserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserConverter userConverter;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public List<UserDTO> findAll() {
        List<UserEntity> results = userRepository.findByStatus(1);
        return results.stream().map(item -> userConverter.convertToDto(item)).collect(Collectors.toList());
    }

    @Override
    public UserDTO findById(long id) {
        UserEntity userEntity = userRepository.findOne(id);
        UserDTO userDTO = userConverter.convertToDto(userEntity);
        userDTO.setRoleCode(userEntity.getRoles().get(0).getCode());
        return userDTO;
    }

    @Override
    @Transactional
    public UserDTO insert(UserDTO userDTO) {
        RoleEntity role = roleRepository.findOneByCode(userDTO.getRoleCode());
        UserEntity userEntity = userConverter.convertToEntity(userDTO);
        userEntity.setRoles(Stream.of(role).collect(Collectors.toList()));
        userEntity.setStatus(1);
        userEntity.setPassword(passwordEncoder.encode("123456"));
        return userConverter.convertToDto(userRepository.save(userEntity));
    }

    @Override
    @Transactional
    public UserDTO update(UserDTO userDTO) {
        RoleEntity role = roleRepository.findOneByCode(userDTO.getRoleCode());
        UserEntity oldUser = userRepository.findOne(userDTO.getId());
        oldUser.setUserName(userDTO.getUserName());
        oldUser.setFullName(userDTO.getFullName());
        oldUser.setDiachi(userDTO.getDiachi());
        oldUser.setEmail(userDTO.getEmail());
        oldUser.setSdienthoai(userDTO.getSdienthoai());
        
        oldUser.setRoles(Stream.of(role).collect(Collectors.toList()));
        if (StringUtils.isNotBlank(userDTO.getPassword())) {
            oldUser.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        }
        return userConverter.convertToDto(userRepository.save(oldUser));
    }

    @Override
    @Transactional
    public void deleteUser(long[] ids) {
        for (Long item : ids) {
            UserEntity userEntity = userRepository.findOne(item);
            userEntity.setStatus(0);
            userRepository.save(userEntity);
        }
    }

    @Override
    @Transactional
    public UserDTO updateProfile(UserDTO userDTO) {
        UserEntity oldUser = userRepository.findOne(userDTO.getId());
        oldUser.setUserName(userDTO.getUserName());
        oldUser.setFullName(userDTO.getFullName());
        oldUser.setDiachi(userDTO.getDiachi());
        oldUser.setEmail(userDTO.getEmail());
        oldUser.setSdienthoai(userDTO.getSdienthoai());
        if (StringUtils.isNotBlank(userDTO.getPassword())) {
            oldUser.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        }
        return userConverter.convertToDto(userRepository.save(oldUser));
    }
}
