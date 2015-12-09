package com.kuaiyi.biz;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.kuaiyi.biz.entity.Record;
import com.kuaiyi.entity.Product;
import com.kuaiyi.entity.ProductItem;


@Module(name="/admin/lottery")
public class LotteryService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView save(Integer itemId , String qrCode , String verifyCode , Integer uid , String device , Float lat , Float lng){
		ModelAndView mv = new ModelAndView();
		ProductItem item = dao.get(ProductItem.class, itemId);
		if(item==null){
			throw new GException(PlatformExceptionType.BusinessException,"没有找到兑奖信息");
		}
		if(item.lotteryActive==1){
			throw new GException(PlatformExceptionType.BusinessException,"改商品已经兑奖，请联系商户检查");
		}
		if(uid==null){
			throw new GException(PlatformExceptionType.BusinessException,"请先登录再兑奖");
		}
		if(StringUtils.isEmpty(verifyCode)){
			throw new GException(PlatformExceptionType.BusinessException,"请先输入兑奖码");
		}
		if(!verifyCode.equals(item.verifyCode)){
			throw new GException(PlatformExceptionType.BusinessException,"兑奖码不正确，请检查后重新输入");
		}
		Record record = new Record();
		record.addtime = new Date();
		record.type = 2;
		record.device = device;
		record.uid = uid;
		record.ProductItemId = itemId;
		record.productId = item.productId;
		dao.saveOrUpdate(record);
		
		item.buyerId = uid;
		item.lotteryActive = 1;
		dao.saveOrUpdate(item);
		mv.data.put("result", 0);
		return mv;
	}
	
	
	@WebMethod
	public ModelAndView list(Integer uid){
		ModelAndView mv = new ModelAndView();
		List<ProductItem> list = dao.listByParams(ProductItem.class, "from ProductItem where buyerId=? ", uid);
		mv.data.put("list", JSONHelper.toJSONArray(list));
		mv.data.put("result", 0);
		return mv;
	}
}
