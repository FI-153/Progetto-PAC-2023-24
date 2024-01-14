package com.pac.gestoreeventi.eventsManagement;

import javax.persistence.*;
import java.sql.Time;
import java.util.Date;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

public class EventDTO {

    private Integer idEvent;

    private String name;

    private String place;

    private EventLevel difficulty;

    private Date date;

    private String description;

    private String distance;

    private String heightLevel;

    private String minHeight;

    private String tools;

    private String meetingPlace;

    private Integer maxPeople;

    private String time;

    public EventDTO(){

    }

    public EventDTO(Event e){
        this.idEvent = e.getId();
        this.name = e.getName();
        this.place = e.getPlace();
        this.difficulty = e.getDifficulty();
        this.date = e.getDate();
        this.description = e.getDescription();
        this.distance = e.getDistance();
        this.heightLevel = e.getHeightLevel();
        this.minHeight = e.getMinHeight();
        this.tools = e.getTools();
        this.meetingPlace = e.getMeetingPlace();
        this.time = e.getTime();
        this.maxPeople = e.getMaxPeople();
    }

    public Integer getIdEvent() {
        return idEvent;
    }

    public void setIdEvent(Integer id) {
        this.idEvent = id;
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

    public void setTools(String tools) {
        this.tools = tools;
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
}
