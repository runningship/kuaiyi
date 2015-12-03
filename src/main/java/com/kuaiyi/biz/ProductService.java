package com.kuaiyi.biz;

import java.util.Date;
import java.util.Random;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.kuaiyi.entity.Article;
import com.kuaiyi.entity.Product;
import com.kuaiyi.entity.ProductItem;


@Module(name="/admin/product")
public class ProductService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView save(Product product){
		ModelAndView mv = new ModelAndView();
		dao.saveOrUpdate(product);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Product product){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(product.title)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		product.addtime = new Date();
		dao.saveOrUpdate(product);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Product po = dao.get(Product.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView addItems(Integer productId , Integer count , Integer lottery , String pici){
		ModelAndView mv = new ModelAndView();
		if(count==null){
			throw new GException(PlatformExceptionType.BusinessException,"数量不能为空");
		}
		Random r = new Random();
		for(int i=0;i<count;i++){
			ProductItem item = new ProductItem();
			item.addtime = new Date();
			item.lottery = lottery;
			item.lotteryActive = 0;
			item.pici = pici;
			item.productId = productId;
			item.qrCode = UUID.randomUUID().toString();
			item.verifyCode = String.valueOf(r.nextInt(999999));
			dao.saveOrUpdate(item);
		}
		return mv;
	}
}
