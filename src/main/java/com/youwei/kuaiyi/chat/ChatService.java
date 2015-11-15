package com.youwei.kuaiyi.chat;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.youwei.kuaiyi.entity.Article;


@Module(name="/admin/chat")
public class ChatService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView sendSingleChatMsg(Integer myId , Integer buddyId , String msg){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView sendGroupChatMsg(Integer myId , Integer groupId , String msg){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView emptSingleChatMsg(Integer myId , Integer buddyId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView emptyGroupChatMsg(Integer myId , Integer groupId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView openSingleChat(Integer myId , Integer buddyId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView openGroupChat(Integer myId , Integer groupId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView inviteContact(Integer buddyId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView acceptInvitation(Integer buddyId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView addBuddyToGroup(Integer buddyId , Integer groupId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView removeBuddy(Integer buddyId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView quitGroup(Integer groupId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
}
