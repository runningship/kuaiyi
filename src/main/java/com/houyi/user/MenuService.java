package com.houyi.user;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.houyi.cache.ConfigCache;
import com.houyi.entity.Article;
import com.houyi.entity.Menu;
import com.houyi.entity.User;
import com.houyi.util.DataHelper;
import com.houyi.util.SecurityHelper;


@Module(name="/admin/menu")
public class MenuService {

	static final int MAX_SIZE = 1024000*100;
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView save(Menu menu){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(menu.name)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		dao.saveOrUpdate(menu);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Menu menu ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(menu.name)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		Menu po = dao.get(Menu.class, menu.id);
		po.name = menu.name;
		po.orderx = menu.orderx;
		//TODO
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		long leftCount = dao.countHql("select count(*) from Menu where parentId=?", id);
		if(leftCount>0){
			throw new GException(PlatformExceptionType.BusinessException,"该栏目下包含子栏目,请先删除子栏目。");
		}
		leftCount = dao.countHql("select count(*) from Article where parentId=?", id);
		if(leftCount>0){
			throw new GException(PlatformExceptionType.BusinessException,"该栏目下包含子栏目,请先删除子栏目。");
		}
		
		Menu po = dao.get(Menu.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
