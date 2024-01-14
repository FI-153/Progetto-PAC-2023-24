package com.pac.gestoreeventi.eventsManagement;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class EventService implements EventsManagementIF{

    @Autowired
	private EventRepository eventRepository;

	@Autowired
	private ModelMapper modelMapper;

    @Override
    public List<EventDTO> getEvents() {
        return eventRepository.findAll().stream()
        .map(event -> modelMapper.map(event, EventDTO.class)).collect(Collectors.toList());
    }

    @Override
    public void getReccomendedEvents() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'get_reccomendedEvents'");
    }

    @Override
    public void getEventDetails() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'get_eventDetails'");
    }

    @Override
    public void getEventWeather() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'get_eventWeather'");
    }

    @Override
    public void insertEvent(EventDTO eventDTO) {
        Event event = modelMapper.map(eventDTO,Event.class);
        eventRepository.save(event);
    }

    @Override
    public Event getEvent(Integer idEvent) {
        Optional<Event> event = eventRepository.findById(idEvent);

        if(!event.isPresent()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"No event found");
        }
        return event.get();
    }

    @Override
    public void deleteEvent(Integer idEvent) {
        Optional<Event> event = eventRepository.findById(idEvent);

        if(!event.isPresent()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Request received. No event to delete found");
        }

         eventRepository.delete(event.get());
    }

}
