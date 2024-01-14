package com.pac.gestoreeventi.reservationManagement;

import java.util.List;

public interface ReservationManagementIF {
    void createReservation(ReservationDTO reservationDTO);

    void deleteReservation(Integer idReservation);

    List<ReservationDTO> getReservations();
}
