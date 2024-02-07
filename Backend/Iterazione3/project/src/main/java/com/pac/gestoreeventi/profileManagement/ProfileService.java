package com.pac.gestoreeventi.profileManagement;


import com.pac.gestoreeventi.eventsManagement.Event;
import com.pac.gestoreeventi.eventsManagement.EventRepository;
import com.pac.gestoreeventi.reservationManagement.Reservation;
import com.pac.gestoreeventi.reservationManagement.ReservationRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ProfileService implements ProfileManagementIF, UserDetailsService {

    @Autowired
    private ProfileRepository profileRepository;
	
	@Autowired
	private EventRepository eventRepository;

	@Autowired
	private ReservationRepository reservationRepository;
    @Autowired
    private ModelMapper modelMapper;

    @Override
    public void getSignupEvents() {

    }

    @Override
    public void getProfileDetails() {

    }

    @Override
    public void insertEventSignup() {

    }

    @Override
    public void deleteEventSignup() {

    }

    @Override
    public Profile getProfile(Integer idProfile) {
        Optional<Profile> profile = profileRepository.findById(idProfile);

        return profile.get();
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<Profile> user = profileRepository.findByEmail(email);

        user.orElseThrow(() -> new UsernameNotFoundException(email + " not found."));

        return user.map(UserDetailsImpl::new).get();
    }

    @Override
	public ProfileDTO login(UserDetailsImpl userInfo) {
		Optional<Profile> profile = profileRepository.findByEmail(userInfo.getUsername());

        profile.orElseThrow(() -> new UsernameNotFoundException(userInfo.getUsername() + " not found."));

		return modelMapper.map(profile.get(), ProfileDTO.class);
	}

	@Override
	public List<ProfileDTO> getProfiles() {
		return profileRepository.findAll(Sort.by(Sort.Direction.ASC, "id")).stream()
				.map(profile -> modelMapper.map(profile, ProfileDTO.class)).collect(Collectors.toList());
	}

	@Override
	public ProfileDTO getProfileDTO(Integer idProfile) {
		Optional<Profile> profile = profileRepository.findById(idProfile);

		if (!profile.isPresent())
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User doesn't exist");

		return modelMapper.map(profile.get(), ProfileDTO.class);
	}

	@Override
	public ProfileDTO addProfile(ProfileDTO profileDto) {
		Optional<Profile> user = profileRepository.findByEmail(profileDto.getEmail());

		if (user.isPresent())
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "User already exists");
		
		Profile newProfile = modelMapper.map(profileDto, Profile.class);
		newProfile = profileRepository.save(newProfile);
		
		return modelMapper.map(newProfile, ProfileDTO.class);
	}

	@Override
	public ProfileDTO modifyProfile(ProfileDTO profileDto) {
		Optional<Profile> profileToModify = profileRepository.findByEmail(profileDto.getEmail());

		if (!profileToModify.isPresent())
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No user to delete");

		Profile profile = profileToModify.get();

		modelMapper.map(profileDto, profile);

		return modelMapper.map(profileRepository.save(profile), ProfileDTO.class);
	}

	@Override
	public void deleteProfile(Integer idProfile) {
		Optional<Profile> profileToDelete = profileRepository.findById(idProfile);

		if (!profileToDelete.isPresent())
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No user to delete");

		profileRepository.delete(profileToDelete.get());
	}

	@Override
	public List<Reservation> profileReservations(Integer idProfile){
		List<Reservation> profileReservations = reservationRepository.findByProfileId(idProfile);
		List<Reservation> profileReservationsConfirmed = new ArrayList<>();

		for(Reservation reservation : profileReservations){
			if(reservation.getConfirmation() == true){
				profileReservationsConfirmed.add(reservation);
			}
		}

		return profileReservationsConfirmed;
	}
	@Override
	public int profileLevel(Integer idProfile){
		List<Reservation> profileReservations = reservationRepository.findByProfileId(idProfile);
		List<Event> profileEvents = new ArrayList<>();
		for(Reservation reservation: profileReservations){
			if(reservation.getConfirmation() == true) {
				Optional<Event> event = eventRepository.findById((reservation.getEvent().getId()));
				profileEvents.add(event.get());
			}
		}

		int level = profileEvents.stream().mapToInt(event -> event.getDifficultyLevel()).sum();

		return (profileEvents.size() == 0) ? 10 : level/profileEvents.size();
	}
}
