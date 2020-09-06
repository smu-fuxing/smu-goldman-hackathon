package com.mavisgs.data;

import com.amazonaws.services.dynamodbv2.model.Record;
import com.mavisgs.data.dynamo.User;
import com.mavisgs.data.dynamo.UserItemRepository;
import com.mavisgs.data.dynamo.UserRepository;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;

@RestController
public class UserController {

	private final UserRepository userRepository;

	@Inject
	public UserController(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@GetMapping("/users/{userId}")
	public User get(@PathVariable String userId) {
		return userRepository.findById(userId)
			.orElse(null);
	}

	@PutMapping("/users/{userId}")
	public User put(@PathVariable String userId, @RequestBody User user) {
		user.setUserId(userId);
		return userRepository.save(user);
	}
}
