package com.cdxt.xtel.server.impl.res;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cdxt.xtel.api.res.DataService;
import com.cdxt.xtel.server.mapper.res.DataDao;
import com.github.pagehelper.PageHelper;
@Service
public class DataServiceImpl implements DataService {
	@Autowired
	private DataDao  dataDao;

	@Override
	public 	List<Map<String, Object>> getdataPage(Map<String, Object> newmap, Integer pageNo, Integer pageSize){
		 
		PageHelper.startPage(pageNo, pageSize);
		return dataDao.getdataPage(newmap);
	}

}
