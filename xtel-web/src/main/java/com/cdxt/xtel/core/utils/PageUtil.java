/**
 * 
 * @ClassName: PageUtil.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月18日
 */
package com.cdxt.xtel.core.utils;

import java.util.List;
import java.util.Map;

import com.cdxt.xtel.core.model.PagePojo;
import com.github.pagehelper.PageInfo;

/**
 * 
 * @ClassName: PageUtil.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月18日
 */
public class PageUtil {

	public static PagePojo  Map2PageInfo(List<Map<String,Object>>map){
		//封装bootstrap
		PagePojo page=new PagePojo();
		//将数据放入pageInfo，pageInfo会对数据进行处理，这个是封装好的类，直接调用即可
		PageInfo<Map<String,Object>>pageInfo=new PageInfo<Map<String,Object>>(map);

		page.setPage(pageInfo.getPageNum());
		page.setTotal(pageInfo.getTotal());
		page.setRows(map);
		return page;
	}

}
