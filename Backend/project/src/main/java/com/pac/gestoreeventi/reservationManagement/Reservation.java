package com.pac.gestoreeventi.reservationManagement;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.pac.gestoreeventi.eventsManagement.Event;
import com.pac.gestoreeventi.profileManagement.Profile;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "reservation")
public class Reservation {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "idProfile")
    private Profile profile;

    @ManyToOne
    @JoinColumn(name = "idEvent")
    private Event event;

    @Column
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern="dd-MM-yyyy hh:mm")
    private Date datetime;

    @Column
    private Boolean confirmation;

    public Reservation() {

    }
    public Reservation(Date datetime,Boolean confirmation) {
            this.datetime =  datetime;
            this.confirmation =  confirmation;
    }
    public void setDatetime(Date datetime) {
        this.datetime = datetime;
    }

    public void setConfirmation(Boolean confirmation) {
        this.confirmation = confirmation;
    }

    public Date getDatetime() {
        return datetime;
    }

    public Boolean getConfirmation() {
        return confirmation;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public Profile getProfile() {
        return profile;
    }

    public Event getEvent() {
        return event;
    }

    public Long getId() {
        return id;
    }
}