package com.cdxt.xtel.api.res;

import java.util.List;
import java.util.Map;

import com.cdxt.xtel.core.model.PagePojo;

public interface ResourcesService {


	PagePojo listDataPage(String strname, Integer pageNo, Integer pageSize);

	void updateLearningData(Map<String, Object> map);

	void insertLearningData(Map<String, Object> map);

	Map<String, Object> getLearningDataByid(int id);

	void deletedataInfo(int id);


	PagePojo listMydataPage(Map<String, Object> map, Integer pageNo, Integer pageSize);


	//xtel-admin
	List<Map<String, Object>> getResourcesPage(Map<String, Object> newmap, Integer startRow, Integer pageSize);

	int findCoursewareInfoByidcount(int courseId);

	void deleteCoursewareInfoByid(int courseId);


}
