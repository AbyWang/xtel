package com.cdxt.xtel.api.lesson;

import java.util.List;
import java.util.Map;

import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.lesson.CourseInfo;

public interface LessonCenterService {

	PagePojo listMyLessonPage(Integer userID,Integer pageNo, Integer pageSize,String courseName);
	
	PagePojo listRegisteredLessonPage(Integer userID,Integer pageNo, Integer pageSize, String courseName);

	PagePojo listCourseArrangeInfoPage(Integer userID, Integer pageNo, Integer pageSize, String courseName);

	PagePojo listAllLesson(Integer userID, Integer pageNo, Integer pageSize,String courseName);
	
	ResJson stopClass(Integer id,Integer roomId, Integer courseId, String time,Integer userId);
	
	List<Map<String, Object>> outTimeCourse(Integer userId);
	
	ResJson startClass(Integer courseId, Integer id,Integer roomId);
	
	PagePojo listStudentByCourseId(Integer pageNo, Integer pageSize,Map<String, Object> params);
	
	ResJson  deleteStudent(Integer id,String userName,Integer roomId);

	Map<String, Object> getCourseInfoByid(Integer cpurseID);
	
	ResJson insertSignup(Integer courseId,Integer userId);
	
	ResJson updateArrangeById(Integer id,String updateTime);

	void deleteClassInfo(Integer cpurseID);
	
	void insertCourseInfo(CourseInfo courseInfo,String divArray);

	CourseInfo getCourseInfobyCpurseID(Integer cpurseID);
	
	/**
	 * 
	 * @Title: listAllValidCourse
	 * @author wangxiaolong
	 * @Description:获取所有有效的课程
	 * @param
	 * @return
	 */
	List<Map<String, Object>>listAllValidCourseByUserId(Integer status,Integer userID);
		
	//void batchInsertCoursePlan(List<CoursePlan>list);
	
	//void batchMergeCoursePlan(String divArrayStr);
	
	/**
	 * 
	 * @Title: updateCourse
	 * @author wangxiaolong
	 * @param divArrayStr 
	 * @Description:修改课程信息
	 * @param
	 * @return
	 */
	ResJson updateCourse(CourseInfo courseInfo, String divArrayStr);
		
	Map<String, Object>  getArrangeByid(Integer id);
	
	void updateCourseArrangeTime(Map<String, Object> map);
	
	void insertExpapersInfo(Map<String, Object> map);
}
