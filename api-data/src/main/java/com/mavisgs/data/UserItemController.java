package com.mavisgs.data;

import com.mavisgs.data.dynamo.UserItem;
import com.mavisgs.data.dynamo.UserItemKey;
import com.mavisgs.data.dynamo.UserItemRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/data/users/{userId}/items")
public class UserItemController {

	private final UserItemRepository userItemRepository;

	@Inject
	public UserItemController(UserItemRepository userItemRepository) {
		this.userItemRepository = userItemRepository;
	}

	@GetMapping
	public List<UserItem> list(@PathVariable String userId) {
		Page<UserItem> page = userItemRepository.findByUserId(userId, PageRequest.of(0, 100));
		return page.getContent();
	}

	@GetMapping("/{itemId}")
	public UserItem get(@PathVariable String userId, @PathVariable String itemId) {
		return userItemRepository.findById(new UserItemKey(userId, itemId))
			.orElse(null);
	}

	@PutMapping("/{itemId}")
	public UserItem put(@PathVariable String userId, @PathVariable String itemId, @RequestBody UserItem userItem) {
		userItem.setKey(new UserItemKey(userId, itemId));
		return userItemRepository.save(userItem);
	}

	@DeleteMapping("/{itemId}")
	public void delete(@PathVariable String userId, @PathVariable String itemId) {
		userItemRepository.deleteById(new UserItemKey(userId, itemId));
	}
}
