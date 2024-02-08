package com.pac.gestoreeventi;


import java.sql.Time;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.pac.gestoreeventi.eventsManagement.*;


@DataJpaTest
class EventRepositoryTest {

	@Autowired
	private EventRepository underTest;
	
	@Test
	void findById() {
			
		String stringaTest = "test";
		//given
		Date date = new Date(100);
		Event expected = new Event(2, stringaTest, stringaTest, EventLevel.MEDIUM, date, stringaTest, stringaTest, stringaTest, stringaTest, stringaTest, stringaTest, stringaTest, new Integer(4));
		underTest.save(expected);
		
		List<Event> lista = underTest.findAll();

		//when
		Event result = underTest.findById(expected.getId()).get();
		
		//then
		assertEquals(expected.getDescription(), result.getDescription());
	}
}