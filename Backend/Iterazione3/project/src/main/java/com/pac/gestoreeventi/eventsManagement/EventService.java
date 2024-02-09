package com.pac.gestoreeventi.eventsManagement;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import com.pac.gestoreeventi.profileManagement.Profile;
import com.pac.gestoreeventi.profileManagement.ProfileService;
import com.pac.gestoreeventi.reservationManagement.Reservation;
import com.pac.gestoreeventi.reservationManagement.ReservationRepository;
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
    private ReservationRepository  reservationRepository;

    @Autowired
    private ProfileService profileService;

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
        modelMapper.getConfiguration().setAmbiguityIgnored(true);
        Event event = modelMapper.map(eventDTO,Event.class);
        event.setProfile(profileService.getProfile(eventDTO.getIdProfile()));
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

    @Override
    public List<Profile> closeEventReservations(Integer idEvent) {
        Event event = eventRepository.findById(idEvent).get();

        List<Profile> profilesList = new ArrayList<Profile>();
        for(Reservation reservation : event.getReservations()){
            profilesList.add(reservation.getProfile());
        }

        List<Profile> list = selezionaIscritti(profilesList,event);
        for(Reservation reservation : event.getReservations()){
            if(list.contains(reservation.getProfile())){
                reservation.setConfirmation(true);
               reservationRepository.save(reservation);
            } else{
                reservation.setConfirmation(false);
                reservationRepository.save(reservation);
            }
        }

       return list;
    }

    ////ALGORITMO
    private List<Profile> selezionaIscritti(List<Profile> listaIscritti, Event event) {
        List<Profile> S = new ArrayList<>();
        int limiteMax = event.getMaxPeople();

        if (listaIscritti.size() <= limiteMax) {
            //se il numero di iscritti è inferiore del numero di posti, vengono tutti confermati
            S.addAll(listaIscritti);
        } else {
            int livelloTarget = event.getDifficultyLevel();
            int i = 0;  // Numero di posti occupati
            int j = 0;  // Distanza dal livello target

            while ((i != limiteMax) && (!listaIscritti.isEmpty())) {
                Profile utenteConfermato = seleziona(listaIscritti, livelloTarget, j);
                if(utenteConfermato != null){
                    listaIscritti.remove(utenteConfermato);
                    S.add(utenteConfermato);
                    i++;
                }
                //se non ci sono altri iscritti di livello target +/- j e ci sono ancora posti liberi, si passa
                //a considerare gli iscritti con livello immediatamente inferiore o superiore
                boolean foundUser = false;
                for (Profile profile : listaIscritti) {
                    if (profileService.profileLevel(profile.getId()) == livelloTarget + j || profileService.profileLevel(profile.getId()) == livelloTarget - j) {
                        foundUser = true;
                    }
                }
                if (!foundUser) {
                    j++;
                }
            }
        }
        return S;
    }

    private Profile seleziona(List<Profile> listaIscritti, int livello, int distanza) {
        // Restituisce un utente con un livello pari a livello + distanza o livello - distanza
        for (Profile profile : listaIscritti) {
            if (profileService.profileLevel(profile.getId()) == livello + distanza || profileService.profileLevel(profile.getId()) == livello - distanza) {
                return profile;
            }
        }
        return null;
    }

}
