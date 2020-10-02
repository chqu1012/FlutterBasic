package de.dc.simple.wiki.server.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import de.dc.simple.wiki.server.model.User;

public interface UserRepository extends JpaRepository<User, Long>{

}
