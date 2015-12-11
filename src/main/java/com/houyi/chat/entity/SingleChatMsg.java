package com.houyi.chat.entity;

import java.util.Date;

import javax.persistence.Entity;

/**
 * 联系人
 * @author xzye
 */
@Entity
public class SingleChatMsg {
	public Integer id;
	
	public Integer myId;
	
	public Integer buddyId;
	
	public String msg;
	
	public Date  sendTime;
	
}
