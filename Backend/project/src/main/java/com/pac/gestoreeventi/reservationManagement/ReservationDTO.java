package com.pac.gestoreeventi.reservationManagement;


import java.util.Date;

public class ReservationDTO {
    private Integer idReservation;

    private Integer idProfile;
    private Integer idEvent;
    private Date datetime;
    private Boolean confirmation;

    public void setIdProfile(Integer idProfile) {
        this.idProfile = idProfile;
    }

    public void setIdEvent(Integer idEvent) {
        this.idEvent = idEvent;
    }

    public void setDatetime(Date datetime) {
        this.datetime = datetime;
    }

    public void setConfirmation(Boolean confirmation) {
        this.confirmation = confirmation;
    }

    public Integer getIdReservation() {
        return idReservation;
    }

    public Integer getIdProfile() {
        return idProfile;
    }

    public Integer getIdEvent() {
        return idEvent;
    }

    public Date getDatetime() {
        return datetime;
    }

    public Boolean getConfirmation() {
        return confirmation;
    }
}
