package com.houyi.biz;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.houyi.entity.Feedback;
import com.houyi.util.SecurityHelper;
@Module(name="/admin/feedback")
public class FeedbackService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(Feedback feedback ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(feedback.conts)){
			throw new GException(PlatformExceptionType.BusinessException,"内容不能为空");
		}
		if(StringUtils.isEmpty(feedback.contact)){
			throw new GException(PlatformExceptionType.BusinessException,"联系方式不能为空");
		}
		feedback.addtime = new Date();
		//TODO
		dao.saveOrUpdate(feedback);
		return mv;
	}

	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Feedback po = dao.get(Feedback.class, id);
		if(po!=null){
			dao.delete(po);
			dao.execute("delete from UserGroup where uid=?", id);
			mv.data.put("msg", "删除反馈成功");
		}
		
		return mv;
	}
}
