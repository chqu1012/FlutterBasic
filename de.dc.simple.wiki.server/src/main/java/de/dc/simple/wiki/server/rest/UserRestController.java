package de.dc.simple.wiki.server.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import de.dc.simple.wiki.server.model.User;
import de.dc.simple.wiki.server.repository.UserRepository;

@RestController
public class UserRestController {

	@Autowired
	UserRepository userRepository;

	@RequestMapping(value="/user/authentification",method = RequestMethod.POST) 
	@ResponseBody
	public String login(@RequestBody User user) {
		List<User> userList = userRepository.findByUsernameAndPassword(user.getUsername(), user.getPassword());
		return String.valueOf(userList.size() == 1);
	}
}
