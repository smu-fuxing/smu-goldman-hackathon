package com.mavisgs.data.dynamo;

import com.mavisgs.data.dynamo.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, String> {
}
