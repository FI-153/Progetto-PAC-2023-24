package com.pac.gestoreeventi.profileManagement;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProfileRepository extends JpaRepository<Profile, Integer> {
    Optional<Profile> findById(int idProfile);
    Optional<Profile> findByEmail(String email);
}
