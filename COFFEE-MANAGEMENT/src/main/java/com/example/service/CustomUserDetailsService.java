package com.example.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.constant.SystemConstant;
import com.example.dto.MyUser;
import com.example.entity.RoleEntity;
import com.example.entity.UserEntity;
import com.example.repository.UserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private UserRepository userRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserEntity userEntity = userRepository.findOneByUserNameAndStatus(username, SystemConstant.ACTIVE_STATUS);   // xử lí username ( password đc spring xử lí ngầm)
		
		if (userEntity == null) {                                              
			throw new UsernameNotFoundException("User Not Found");      // đăng nhập fail ---> security.xml -->  authentication-failure-url="/login?incorrectAccount"/>
		}
		
		
		
		//put thong tin vao security để duy trì thông tin đó khi user login vào hệ thống
		List<GrantedAuthority> authorities = new ArrayList<>();              // authorities  :vai trò
		for (RoleEntity role: userEntity.getRoles()) {
			authorities.add(new SimpleGrantedAuthority(role.getCode()));
		}
		MyUser myUser = new MyUser(userEntity.getUserName(), userEntity.getPassword(), 
							true, true, true, true, authorities);
		myUser.setFullName(userEntity.getFullName());
		myUser.setId(userEntity.getId());
		return myUser;
	}

}
