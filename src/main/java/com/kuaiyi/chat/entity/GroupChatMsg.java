package com.kuaiyi.chat.entity;

import java.util.Date;

import javax.persistence.Entity;

/**
 * 联系人
 * @author xzye
 */
@Entity
public class GroupChatMsg {
	public Integer id;
	
	public Integer sender;
	
	public Integer groupId;
	
	public String msg;
	
	public Date  sendTime;
	
}
