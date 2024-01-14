package com.pac.gestoreeventi.profileManagement;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.pac.gestoreeventi.eventsManagement.Event;
import com.pac.gestoreeventi.reservationManagement.Reservation;

import javax.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Table(name = "profile")
@Entity
public class Profile {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column
    private String firstName;

    @Column
    private String lastName;

    @Column
    private String email;

    @Column
    private String phone;

    @Column
    private String password;

    @Enumerated(EnumType.STRING)
    private ProfileRole profileRole;

    @OneToMany(mappedBy = "profile", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private List<Event> events = new ArrayList<>();

    @OneToMany(mappedBy = "profile", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private List<Reservation> reservations = new ArrayList<>();

    public Profile(){

    }

    public Profile(Integer id, String firstName, String lastName, String email, String password, ProfileRole profileRole){
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.profileRole = profileRole;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setProfileRole(ProfileRole profileRole) {
        this.profileRole = profileRole;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public ProfileRole getProfileRole() {
        return profileRole;
    }

    public Integer getId() {
        return id;
    }

    public List<Event> getEvents() {
        return events;
    }

    public void setEvents(Event event) {
        this.events.add(event);
    }
    
    public List<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(Reservation reservation) {
        this.reservations.add(reservation);
    }
}
