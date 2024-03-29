package com.pac.gestoreeventi.reservationManagement;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation,Integer> {
    List<Reservation> findByEventId(Integer idEvent);
    List<Reservation> findByProfileId(Integer idProfile);

    Optional<Reservation> findById(Integer idReservation);
}
