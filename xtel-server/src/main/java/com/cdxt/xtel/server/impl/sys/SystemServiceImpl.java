package com.cdxt.xtel.server.impl.sys;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;
import com.cdxt.xtel.api.sys.SystemService;
import com.cdxt.xtel.server.mapper.sys.SystemDao;
import com.github.pagehelper.PageHelper;



@Service
@Component
@Transactional
public class SystemServiceImpl implements SystemService {

	@Resource
	private SystemDao systemDao;

	
	/**
	 * 
	 * @Title: getSystemVersion
	 * @Description:获取版本列表
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> listSystemVersion(String id,Integer pageNo,Integer pageSize){

		//分页
		PageHelper.startPage(pageNo, pageSize);

		return systemDao.listSystemVersion(id);
	}


	public void updateStatus(Integer id, Integer startStatus, Integer closeStatus) {
		systemDao.updateStatus(null,closeStatus);//全部禁用
		systemDao.updateStatus(id, startStatus);//该id启用
	}



}
