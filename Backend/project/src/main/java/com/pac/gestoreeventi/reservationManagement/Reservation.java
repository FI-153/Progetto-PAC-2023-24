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
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "idProfile")
    private Profile profile;

    @ManyToOne
    @JoinColumn(name = "idEvent")
    private Event event;

    @Column
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern="dd-MM-yyyy")
    private Date datetime;

    @JsonIgnore
    @Column
    private Boolean confirmation;

    public Reservation() {

    }
    public Reservation(Integer id,Date datetime,Boolean confirmation) {
            this.id = id;
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

    public Integer getId() {
        return id;
    }
}
