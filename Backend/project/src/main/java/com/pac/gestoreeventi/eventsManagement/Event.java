package com.pac.gestoreeventi.eventsManagement;

import javax.persistence.*;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.pac.gestoreeventi.profileManagement.Profile;
import com.pac.gestoreeventi.reservationManagement.Reservation;
import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

@Table(name = "event")
@Entity
public class Event {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column
    private String name;

    @Column
    private String place;

    @Enumerated(EnumType.STRING)
    private EventLevel difficulty;

    @Column
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "dd-MM-yyyy")
    private Date date;

    @Column
    private String description;

    @Column
    private String distance;

    @Column
    private String heightLevel;

    @Column
    private String minHeight;

    @Column
    private String tools;

    @Column
    private String meetingPlace;

    @Column
    private Integer maxPeople;

    @Column
    private String time;
    
    @ManyToOne
    @JoinColumn(name = "idProfile")
    @JsonIgnore
    private Profile profile;

    @OneToMany(mappedBy = "event", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore
    private List<Reservation> reservations = new ArrayList<>();

    public Event() {
    }

    public Event(Integer id, String name, String place, EventLevel difficulty, Date date, String description,
            String distance, String heightLevel, String minHeight, String tools, String meetingPlace, String time,
            Integer maxPeople) {
        this.id = id;
        this.name = name;
        this.place = place;
        this.difficulty = difficulty;
        this.date = date;
        this.description = description;
        this.distance = distance;
        this.heightLevel = heightLevel;
        this.minHeight = minHeight;
        this.tools = tools;
        this.meetingPlace = meetingPlace;
        this.time = time;
        this.maxPeople = maxPeople;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public EventLevel getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(EventLevel difficulty) {
        this.difficulty = difficulty;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDistance() {
        return distance;
    }

    public void setDistance(String distance) {
        this.distance = distance;
    }

    public String getHeightLevel() {
        return heightLevel;
    }

    public void setHeightLevel(String heightLevel) {
        this.heightLevel = heightLevel;
    }

    public String getMinHeight() {
        return minHeight;
    }

    public void setMinHeight(String minHeight) {
        this.minHeight = minHeight;
    }

    public String getTools() {
        return tools;
    }

    public void setTools(String tool) {
        this.tools = tool;
    }

    public String getMeetingPlace() {
        return meetingPlace;
    }

    public void setMeetingPlace(String meetingPlace) {
        this.meetingPlace = meetingPlace;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Integer getMaxPeople() {
        return maxPeople;
    }

    public void setMaxPeople(Integer maxPeople) {
        this.maxPeople = maxPeople;
    }

    public List<Reservation> getReservations() {
        return reservations;
    }

    public void setChildren(Reservation reservation) {
        this.reservations.add(reservation);
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public Profile getProfile() {
        return profile;
    }
}
