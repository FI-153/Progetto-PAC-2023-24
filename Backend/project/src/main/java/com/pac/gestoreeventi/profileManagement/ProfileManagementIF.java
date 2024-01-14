package com.pac.gestoreeventi.profileManagement;

import java.util.List;

public interface ProfileManagementIF {
    /**
     * Funzione che restituisce tutti gli eventi a cui l'utente è iscritto.
     */
    public void getSignupEvents();

    /**
     * Funzione che restituisce tutti i dettagli del profilo.
     */
    public void getProfileDetails();

    /**
     * Funzione per l'iscrizione ad un evento.
     */
    public void insertEventSignup();

    /**
     * Funzione per annullare l'iscrizione ad un evento.
     */
    public void deleteEventSignup();
    
	/**
	 * Restituisce le informazioni dell'utente che sta eseguendo
	 * il login.
	 * 
	 * @param userInfo username e password dell'utente che sta eseguendo il login.
	 * @return UserDTO dell'utente che sta eseguendo il login.
	 */
	public ProfileDTO login(UserDetailsImpl userInfo);

    public Profile getProfile(Integer idProfile);

    /**
	 * Restituisce tutti gli utenti registrati.
	 * 
	 * @return List<ProfileDTO> informazioni degli utenti.
	 */
	public List<ProfileDTO> getProfiles();
	
	/**
	 * Restituisce un particolare utente.
	 * 
	 * @param idProfile id dell'utente richiesto.
	 * @return ProfileDTO dell'utente avente idProfile.
	 */
	public ProfileDTO getProfileDTO(Integer idProfile);
	
	/**
	 * Inserisce un nuovo utente nel sistema.
	 * 
	 * @param profileDto Informazioni dell'utente da inserire.
	 * @return ProfileDTO dell'utente inserito.
	 */
	public ProfileDTO addProfile(ProfileDTO profileDto);
	
	/**
	 * Modifica un utente giÃ  presente nel sistema.
	 * 
	 * @param profileDto Nuove informazioni dell'utente da modificare.
	 * @return ProfileDTO dell'utente dopo le modifiche.
	 */
	public ProfileDTO modifyProfile(ProfileDTO profileDto);
	
	/**
	 * Cancella un utente dal sistema.
	 * 
	 * @param idProfile id dell'utente da cancellare.
	 */
	public void deleteProfile(Integer idProfile);
}