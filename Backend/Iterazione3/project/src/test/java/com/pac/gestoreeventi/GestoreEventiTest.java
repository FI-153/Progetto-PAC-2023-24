package com.pac.gestoreeventi;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import com.pac.gestoreeventi.config.SecurityConfiguration;
import com.pac.gestoreeventi.eventsManagement.Event;
import com.pac.gestoreeventi.eventsManagement.EventLevel;
import com.pac.gestoreeventi.eventsManagement.EventRepository;
import com.pac.gestoreeventi.eventsManagement.EventService;
import com.pac.gestoreeventi.profileManagement.Profile;
import com.pac.gestoreeventi.profileManagement.ProfileRepository;
import com.pac.gestoreeventi.profileManagement.ProfileRole;
import com.pac.gestoreeventi.profileManagement.ProfileService;
import com.pac.gestoreeventi.reservationManagement.Reservation;
import com.pac.gestoreeventi.reservationManagement.ReservationRepository;

// @SpringBootTest
// @ExtendWith(SpringExtension.class)
@DataJpaTest
class GestoreEventiTest {

	// private final ServiceTest serviceTest;

	// @Autowired
	// GestoreEventiTest(ServiceTest serviceTest){
	// 	// this.eventRepoTest = eventRepoTest;		
	// 	// this.reservationRepoTest = reservationRepoTest;
	// 	// this.profileRepoTest = profileRepoTest;
	// 	// this.eventService = eventService;
	// 	this.serviceTest = serviceTest;
	// }

	@Test
	void createProfiles() {
			
		// //profile organizer
		// Profile profileO1 = new Profile(1, "Mario", "Rossi", "mario.rossi@unibg.it", "maro", ProfileRole.ADMIN);
		// profileRepoTest.save(profileO1);

		// //create event
		// Event event1 = new Event("Test name", "Test place", EventLevel.EASY, new Date(100), "Test description", "Test distance", "Test HeightLevel", "Test minHeight", "Test tools", "Test meetingPlace", "Test time", new Integer(5));
		// eventRepoTest.save(event1);

		// //profile user
		// Profile profileU1 = new Profile(3, "Giuseppe", "Verdi", "giuseppe.verdi@unibg.it", "give", ProfileRole.USER);
		// Profile profileU2 = new Profile(4, "Gaetano", "Donizzetti", "gaetano.donizzetti@unibg.it", "gado", ProfileRole.USER);
		// Profile profileU3 = new Profile(5, "Vincenzo", "Bellini", "vincenzo.bellini@unibg.it", "vibe", ProfileRole.USER);
		// Profile profileU4 = new Profile(6, "Ruggero", "Leoncavallo", "regguero.leoncavallo@unibg.it", "rele", ProfileRole.USER);
		// profileRepoTest.save(profileU1);
		// profileRepoTest.save(profileU2);
		// profileRepoTest.save(profileU3);
		// profileRepoTest.save(profileU4);

		// List<Profile> profili = profileRepoTest.findAll();

		// //create reservations
		// Reservation reservation1 = new Reservation(profileU1, event1, new Date(200) , false);
		// Reservation reservation2 = new Reservation(profileU2, event1, new Date(200) , false);
		// reservationRepoTest.save(reservation1);
		// reservationRepoTest.save(reservation2);

		// // eventService.closeEventReservations(event1.getId());

		// // List<Reservation> prenotazioni = reservationRepoTest.findAll();

		// // Reservation result = reservationRepoTest.findById(reservation1.getId()).get();

		// // //then
		// // assertTrue(result.getConfirmation());

		// assertEquals("Ciao", serviceTest.toString());
	}
}
