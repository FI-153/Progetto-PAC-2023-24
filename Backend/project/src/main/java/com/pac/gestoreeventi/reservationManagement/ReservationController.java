package com.pac.gestoreeventi.reservationManagement;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ReservationController {


    private final ReservationService  reservationService;


    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    @PostMapping(path = "events/reservation")
    private String createReservation(@RequestBody ReservationDTO  reservationDTO){
            reservationService.createReservation(reservationDTO);
            return "Aggiunta nuova prenotazione";
    }

    @GetMapping (path = "events/reservation")
    private List<ReservationDTO> getReservation(){
        return reservationService.getReservations();
    }

    @DeleteMapping(path = "/profile/{idReservation}")
    public String deleteEvent(@PathVariable("idReservation") Integer idReservation){
        reservationService.deleteReservation(idReservation);
        return "Prenotazione eliminata";
    }
}
