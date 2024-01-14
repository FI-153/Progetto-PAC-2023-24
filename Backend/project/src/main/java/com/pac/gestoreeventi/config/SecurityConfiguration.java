package com.pac.gestoreeventi.config;

import com.pac.gestoreeventi.profileManagement.ProfileRole;
import com.pac.gestoreeventi.profileManagement.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.SecurityBuilder;
import org.springframework.security.config.annotation.SecurityConfigurerAdapter;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
     @Autowired
     private ProfileService profileService;

     @Override
     protected void configure(AuthenticationManagerBuilder auth) throws Exception {
         auth.userDetailsService(profileService);
     }

     @Override
     protected void configure(HttpSecurity http) throws Exception {
         http.authorizeRequests()
         //          .antMatchers(HttpMethod.GET, "/login").hasRole(UserRole.ADMINISTRATOR.toString(), 
         //        		  										 UserRole.FOREMAN.toString(),
         //        		  										 UserRole.VOLUNTEER.toString())
         //          .antMatchers(HttpMethod.GET, "/users").hasRole(UserRole.ADMINISTRATOR.toString())
         //          .antMatchers(HttpMethod.POST, "/users").hasRole(UserRole.ADMINISTRATOR.toString())
         //          .antMatchers(HttpMethod.DELETE, "/users").hasRole(UserRole.ADMINISTRATOR.toString())
         //		  .antMatchers(HttpMethod.PUT, "/users").hasAnyRole()
                         .anyRequest().authenticated().and().csrf().disable().sessionManagement()
                         .sessionCreationPolicy(SessionCreationPolicy.STATELESS).and().httpBasic();
     }

     @Bean
     public PasswordEncoder getPasswordEncoder() {
         return NoOpPasswordEncoder.getInstance();
     }
}
