package com.pac.gestoreeventi.reservationManagement;


import com.pac.gestoreeventi.eventsManagement.EventService;
import com.pac.gestoreeventi.profileManagement.ProfileService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ReservationService implements ReservationManagementIF{

    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private ModelMapper modelMapper;
    private EventService eventService;
    private ProfileService profileService;

    ReservationService(EventService eventService,ProfileService profileService){
        this.eventService = eventService;
        this.profileService = profileService;
    }

    @Override
    public void createReservation(ReservationDTO reservationDTO) {
            Reservation reservation = modelMapper.map(reservationDTO,Reservation.class);
            
            if(eventService.getEvent(reservationDTO.getIdEvent()) == null) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Event not found");
            }

            if(profileService.getProfile(reservationDTO.getIdProfile()) == null) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Profile not found");
            }
            
            reservation.setConfirmation(false);
            reservation.setEvent(eventService.getEvent(reservationDTO.getIdEvent()));
            reservation.setProfile(profileService.getProfile(reservationDTO.getIdProfile()));
            reservationRepository.save(reservation);
    }

    @Override
    public void deleteReservation(Integer idReservation) {
        Optional<Reservation> reservation = reservationRepository.findById(idReservation);

        if(!reservation.isPresent()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Request received. No reservation to delete found");
        }
        reservationRepository.delete(reservation.get());
    }

    @Override
    public List<ReservationDTO> getReservations() {
        return reservationRepository.findAll().stream()
                .map(reservation -> modelMapper.map(reservation, ReservationDTO.class)).collect(Collectors.toList());
    }

    @Override
    public Reservation getReservations(Integer idReservation) {
        Optional<Reservation> reservation = reservationRepository.findById(idReservation);

        if(!reservation.isPresent()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"No reservation found");
        }
        return reservation.get();
    }
}
