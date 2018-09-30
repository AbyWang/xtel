package com.cdxt.xtel.server.impl.res;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;
import com.cdxt.xtel.api.res.ResourcesService;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.util.PageUtil;
import com.cdxt.xtel.pojo.res.ArticleLibrary;
import com.cdxt.xtel.server.mapper.res.ResourcesDao;
import com.github.pagehelper.PageHelper;
@Service
@Transactional
public class ResourcesServiceImpl implements ResourcesService {
	@Autowired
	private ResourcesDao resourcesDao;
	
	
	@Override
	public PagePojo listDataPage(String strname,Integer pageNo, Integer pageSize)  {
		PageHelper.startPage(pageNo, pageSize);
		
		List<Map<String, Object>>mapList=  resourcesDao.listDataPage(strname);
		return PageUtil.Map2PageInfo(mapList);
	}

	@Override
	public void updateLearningData(Map<String, Object> map)  {

		resourcesDao.updateLearningData(map);
	}

	@Override
	public void insertLearningData(Map<String, Object> map)  {

		resourcesDao.insertLearningData(map);
	}

	@Override
	public Map<String, Object> getLearningDataByid(int id)  {

		return resourcesDao.getLearningDataByid(id);
	}

	@Override
	public void deletedataInfo(int id)  {
		
		resourcesDao.deletedataInfo(id);
	}



	@Override
	public PagePojo listMydataPage(Map<String, Object> map, Integer pageNo, Integer pageSize){
		PageHelper.startPage(pageNo, pageSize);
		List<Map<String, Object>>mapList=resourcesDao.listMydataPage(map);

		return PageUtil.Map2PageInfo(mapList);
	}
	
	

	@Override
	public List<Map<String, Object>> getResourcesPage(Map<String, Object> newmap, Integer pageNo, Integer pageSize){
		//分页
		PageHelper.startPage(pageNo, pageSize);
		return resourcesDao.getResourcesPage(newmap);

	}

	@Override
	public int findCoursewareInfoByidcount(int courseId)  {
			return resourcesDao.findCoursewareInfoByidcount(courseId);
	}

	@Override
	public void deleteCoursewareInfoByid(int courseId){
		
		resourcesDao.deleteCoursewareInfoByid(courseId);
		
	}

}
