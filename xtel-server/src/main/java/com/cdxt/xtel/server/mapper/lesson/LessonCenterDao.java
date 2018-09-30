package com.cdxt.xtel.server.mapper.lesson;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cdxt.xtel.pojo.lesson.CourseInfo;
import com.cdxt.xtel.pojo.lesson.CoursePlan;

public interface LessonCenterDao {


	//List<Integer>getSignupListbyuserId(Integer userID);
	
	/**
	 * 
	 * @Title: lockRoom
	 * @author wangxiaolong
	 * @Description:锁定会议室
	 * @param
	 * @return
	 */
	void lockRoom(Map<String, Object> paramMap);
	
	//Map<String, Object> getStudentById(Integer id);
	
	int updateCourseArrangementStatusById(@Param("status")Integer status,@Param("id")Integer id);
	
	List<Map<String, Object>> listAllLesson(Map<String, Object> params);
	
	List<Map<String, Object>> listStudentByCourseId(Map<String, Object> params);

	Map<String, Object> getCourseInfoByid(Integer cpurseID);
	
	int insertSignup(@Param("userId")Integer userId,@Param("courseId")Integer courseId,@Param("time")Long time);
	
//	int updateSignupSold(@Param("version")Integer version,@Param("courseId")Integer courseId);

	void deleteClassInfo(Integer cpurseID);
	
	int insertCourseInfo(CourseInfo courseInfo);
	
	List<Map<String, Object>>  listMyLessonPage(Map<String, Object> params);
	
	CourseInfo getCourseInfobyCpurseID(Integer cpurseID);
	
	List<Map<String, Object>>  listRegisteredLessonPage(Map<String, Object> params);
	
	void batchInsertCoursePlan(List<CoursePlan>list);
	
	List<Map<String, Object>>  listCourseArrangeInfoPage(Map<String, Object> params);
	
	int deleteSignupById(Integer id);
	
	/**
	 * 
	 * @Title: unlockRoom
	 * @author wangxiaolong
	 * @Description:
	 * @param
	 * @return
	 */
	void unlockRoom(Map<String, Object> paramMap);
	
	/**
	 * 
	 * @Title: updateArrangeStatusById
	 * @author wangxiaolong
	 * @Description:根据id修改单条记录
	 * @param
	 * @return
	 */
	int  updateArrangeStatusById(@Param("status")Integer status,@Param("id")Integer id);
	
	int  updateArrangeById(@Param("id")Integer id,@Param("status")Integer status,@Param("updateTime")Long updateTime);
	/**
	 * 
	 * @Title: getuserId
	 * @author wangxiaolong
	 * @Description:获取录制客户端id
	 * @param
	 * @return
	 */
	void getUserId(Map<String, Object> paramMap);
	
	/**
	 * 
	 * @Title: getUserId
	 * @author wangxiaolong
	 * @Description:从会议室中删除成员
	 * @param
	 * @return
	 */
	void delMemberFromRoom(Map<String, Object> paramMap);
	
	Map<String, Object>  getArrangeByid(Integer id);
	
	List<Map<String, Object>>outTimeCourse(Map<String, Object> params);
	
	void updateCourseArrangeTime(Map<String, Object> map);
	
	void insertExpapersInfo(Map<String, Object> map);
	
	/**
	 * 
	 * @Title: updateCourse
	 * @author wangxiaolong
	 * @Description:修改课程信息
	 * @param
	 * @return
	 */
	int updateCourse(CourseInfo courseInfo);
	
	
	/**
	 * 
	 * @Title: getCourseArrangementeInfoPage
	 * @author wangxiaolong
	 * @Description:
	 * @param
	 * @return
	 */
	List<Map<String, Object>> getCourseArrangementeByCouorseId(Integer courseId);
	
	/**
	 * 
	 * @Title: deleteCourse
	 * @author wangxiaolong
	 * @Description:
	 * @param
	 * @return
	 */
	int deleteCourseArrangement(int courseID);
	/**
	 * 
		 * @Title: getCourseArrangeStopTotalByCourseId
		 * @Description:统计该课程下所有排课未结束的数量
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月7日
		 * @return:
	 */
	int countCourseArrangeByCourseId(Integer courseId);
	
	/**
	 * 
		 * @Title: getOneArrange
		 * @Description: 查询单个排课表记录
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月10日
		 * @return:
	 */
	Map<String, Object> getOneArrange(Map<String, Object> params);
	/**
	 * 
		 * @Title: updateCourseInfo
		 * @Description:动态更新课程信息表
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月10日
		 * @return:
	 */
	int updateCourseInfo(Map<String, Object> params);
	/**
	 * 
		 * @Title: findArrangeByCourseIdMoreThanTime
		 * @Description: 查询该课程下，开课时间大于time的课程安排记录
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月10日
		 * @return:
	 */
	List<Map<String, Object>> findArrangeByCourseIdMoreThanTime(Map<String, Object> params);

}
