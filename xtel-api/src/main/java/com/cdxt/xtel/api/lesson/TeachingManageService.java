package com.cdxt.xtel.api.lesson;

import java.util.List;
import java.util.Map;

import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.lesson.CourseInfo;


public interface TeachingManageService {
	
	/**
	 * 
	 * @Title: listCourseApply
	 * @author wangxiaolong
	 * @Description:查询权限下的所有课程申请
	 * @param
	 * @return
	 */
	List<Map<String,Object>> listCourseApply(Map<String, Object> params,Integer pageNo, Integer pageSize);

	/**
	 * 
	 * @Title: getCourseInfoByid
	 * @author wangxiaolong
	 * @Description:查询课程详细信息
	 * @param
	 * @return
	 */
	CourseInfo getCourseInfoByid(int cpurseID);
	/**
	 * 
	 * @Title: courseApply
	 * @author wangxiaolong
	 * @Description:课程申请审批
	 * @param
	 * @return
	 */
	ResJson  applyAndAddMeetingRoom(String userName,Integer courseId,Integer numberOfExpected,String courseName);
	
	/**
	 * 
	 * @Title: updateArrangeById
	 * @author wangxiaolong
	 * @Description:排课调整审批
	 * @param排课
	 * @return
	 */
	ResJson updateArrangeById(Integer id,Long updateTime);
	
	
	/**
	 * 
	 * @Title: registerApply
	 * @author wangxiaolong
	 * @Description:报名审核
	 * @param
	 * @return
	 */
	ResJson applyAndAddRoom(int id,String userName,String roomId,Integer courseId);
	
	/**
	 * 
	 * @Title: unlockRoom
	 * @author wangxiaolong
	 * @Description:房间解锁
	 * @param
	 * @return
	 */
//	void unlockRoom(int roomId,int lockType,int id);
	

	List<Map<String, Object>> getTeachingPage(Map<String, Object> newmap, Integer pageNo, Integer pageSize);

	
	List<Map<String, Object>> listArrangePage(Map<String, Object> params, Integer pageNo, Integer pageSize);

	
	Map<String, Object> getTeachingByid(int cpurseID);

	int updateTeachingStatus(int teachingID);

	void updateCourseArrangementStatus(int id);
	
	/**
	 * 
	 * @Title: listRegister
	 * @author wangxiaolong
	 * @param courseName 
	 * @Description:报名申请列表
	 * @param
	 * @return
	 */
	List<Map<String,Object>> listRegister(String courseName, Integer pageNo, Integer pageSize);

}
