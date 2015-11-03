package com.youwei.kuaiyi.user;

import java.io.File;
import java.io.IOException;

import net.sf.json.JSONArray;

import org.apache.commons.io.FileUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Transactional;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import antlr.collections.List;

import com.youwei.kuaiyi.entity.Role;
import com.youwei.kuaiyi.entity.RoleAuth;
import com.youwei.kuaiyi.entity.User;
//
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
@Module(name="/admin/role")
public class RoleService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(Role role){
		ModelAndView mv = new ModelAndView();
		role.isSystemRole = 0;
		dao.saveOrUpdate(role);
		return mv;
	}

	
	@WebMethod
	public ModelAndView update(Role role ){
		ModelAndView mv = new ModelAndView();
		Role po = dao.get(Role.class, role.id);
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"角色信息不存或已删除");
		}
		po.name = role.name;
		po.duty = role.duty;
		dao.saveOrUpdate(po);
		return mv;
	}

	@WebMethod
	@Transactional
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Role po = dao.get(Role.class, id);
		if(po!=null){
			dao.delete(po);
			dao.execute("delete from UserRole where roleId=?", id);
			dao.execute("delete from RoleAuth where roleId=?", id);
			mv.data.put("msg", "删除用户成功");
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView getAuthItems(int roleId){
		ModelAndView mv = new ModelAndView();
		try {
			String text = FileUtils.readFileToString(new File(ThreadSession.getHttpSession().getServletContext().getRealPath("/")+File.separator+"menus.json"), "utf8");
			JSONArray jarr = JSONArray.fromObject(text);
			Role role = dao.get(Role.class, roleId);
			mv.data.put("modules", jarr.toString());
			return mv;
		} catch (IOException ex) {
			ex.printStackTrace();
			throw new GException(PlatformExceptionType.BusinessException, "读取资源文件失败");
		}
	}
	
	@WebMethod
	public ModelAndView addRoleAuth(int roleId,String authId){
		ModelAndView mv = new ModelAndView();
		RoleAuth po = new RoleAuth();
		po.authId = authId;
		po.roleId = roleId;
		dao.saveOrUpdate(po);
		return mv;
	}

	@WebMethod
	public ModelAndView deleteRoleAuth(int roleId,String authId){
		ModelAndView mv = new ModelAndView();
		dao.execute("delete from RoleAuth where roleId=? and authId=?", roleId,authId);
		return mv;
	}
	
}
