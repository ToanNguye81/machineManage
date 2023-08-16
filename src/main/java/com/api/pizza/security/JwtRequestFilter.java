package com.api.pizza.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import com.api.pizza.entity.Token;
import com.api.pizza.service.TokenService;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

<<<<<<< HEAD
//  kiểm tra và xác thực yêu cầu dựa trên thông tin chứa trong token JWT,
//  cập nhật thông tin xác thực vào SecurityContextHolder để cho phép truy cập an toàn vào các phần tử của ứng dụng.
=======
>>>>>>> 4bae4ffc16fb9c5849f13c41e8b82191c15ab5c4
@Component
public class JwtRequestFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private TokenService verificationTokenService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        // Lấy thông tin token từ header "Authorization"
        final String authorizationHeader = request.getHeader("Authorization");
        // Khởi tạo các biến lưu trữ thông tin về người dùng và token
        UserPrincipal user = null;
        Token token = null;
        // Nếu tồn tại "Authorization" header và bắt đầu bằng "Token "
        if (StringUtils.hasText(authorizationHeader) && authorizationHeader.startsWith("Token ")) {
            // Lấy JWT từ "Authorization" header (loại bỏ phần "Token ")
            String jwt = authorizationHeader.substring(6);
            // Giải mã JWT để lấy thông tin về người dùng
            user = jwtUtil.getUserFromToken(jwt);
            // Tìm kiếm thông tin token trong cơ sở dữ liệu dựa trên JWT
            token = verificationTokenService.findByToken(jwt);
        }
        // Nếu tồn tại thông tin về người dùng và token, kiểm tra tính hợp lệ của token
        if (null != user && null != token && token.getTokenExpDate().after(new Date())) {
            // Tạo danh sách các quyền (authorities) từ danh sách roles của người dùng
            Set<GrantedAuthority> authorities = new HashSet<>();
            user.getAuthorities().forEach(p -> authorities.add(new SimpleGrantedAuthority((String) p)));
            // Tạo đối tượng UsernamePasswordAuthenticationToken để xác thực người dùng
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, null,
                    authorities);
            // Đặt thông tin xác thực vào SecurityContextHolder
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        // Tiếp tục chuỗi bộ lọc (filter chain)
        filterChain.doFilter(request, response);
    }

}
