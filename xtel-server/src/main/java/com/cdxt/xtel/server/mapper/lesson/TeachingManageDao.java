package com.cdxt.xtel.server.mapper.lesson;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cdxt.xtel.pojo.lesson.CourseInfo;

public interface TeachingManageDao {

	/**
	 * 
	 * @Title: listCourseApply
	 * @author wangxiaolong
	 * @Description:课程申请列表
	 * @param
	 * @return
	 */
	List<Map<String,Object>> listCourseApply(Map<String, Object> params);
	
	/**
	 * 
	 * @Title: listArrangePage
	 * @author wangxiaolong
	 * @Description:排课申请
	 * @param
	 * @return
	 */
	List<Map<String,Object>> listArrangePage(Map<String, Object> params);

	/**
	 * 
	 * @Title: addMeetingRoom
	 * @author wangxiaolong
	 * @Description:新建聊天室
	 * @param
	 * @return
	 */
	void addMeetingRoom(Map<String, Object> paramMap);

	/**
	 * 
	 * @Title: courseApply
	 * @author wangxiaolong
	 * @Description:审核通过,更新课程申请状态、roomid
	 * @param
	 * @return
	 */
	int courseApply(@Param("roomId")Integer roomId,@Param("courseId")Integer courseId);

	/**
	 * 
	 * @Title: lockRoom
	 * @author wangxiaolong
	 * @Description:锁定会议室
	 * @param
	 * @return
	 */
	void lockRoom(Map<String, Object> paramMap);

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
	 * @Title: addRecorder
	 * @author wangxiaolong
	 * @Description:添加录制客户端
	 * @param
	 * @return
	 */
	void  addRecorder(Map<String, Object> paramMap);

	/**
	 * 
	 * @Title: addMember2Room
	 * @author wangxiaolong
	 * @Description:向会议室中添加用户
	 * @param
	 * @return
	 */
	void addMember2Room(Map<String, Object> paramMap);


	


	
	
	int updateArrangeById(@Param("id")Integer id,@Param("updateTime")Long updateTime);
	
	/**
	 * 
	 * @Title: setRoomHost
	 * @author wangxiaolong
	 * @Description:设置房间主持人
	 * @param
	 * @return
	 */
	void setRoomHost(Map<String, Object> paramMap);

	CourseInfo getCourseInfoByid(int cpurseID);
	/**
	 * 
	 * @Title: registerApply
	 * @author wangxiaolong
	 * @Description:报名审核
	 * @param
	 * @return
	 */
	int registerApply(int id);
	/**
	 * 
	 * @Title: getTeachingPage
	 * @author wangxiaolong
	 * @Description:查询课程的信息，带分页
	 * @param
	 * @return
	 */
	List<Map<String, Object>> getTeachingPage(@Param("newmap")Map<String, Object> newmap,@Param("pageNo") Integer pageNo,@Param("pageSize") Integer pageSize);



	/**
	 * 
	 * @Title: getTeachingByid
	 * @author wangxiaolong
	 * @Description:根据id查看单一课程信息
	 * @param
	 * @return
	 */
	Map<String, Object>  getTeachingByid(@Param("cpurseID")Integer cpurseID);


	/**
	 * 
	 * @Title: updateTeachingStatus
	 * @author wangxiaolong
	 * @Description:根据id修改课程审核状态
	 * @param
	 * @return
	 */
	int  updateTeachingStatus(@Param("teachingID") Integer teachingID);

	/**
	 * 
	 * @Title: getCourseArrangementeInfoPage
	 * @author wangxiaolong
	 * @Description:
	 * @param
	 * @return
	 */
	List<Map<String, Object>> getCourseArrangementeByCouorseId(Integer courseId);




	void updateCourseArrangementStatusByCourseId(@Param("courseId")int courseId);

	/**
	 * 
	 * @Title: listRegister
	 * @author wangxiaolong
	 * @Description:排课申请列表
	 * @param
	 * @return
	 */
	List<Map<String, Object>> listRegister(@Param("courseName")String courseName);
	
	
	int updateSignupSold(@Param("version")Integer version,@Param("courseId")Integer courseId);


}
