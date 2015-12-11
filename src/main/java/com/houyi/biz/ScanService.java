package com.houyi.biz;

import java.util.Date;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.houyi.biz.entity.Record;
import com.houyi.entity.ProductItem;


@Module(name="/admin/scan")
public class ScanService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(Record record){
		ModelAndView mv = new ModelAndView();
		ProductItem po = dao.getUniqueByParams(ProductItem.class, new String[]{"" , ""}, new Object[]{record.uid , record.ProductItemId});
		if(po!=null){
			record.addtime = new Date();
			dao.saveOrUpdate(record);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView listRecord(Page<Record> page , Integer uid){
		ModelAndView mv = new ModelAndView();
		page = dao.findPage(page, "from ScanRecord where uid = ?", uid);
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
}
