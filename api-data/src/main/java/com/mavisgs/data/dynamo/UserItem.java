package com.mavisgs.data.dynamo;

import com.amazonaws.services.dynamodbv2.datamodeling.*;
import org.springframework.data.annotation.Id;

@DynamoDBTable(tableName = "mavis-gs.UserItem")
public class UserItem {

	@Id
	@DynamoDBIgnore
	private UserItemKey key;

	@DynamoDBHashKey
	private String userId;

	@DynamoDBRangeKey
	private String itemId;

	public UserItemKey getKey() {
		return key;
	}

	public void setKey(UserItemKey key) {
		this.key = key;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
}
