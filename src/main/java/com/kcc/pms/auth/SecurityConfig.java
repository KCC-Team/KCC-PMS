package com.kcc.pms.auth;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import java.io.IOException;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public BCryptPasswordEncoder encodePwd() {
        return new BCryptPasswordEncoder();
    }

//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        return NoOpPasswordEncoder.getInstance();
//    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf
                .ignoringRequestMatchers("/**") // 모든 경로에 대해 기본적으로 CSRF 비활성화
                .requireCsrfProtectionMatcher(request -> {
                    String uri = request.getRequestURI();
                    return uri.equals("/loginForm"); // 로그인 페이지에서만 CSRF 활성화
                })
        );
        http.authorizeHttpRequests(authorizeRequests ->
                        authorizeRequests
                                .requestMatchers("/projects/**").authenticated()
                                .requestMatchers(request -> "XMLHttpRequest".equals(request.getHeader("X-Requested-With"))).permitAll()
                                .anyRequest().permitAll()
                ).formLogin(formLogin -> formLogin.loginPage("/loginForm") // 로그인 페이지 지정
                        .loginProcessingUrl("/login") // 컨트롤러 지정 없이 시큐리티에서 로그인 진행
                        .successHandler((request, response, authentication) -> {
                            String prevPage = (String) request.getSession().getAttribute("prevPage");
                            if (prevPage != null) {
                                response.sendRedirect(prevPage);
                            } else {
                                SavedRequestAwareAuthenticationSuccessHandler defaultHandler = new SavedRequestAwareAuthenticationSuccessHandler();
                                defaultHandler.setDefaultTargetUrl("/projects/list?type=projectList"); // 기본 경로 설정
                                defaultHandler.onAuthenticationSuccess(request, response, authentication);
                            }
                        })
                        .failureHandler(authenticationFailureHandler())) // 로그인 실패 시 처리할 핸들러 설정
                .logout(logout -> logout
                        .logoutUrl("/logout") // 로그아웃 요청 경로
                        .logoutSuccessUrl("/loginForm") // 로그아웃 성공 시 이동할 경로
                        .invalidateHttpSession(true)
                )
                .headers(headers -> headers
                        .frameOptions(HeadersConfigurer.FrameOptionsConfig::sameOrigin)) // 보안 헤더 설정 추가
                // 인증되지 않은 AJAX 요청에 대해 401 반환
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        .authenticationEntryPoint((request, response, authException) -> {
                            // AJAX 요청 여부 확인
                            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                                // AJAX 요청에 대해서는 401 Unauthorized 상태 코드 반환
                                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                                response.setContentType("application/json");
                                response.getWriter().write("{\"error\": \"Unauthorized\", \"loginUrl\": \"/members/loginForm\"}");
                            } else {
                                // 일반 요청에 대해서는 로그인 페이지로 리디렉션
                                response.sendRedirect("/loginForm");
                            }
                        })
                );

        return http.build();
    }

    @Bean
    public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedDoubleSlash(true); // 이중 슬래시 허용
        return firewall;
    }

    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return new SimpleUrlAuthenticationFailureHandler() {
            @Override
            public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, IOException {
                // 로그인 실패 시 메시지를 설정하고 리디렉션
                response.sendRedirect("/loginForm?error=true");
            }
        };
    }
}
