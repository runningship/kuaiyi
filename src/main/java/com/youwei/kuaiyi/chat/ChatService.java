package com.youwei.kuaiyi.chat;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.youwei.kuaiyi.chat.entity.Contact;
import com.youwei.kuaiyi.chat.entity.GroupUser;
import com.youwei.kuaiyi.chat.entity.Invitation;
import com.youwei.kuaiyi.util.XingeHelper;


@Module(name="/admin/chat")
public class ChatService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	StorageService ss = new StorageService();
	
	@WebMethod
	public ModelAndView sendSingleChatMsg(Integer myId , String chatId, String msg , String buddyAccount){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(buddyAccount)){
			throw new GException(PlatformExceptionType.BusinessException,"数据结构错误");
		}
//		String myFile = ss.getSingleChatDataPath(chatId);
//		List<String> lines = new ArrayList<String>();
//		JSONObject json = new JSONObject();
//		json.put("msg", msg);
//		json.put("sender", myId);
//		json.put("time", System.currentTimeMillis());
//		lines.add(json.toString());
//		try {
//			FileUtils.writeLines(new File(myFile), lines, "utf8", true);
//		} catch (IOException e) {
//			e.printStackTrace();
//			mv.data.put("result", -1);
//			return mv;
//		}
		//notifyBuddy
		XingeHelper.pushSingleAccountMsg(buddyAccount, msg);
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView sendGroupChatMsg(Integer myId , String groupUUID , String msg){
		ModelAndView mv = new ModelAndView();
		String file = ss.getGroupChatDataPath(groupUUID);
		List<String> lines = new ArrayList<String>();
		lines.add(msg);
		try {
			FileUtils.writeLines(new File(file), lines, "utf8", true);
		} catch (IOException e) {
			e.printStackTrace();
			mv.data.put("result", -1);
			return mv;
		}
		//notify group member
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
		Contact contact = dao.getUniqueByParams(Contact.class, new String[]{"myId" , "buddyId"}, new Object[]{myId , buddyId});
		if(contact!=null){
			contact.lastReadTime=new Date();
			contact.active = 1;
			dao.saveOrUpdate(contact);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView closeSingleChat(Integer myId , Integer buddyId){
		ModelAndView mv = new ModelAndView();
		Contact contact = dao.getUniqueByParams(Contact.class, new String[]{"myId" , "buddyId"}, new Object[]{myId , buddyId});
		if(contact!=null){
			contact.active = 0;
			dao.saveOrUpdate(contact);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView openGroupChat(Integer myId , Integer groupId){
		ModelAndView mv = new ModelAndView();
		GroupUser gu = dao.getUniqueByParams(GroupUser.class, new String[]{"uid" , "groupId"}, new Object[]{myId , groupId});
		if(gu!=null){
			gu.active = 1;
			gu.lastReadTime = new Date();
			dao.saveOrUpdate(gu);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView closeGroupChat(Integer myId , Integer groupId){
		ModelAndView mv = new ModelAndView();
		GroupUser gu = dao.getUniqueByParams(GroupUser.class, new String[]{"uid" , "groupId"}, new Object[]{myId , groupId});
		if(gu!=null){
			gu.active = 0;
			dao.saveOrUpdate(gu);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView inviteContact(Integer myId , Integer buddyId , String msg){
		ModelAndView mv = new ModelAndView();
		Invitation invitation = new Invitation();
		invitation.inviteeId = buddyId;
		invitation.inviterId = myId;
		invitation.msg = msg;
		invitation.addtime = new Date();
		invitation.status = 1;
		dao.saveOrUpdate(invitation);
		
		Contact contact = new Contact();
		contact.myId = invitation.inviterId;
		contact.buddyId = invitation.inviteeId;
		contact.addtime = new Date();
		contact.lastReadTime = new Date();
		contact.state = 1;
		dao.saveOrUpdate(contact);
		
		//notify invitee
		return mv;
	}
	
	@WebMethod
	public ModelAndView acceptInvitation(Integer id){
		ModelAndView mv = new ModelAndView();
		Invitation invitation = dao.get(Invitation.class, id);
		invitation.status = 2;
		dao.saveOrUpdate(invitation);
		Contact contact = new Contact();
		contact.myId = invitation.inviteeId;
		contact.buddyId = invitation.inviterId;
		contact.addtime = new Date();
		contact.lastReadTime = new Date();
		contact.state = 2;
		dao.saveOrUpdate(contact);
		
		//update inviter status
		Contact buddy = dao.getUniqueByParams(Contact.class, new String[]{"myId" , "buddyId"}, new Object[]{invitation.inviterId , invitation.inviteeId});
		if(buddy!=null){
			buddy.state = 2;
			dao.saveOrUpdate(buddy);
		}
		
		//notify inviter;
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
