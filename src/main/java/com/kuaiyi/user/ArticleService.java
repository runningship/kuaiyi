package com.kuaiyi.user;

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

import com.kuaiyi.cache.ConfigCache;
import com.kuaiyi.entity.Article;
import com.kuaiyi.entity.Menu;
import com.kuaiyi.entity.User;
import com.kuaiyi.entity.UserGroup;
import com.kuaiyi.util.DataHelper;
import com.kuaiyi.util.SecurityHelper;


@Module(name="/admin/article")
public class ArticleService {

	static final int MAX_SIZE = 1024000*100;
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView save(Article art){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(art.name)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		if(art.id !=null){
			Article po = dao.get(Article.class, art.id);
			po.conts = art.conts;
		}else{
			art.addtime = new Date();
		}
		if(art.parentId==null){
			art.parentId=0;
		}
		dao.saveOrUpdate(art);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Article art){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(art.name)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		Article po = dao.get(Article.class, art.id);
		po.name = art.name;
		po.orderx = art.orderx;
		po.conts = art.conts;
		//TODO
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Article po = dao.get(Article.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
