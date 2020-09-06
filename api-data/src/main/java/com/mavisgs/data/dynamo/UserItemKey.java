package com.mavisgs.data.dynamo;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBDocument;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBRangeKey;

import java.io.Serializable;

@DynamoDBDocument
public class UserItemKey implements Serializable {
	private String userId;
	private String itemId;

	public UserItemKey() {
	}

	public UserItemKey(String userId, String itemId) {
		this.userId = userId;
		this.itemId = itemId;
	}

	@DynamoDBHashKey
	public String getUserId() {
		return userId;
	}

	@DynamoDBRangeKey
	public String getItemId() {
		return itemId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
}
