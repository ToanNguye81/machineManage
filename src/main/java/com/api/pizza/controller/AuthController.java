package com.api.pizza.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.api.pizza.entity.Token;
import com.api.pizza.entity.User;
import com.api.pizza.security.JwtUtil;
import com.api.pizza.security.UserPrincipal;
import com.api.pizza.service.TokenService;
import com.api.pizza.service.UserService;

@RestController
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/register")
    public User register(@RequestBody User user) {
        user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
        return userService.createUser(user);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User user) {
        // Tìm kiếm user dựa trên username
        UserPrincipal userPrincipal = userService.findByUsername(user.getUsername());
        // Check username và password
        if (null == user || !new BCryptPasswordEncoder().matches(user.getPassword(), userPrincipal.getPassword())) {
            // Trả về lỗi nếu thông tin không chính xác
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("tài khoản hoặc mật khẩu không chính xác");
        }
        
        // Tạo một đối tượng Token và gán thông tin(token, ExpirationTime,userId)
        Token token = new Token();
        token.setToken(jwtUtil.generateToken(userPrincipal));
        token.setTokenExpDate(jwtUtil.generateExpirationDate());
        token.setId(userPrincipal.getUserId());
        tokenService.createToken(token);
        
        // Trả về token và thông tin tài khoản
        Map<String, Object> response = new HashMap<>();
        response.put("token", token.getToken());
        response.put("userId", userPrincipal.getUserId());
        response.put("username", userPrincipal.getUsername());
        // Response đã tạo để gửi về phía client
        return ResponseEntity.ok(response);
    }


    @GetMapping("/hello")
    @PreAuthorize("hasAnyAuthority('USER_READ','USER_DELETE')")
    public ResponseEntity hello() {
        return ResponseEntity.ok("hello  have USER_READ OR USER_CREATE OR USER_UPDATE oR USER_DELETE");
    }

    @GetMapping("/hello2")
    @PreAuthorize("hasAnyAuthority('USER_READ','USER_DELETE')")
    public ResponseEntity hello2() {
        return ResponseEntity.ok("hello 2 have USER_READ OR USER_DELETE");
    }


    @GetMapping("/hello3")
    @PreAuthorize("hasAnyRole('ADMIN', 'CUSTOMER')")
    public ResponseEntity hello3() {
        return ResponseEntity.ok("hello cho ADMIN va CUSTOMER");
    }

    @GetMapping("/hello4")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity hello4() {
        return ResponseEntity.ok("hello chi cho ADMIN");
    }

    @GetMapping("/hello6")
    @PreAuthorize("hasRole('MANAGER')")
    public ResponseEntity hello6() {
        return ResponseEntity.ok("hello chi cho MANAGER");
    }

    // @PreAuthorize("hasRole('USER_READ') " +
    // "|| (hasRole('USER_DELETE')")
    @GetMapping("/hello7")
    @PreAuthorize("hasAnyAuthority('USER_DELETE')")
    public ResponseEntity hello7() {
        return ResponseEntity.ok("hello 2 have USER_DELETE");
    }

    @GetMapping("/hello5")
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public ResponseEntity hello5() {
        return ResponseEntity.ok("hello chi cho ADMIN");
    }
}
