package com.pac.gestoreeventi.profileManagement;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;

public class ProfileDTO {

    private Integer id;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String password;
    @Enumerated(EnumType.STRING)
    private ProfileRole profileRole;
  
    public ProfileDTO(){

    }
    
    public ProfileDTO(Integer id, String firstName, String lastName, String email, String phone, String password,
            ProfileRole profileRole) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.profileRole = profileRole;
    }

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public ProfileRole getProfileRole() {
        return profileRole;
    }
    public void setProfileRole(ProfileRole profileRole) {
        this.profileRole = profileRole;
    }
}
