package com.houyi.chat;

import java.util.List;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;


@Module(name="/admin/zone")
public class PhotoZoneService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView publishShuoShuo(Integer myId , List<String> imageList , String msg){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView loadShuoShuo(Integer myId , Integer currentPage){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
}
