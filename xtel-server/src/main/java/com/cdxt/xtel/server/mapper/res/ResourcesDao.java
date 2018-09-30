package com.cdxt.xtel.server.mapper.res;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cdxt.xtel.pojo.res.ArticleLibrary;

public interface ResourcesDao {

	List<Map<String, Object>>listDataPage(String strname);
	
	void updateLearningData(Map<String, Object> map);
	
	void insertLearningData(Map<String, Object> map);
	
	Map<String, Object> getLearningDataByid(int id);
	
	void deletedataInfo(int id);
	
	
	List<Map<String, Object>>listMydataPage(Map<String, Object> map);


	List<Map<String, Object>> getResourcesPage(Map<String, Object> newmap);

	int findCoursewareInfoByidcount(@Param("cpurseID")Integer cpurseID);


	void  deleteCoursewareInfoByid(@Param("courseId") Integer courseId);
	
}
