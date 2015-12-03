package com.kuaiyi.chat.entity;

import java.util.Date;

import javax.persistence.Entity;

/**
 * 联系人
 * @author xzye
 */
@Entity
public class GroupUser {
	public Integer id;
	
	public Integer groupId;
	
	public Integer uid;

	public Integer state;
	
	public String nickname;
	
	public Integer showNameInChat;
	
	//从什么时间开始读取群组消息
	//刚刚加入群时设置该时间
	//设置情况群聊天记录时，通过设置该时间实现
	public Date readMsgFromTime;
	
	//我最后一次查看该群组聊天的时间
	public Date lastReadTime;
	
	//是否打开聊天窗口
	public Integer active;
	
}
