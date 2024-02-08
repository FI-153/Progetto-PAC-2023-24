package com.pac.gestoreeventi;


import java.util.Date;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.pac.gestoreeventi.reservationManagement.*;

@DataJpaTest
class ReservationRepositoryTest {

	@Autowired
	private ReservationRepository underTest;
	
	@Test
	void findById() {
			
		//given
		Date date = new Date(100);
		Reservation expected = new Reservation(1, date, new Boolean(true));
		underTest.save(expected);
		
		//when
		Reservation result = underTest.findById(expected.getId()).get();
		
		//thenà
		assertEquals(expected.getId(), result.getId());
	}
}