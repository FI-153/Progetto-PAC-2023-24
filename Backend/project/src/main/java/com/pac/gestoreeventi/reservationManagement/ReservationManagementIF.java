package com.pac.gestoreeventi.reservationManagement;

public interface ReservationManagementIF {
    void createReservation(ReservationDTO reservationDTO);

    void deleteReservation(Integer idReservation);
}
