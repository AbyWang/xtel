package com.cdxt.xtel.web.res;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.res.DataService;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.utils.PageUtil;

@Controller
@RequestMapping("/dataController")
public class DataController {
	
	@Reference
	private DataService dataService;
	

	
	/**
	 * 
	 * @Title: getdataPage
	 * @author wangxiaolong
	 * @Description:获取资料分页信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getDataPage")
	@ResponseBody
	public PagePojo getdataPage(@Param(value="nameValue")String nameValue,@Param(value="idVlaue")Integer idVlaue,@Param(value="pageNo")Integer pageNo,@RequestParam(value="pageSize")Integer pageSize) {
		Map<String, Object> newmap =new HashMap<String, Object>();
		newmap.put("nameValue", nameValue);
		newmap.put("idVlaue", idVlaue);
		List<Map<String, Object>> map=dataService.getdataPage(newmap,pageNo,pageSize);
		return PageUtil.Map2PageInfo(map);
		
	}

}
