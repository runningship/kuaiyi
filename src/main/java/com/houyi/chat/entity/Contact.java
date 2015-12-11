package com.houyi.chat.entity;

import java.util.Date;

import javax.persistence.Entity;

/**
 * 联系人
 * @author xzye
 */
@Entity
public class Contact {
	public Integer id;
	
	public Integer myId;
	
	public Integer buddyId;
	
	/**
	 * -1,表示不接收消息 , 1 邀请中,2好友,3拒绝加好友
	 */
	public Integer state;
	
	public Date addtime;
	
	//我到最后一次查看改会话的时间
	public Date lastReadTime;
	
	public String chatId;
	
	public Integer active;
}
