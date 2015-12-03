package com.kuaiyi.user;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.kuaiyi.ThreadSessionHelper;
import com.kuaiyi.entity.Group;
import com.kuaiyi.entity.User;
//
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
@Module(name="/admin/group")
public class GroupService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(Group group ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(group.name)){
			throw new GException(PlatformExceptionType.BusinessException,"部门名称不能为空");
		}
		group.owner = ThreadSessionHelper.getUser().id;
		group.addtime = new Date();
		dao.saveOrUpdate(group);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Group group ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(group.name)){
			throw new GException(PlatformExceptionType.BusinessException,"部门名称不能为空");
		}
		Group po = dao.get(Group.class, group.id);
		po.name = group.name;
		dao.saveOrUpdate(po);
		return mv;
	}

	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		long leftCount = dao.countHql("select count(*) from Group where parentId=?", id);
		if(leftCount>0){
			throw new GException(PlatformExceptionType.BusinessException,"该群组下包含子群组,请先删除子部门。");
		}
		Group po = dao.get(Group.class, id);
		if(po!=null){
			dao.delete(po);
			mv.data.put("msg", "删除部门成功");
		}
		return mv;
	}
}
