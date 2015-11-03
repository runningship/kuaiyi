package com.youwei.kuaiyi.user;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.LogUtil;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.kuaiyi.MakesiteConstant;
import com.youwei.kuaiyi.entity.Group;
import com.youwei.kuaiyi.entity.User;
import com.youwei.kuaiyi.entity.UserGroup;
import com.youwei.kuaiyi.entity.UserRole;
import com.youwei.kuaiyi.util.DataHelper;
import com.youwei.kuaiyi.util.SecurityHelper;
//
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
@Module(name="/admin/user")
public class UserService {
	
	public static Map<String,Integer> onlineUserCountMap = new HashMap<String , Integer>();
	
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(User user  , Integer groupId , String roleIds){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.account)){
			throw new GException(PlatformExceptionType.BusinessException,"用户账号不能为空");
		}
		if(StringUtils.isEmpty(user.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户姓名不能为空");
		}
		if(StringUtils.isEmpty(user.pwd)){
			throw new GException(PlatformExceptionType.BusinessException,"请先设置密码");
		}
		user.isSuperAdmin = 0;
		user.addtime = new Date();
		user.pwd = SecurityHelper.Md5(user.pwd);
		//TODO
		dao.saveOrUpdate(user);
		if(groupId!=null){
			UserGroup ug = new UserGroup();
			ug.gid = groupId;
			ug.uid = user.id;
			dao.saveOrUpdate(ug);
		}
		if(roleIds!=null && roleIds.length() != 0){
			String[] Ids = roleIds.split(",");
			for(int i=0;i<Ids.length ;i++){
				UserRole rg = new UserRole();
				rg.roleId = Integer.valueOf(Ids[i]);
				rg.uid = user.id;
				dao.saveOrUpdate(rg);
			}
		}
		return mv;
	}

	@WebMethod
	public ModelAndView login(User user , String _site){
		ModelAndView mv = new ModelAndView();
		String pwd = SecurityHelper.Md5(user.pwd);
		User po = dao.getUniqueByParams(User.class, new String[]{"account" , "pwd" , "_site"}, new Object[]{user.account  , pwd , _site});
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"用户名或密码不正确。");
		}
		po.lasttime = new Date();
		dao.saveOrUpdate(po);
		ThreadSession.getHttpSession().setAttribute(MakesiteConstant.Session_Attr_User, po);
		List<Map> result = dao.listAsMap("select ra.authId as authId from UserRole ur ,RoleAuth ra where ur.roleId=ra.roleId and ur.uid=?", po.id);
		StringBuilder authList= new StringBuilder("");
		for(Map map : result){
			authList.append(map.get("authId").toString());
		}
		ThreadSession.getHttpSession().setAttribute(MakesiteConstant.Session_Auth_List, authList.toString());
		String serverName = DataHelper.getServerName(ThreadSession.HttpServletRequest.get());
		if(!onlineUserCountMap.containsKey(serverName)){
			onlineUserCountMap.put(serverName, 1);
		}else{
			onlineUserCountMap.put(serverName,onlineUserCountMap.get(serverName)+1);
		}
		String text;
		try {
			text = FileUtils.readFileToString(new File(ThreadSession.HttpServletRequest.get().getServletContext().getRealPath("/")+File.separator+"auths.json"), "utf8");
			JSONArray jarr = JSONArray.fromObject(text);
			List<String> urlList = new ArrayList<String>();
			for(int i=0;i<jarr.size();i++){
				JSONObject jobj = jarr.getJSONObject(i);
				if(authList.toString().contains(jobj.getString("id"))){
					continue;
				}
				String urls = jobj.getString("urls");
				for(String url : urls.split(",")){
					urlList.add(url);
				}
			}
			ThreadSession.getHttpSession().setAttribute(MakesiteConstant.Session_Auth_Urls, urlList);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView logout(){
		ModelAndView mv = new ModelAndView();
		ThreadSession.getHttpSession().removeAttribute("user");
		ThreadSession.getHttpSession().removeAttribute(MakesiteConstant.Session_Auth_List);
		mv.redirect=ThreadSession.HttpServletRequest.get().getServletContext().getContextPath()+"/index.jsp";
		String serverName = DataHelper.getServerName(ThreadSession.HttpServletRequest.get());
		if(onlineUserCountMap.containsKey(serverName)){
			onlineUserCountMap.put(serverName,onlineUserCountMap.get(serverName)-1);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView update(User user  ,  String roleIds ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户名不能为空");
		}
		User po = dao.get(User.class, user.id);
		po.account = user.account;
		po.name = user.name;
//		String pwd = user.pwd.replace("*", "");
		if(StringUtils.isNotEmpty(user.pwd)){
			po.pwd = SecurityHelper.Md5(user.pwd);
		}
		po.tel = user.tel;
		dao.saveOrUpdate(po);
		ThreadSession.getHttpSession().setAttribute(MakesiteConstant.Session_Attr_User, po);
		if(roleIds!=null && roleIds.length() != 0){
			String[] Ids = roleIds.split(",");
			dao.execute("delete from UserRole where uid=?", user.id);
			for(int i=0;i<Ids.length ;i++){
				if(StringUtils.isEmpty(Ids[i])){
					continue;
				}
				UserRole rg = new UserRole();
				rg.roleId = Integer.valueOf(Ids[i]);
				rg.uid = user.id;
				dao.saveOrUpdate(rg);
			}
		}else{}
		return mv;
	}

	@WebMethod
	public ModelAndView modifyPwd(int  uid , String oldPwd , String newPwd){
		ModelAndView mv = new ModelAndView();
		User po = dao.get(User.class, uid);
		if(po!=null){
			if(!po.pwd.equals(SecurityHelper.Md5(oldPwd))){
				throw new GException(PlatformExceptionType.BusinessException,"原密码不正确,请重新输入后重试");
			}
			po.pwd = SecurityHelper.Md5(newPwd);
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		User po = dao.get(User.class, id);
		if(po!=null){
			dao.delete(po);
			dao.execute("delete from UserGroup where uid=?", id);
			dao.execute("delete from UserRole where uid=?", id);
			mv.data.put("msg", "删除用户成功");
		}
		
		return mv;
	}
	
	@WebMethod
	public ModelAndView banUser(int  groupId , int uid){
		ModelAndView mv = new ModelAndView();
		UserGroup po = dao.getUniqueByParams(UserGroup.class, new String[]{"gid" , "uid" },  new Object[]{groupId , Integer.valueOf(uid)});
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView addToGroup(int  groupId , String ids){
		ModelAndView mv = new ModelAndView();
		for(String uid : ids.split(",")){
			if(StringUtils.isEmpty(uid)){
				continue;
			}
			UserGroup po = dao.getUniqueByParams(UserGroup.class, new String[]{"gid" , "uid" },  new Object[]{groupId , Integer.valueOf(uid)});
			if(po!=null){
				continue;
			}
			UserGroup ug = new UserGroup();
			ug.gid = groupId;
			ug.uid = Integer.valueOf(uid);
			dao.saveOrUpdate(ug);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView getUserTree(String _site){
		ModelAndView mv = new ModelAndView();
		List<Group> groups = dao.listByParams(Group.class, "from Group where parentId is null and _site=?" , _site);
		JSONArray arr = new JSONArray();
		for(Group g : groups){
			JSONObject jobj = new JSONObject();
			jobj.put("name", g.name);
			jobj.put("id", g.id);
			jobj.put("key", "group_"+g.id);
			jobj.put("isParent", true);
			jobj.put("type", "group");
			JSONArray children = getChildrenOfGroup(g.id , _site);
			if(!children.isEmpty()){
				jobj.put("children", children);
			}
			arr.add(jobj);
		}
		mv.returnText = arr.toString();
		return mv;
	}
	
	private JSONArray getChildrenOfGroup(Integer groupId , String _site){
		List<Group> groups = dao.listByParams(Group.class, "from Group where parentId = ? and _site=?" , groupId , _site);
		JSONArray arr = new JSONArray();
		for(Group g : groups){
			JSONObject jobj = new JSONObject();
			jobj.put("name", g.name);
			jobj.put("id", g.id);
			jobj.put("type", "group");
			jobj.put("key", "group_"+g.id);
			jobj.put("isParent", true);
			JSONArray children = getChildrenOfGroup(g.id , _site);
			if(!children.isEmpty()){
				jobj.put("children", children);
			}
			arr.add(jobj);
		}
		List<Map> users = dao.listAsMap("select u.name as name , u.id as id from User u , UserGroup ug where u.id = ug.uid and ug.gid=? and u._site=?", groupId , _site);
		for(Map u : users){
			JSONObject jobj = new JSONObject();
			jobj.put("name", u.get("name"));
			jobj.put("id", u.get("id"));
			jobj.put("key", "user_"+u.get("id"));
			jobj.put("type", "user");
			arr.add(jobj);
		}
		return arr;
	}
	
}
