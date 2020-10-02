package de.dc.simple.wiki.server.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import de.dc.simple.wiki.server.model.User;
import de.dc.simple.wiki.server.repository.UserRepository;

@Service
public class UserService implements IUserService{

	@Autowired UserRepository userRepository;
	
	@Override
	public User create(String username, String firstname, String lastname, String password, boolean isActive) {
		User user = new User();
		user.setActive(isActive);
		user.setCreated(LocalDateTime.now());
		user.setFirstname(firstname);
		user.setLastname(lastname);
		user.setPassword(password);
		user.setUsername(username);
		return userRepository.save(user);
	}

	@Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

}
