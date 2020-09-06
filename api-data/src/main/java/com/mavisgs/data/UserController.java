package com.mavisgs.data;

import com.mavisgs.data.dynamo.User;
import com.mavisgs.data.dynamo.UserRepository;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;

@CrossOrigin
@RestController
@RequestMapping("/data/users")
public class UserController {

	private final UserRepository userRepository;

	@Inject
	public UserController(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@GetMapping("/{userId}")
	public User get(@PathVariable String userId) {
		return userRepository.findById(userId)
			.orElse(null);
	}

	@PutMapping("/{userId}")
	public User put(@PathVariable String userId, @RequestBody User user) {
		user.setUserId(userId);
		return userRepository.save(user);
	}
}
