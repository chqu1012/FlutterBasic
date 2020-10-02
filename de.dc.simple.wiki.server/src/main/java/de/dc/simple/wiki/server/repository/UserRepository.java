package de.dc.simple.wiki.server.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import de.dc.simple.wiki.server.model.User;

public interface UserRepository extends JpaRepository<User, Long>{

	List<User> findByUsernameAndPassword(String username, String password);

	List<User> findByUsername(String username);

}
