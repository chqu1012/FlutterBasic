package de.dc.simple.wiki.server.service;

import java.util.List;

import de.dc.simple.wiki.server.model.User;

public interface IUserService {

	User create(String username, String firstname, String lastname, String password, boolean isActive);
	
	List<User> findAll();
}
