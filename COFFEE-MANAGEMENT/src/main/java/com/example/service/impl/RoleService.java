package com.example.service.impl;

import com.example.repository.RoleRepository;
import com.example.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class RoleService implements IRoleService {

    @Autowired
    private RoleRepository roleRepository;

    @Override
    public Map<String, String> getRoles() {
        Map<String, String> results = new HashMap<>();
        roleRepository.findAll().forEach(item -> results.put(item.getCode(), item.getName()));
        return results;
    }
}
