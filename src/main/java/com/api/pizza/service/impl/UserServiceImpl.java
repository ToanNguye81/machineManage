package com.api.pizza.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.api.pizza.entity.User;
import com.api.pizza.repository.UserRepository;
import com.api.pizza.security.UserPrincipal;
import com.api.pizza.service.UserService;

import java.util.HashSet;
import java.util.Set;

/* cung cấp các phương thức để tương tác với thông tin người dùng trong cơ sở dữ liệu,
 bao gồm cả việc tạo người dùng mới và truy vấn thông tin người dùng dựa trên tên người dùng. */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User createUser(User user) {
        return userRepository.saveAndFlush(user);
    }

    @Override
    public UserPrincipal findByUsername(String username) {
        User user = userRepository.findByUsername(username);
        UserPrincipal userPrincipal = new UserPrincipal();
        if (null != user) {
            Set<String> authorities = new HashSet<>();
            if (null != user.getRoles())
                user.getRoles().forEach(r -> {
                    authorities.add(r.getRoleKey());
                    r.getPermissions().forEach(p -> authorities.add(p.getPermissionKey()));
                });

            userPrincipal.setUserId(user.getId());
            userPrincipal.setUsername(user.getUsername());
            userPrincipal.setPassword(user.getPassword());
            userPrincipal.setAuthorities(authorities);
        }
        return userPrincipal;
    }

}
