package com.kcc.pms.auth;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
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

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, SessionRegistry sessionRegistry) throws Exception {
        http.csrf(csrf -> csrf
                .ignoringRequestMatchers("/**")
                .requireCsrfProtectionMatcher(request -> request.getRequestURI().equals("/loginForm"))
        );
        http.authorizeHttpRequests(authorizeRequests ->
                        authorizeRequests
                                .requestMatchers("/projects/**").authenticated()
                                .requestMatchers(request -> "XMLHttpRequest".equals(request.getHeader("X-Requested-With"))).permitAll()
                                .anyRequest().permitAll()
                )
                .formLogin(formLogin -> formLogin
                        .loginPage("/loginForm")
                        .loginProcessingUrl("/login")
                        .successHandler((request, response, authentication) -> {
                            SavedRequestAwareAuthenticationSuccessHandler defaultHandler = new SavedRequestAwareAuthenticationSuccessHandler();
                            defaultHandler.setDefaultTargetUrl("/projects/list?type=projectList");
                            defaultHandler.onAuthenticationSuccess(request, response, authentication);
                        })
                        .failureHandler(authenticationFailureHandler())
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/loginForm")
                        .invalidateHttpSession(true)
                        .addLogoutHandler((request, response, auth) -> {
                            // 모든 세션을 순회하면서 만료
                            for (Object principal : sessionRegistry.getAllPrincipals()) {
                                sessionRegistry.getAllSessions(principal, false).forEach(sessionInfo -> {
                                    try {
                                        sessionInfo.expireNow();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                });
                            }
                        })
                )
                .headers(headers -> headers
                        .frameOptions(HeadersConfigurer.FrameOptionsConfig::sameOrigin))
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        .authenticationEntryPoint((request, response, authException) -> {
                            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                                response.setContentType("application/json");
                                response.getWriter().write("{\"error\": \"Unauthorized\", \"loginUrl\": \"/members/loginForm\"}");
                            } else {
                                response.sendRedirect("/loginForm");
                            }
                        })
                )
                .sessionManagement(sessionManagement ->
                        sessionManagement.maximumSessions(-1).sessionRegistry(sessionRegistry)
                );

        return http.build();
    }

    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
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
