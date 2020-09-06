package com.mavisgs.data.dynamo;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface UserItemRepository extends PagingAndSortingRepository<UserItem, UserItemKey> {

	Page<UserItem> findByUserId(String userId, Pageable pageable);

}
