package com.cdxt.xtel.web.lesson;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.lesson.TeachingManageService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.utils.PageUtil;
import com.cdxt.xtel.pojo.lesson.CourseInfo;
import com.cdxt.xtel.pojo.sys.UserInfo;

@Controller
@RequestMapping("/teachingController")
public class TeachingManageController {


	@Reference
	private TeachingManageService teachingManageService;


	/**
	 * 
	 * @Title: getoCourseDetail
	 * @author wangxiaolong
	 * @Description:报名跳转
	 * @param
	 * @return
	 */
	@RequestMapping("/getoCourseDetail")
	public String getoCourseDetail(HttpServletRequest request,@Param(value="courseId")Integer courseId){
		CourseInfo courseInfo=teachingManageService.getCourseInfoByid(courseId);
		request.setAttribute("courseInfo", courseInfo);
		return "admin/lesson/courseDetail";
	}

	/**
	 * 
	 * @Title: listCourseApply
	 * @author wangxiaolong
	 * @Description:查询所有的排课申请
	 * @param
	 * @return
	 */
	@RequestMapping("/listCourseApply")
	@ResponseBody
	public PagePojo listCourseApply(@Param(value="groupId")Integer groupId,
			HttpSession session,@RequestParam(value="courseName")String courseName,
			@Param(value="pageNo")Integer pageNo,@Param(value="pageSize")Integer pageSize){
		UserInfo userInfo=(UserInfo)session.getAttribute(SysConstants.SYS_USER);
		if(groupId==null){
			groupId=userInfo.getGroupId();
		}
		Map<String, Object> params=new HashMap<>();
		params.put("groupId", groupId);
		params.put("courseName", courseName);
		List<Map<String,Object>>list= teachingManageService.listCourseApply(params,pageNo,pageSize);

		return PageUtil.Map2PageInfo(list);
	}

	/**
	 * 
	 * @Title: courseApply
	 * @author wangxiaolong
	 * @Description:课程审核
	 * @param
	 * @return
	 */
	@RequestMapping("/courseApply")
	@ResponseBody
	public ResJson courseApply(HttpServletRequest request,@Param("courseId")Integer courseId,@Param("userName")String userName,
			@Param("numberOfExpected")Integer numberOfExpected,@Param("courseName")String courseName){


		return teachingManageService.applyAndAddMeetingRoom(userName,courseId,numberOfExpected,courseName);	
	}

	/**
	 * 
	 * @Title: updateArrangeById
	 * @author wangxiaolong
	 * @Description:排课调整
	 * @param
	 * @return
	 */
	@RequestMapping("/updateArrangeById")
	@ResponseBody
	public ResJson updateArrangeById(HttpServletRequest request,@Param("id")Integer id,
			@Param("updateTime")Long updateTime){

		return teachingManageService.updateArrangeById(id,updateTime);	
	}

	
	
	/**
	 * 
	 * @Title: registerApply
	 * @author wangxiaolong
	 * @Description:报名审核,添加进会议室
	 * @param
	 * @return
	 */
	@RequestMapping("/registerApply")
	@ResponseBody
	public ResJson registerApply(HttpServletRequest request,@Param("id")Integer id,
			@Param("userName")String  userName,@Param("roomId")String roomId,
			@Param("courseId")Integer courseId){

		return teachingManageService.applyAndAddRoom(id,userName,roomId,courseId);	

	}
	/**
	 * 
	 * @Title: getTeachingPage
	 * @author wangxiaolong
	 * @Description:查询课程的信息，带分页
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/getCoursePage")
	@ResponseBody
	public PagePojo getCoursePage(@Param(value="nameVlaue")String nameVlaue,@Param(value="idVlaue")Integer idVlaue,
			@Param(value="pageNo")Integer pageNo,@Param(value="pageSize")Integer pageSize) {

		Map<String, Object> newmap =new HashMap<String, Object>();
		newmap.put("nameVlaue", nameVlaue);
		newmap.put("idVlaue", idVlaue);
		List<Map<String, Object>> map=teachingManageService.getTeachingPage(newmap,pageNo,pageSize);
		return PageUtil.Map2PageInfo(map);
	}

	/**
	 * 
	 * @Title: getTeachingByid
	 * @author wangxiaolong
	 * @Description:根据id查看单一课程信息
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/getTeachingByid")
	@ResponseBody
	public Map<String,Object>  getTeachingByid(@RequestParam("CpurseID")int CpurseID) throws Exception{
		Map<String, Object> map=teachingManageService.getTeachingByid(CpurseID);
		return map;
	}

	/**
	 * 
	 * @Title: updateTeachingStatus
	 * @author wangxiaolong
	 * @Description:根据id修改课程审核状态
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/updateTeachingStatus")
	@ResponseBody
	public Map<String,Object> updateTeachingStatus(@RequestParam("teachingID")int teachingID){
		Map<String, Object> result =new HashMap<String, Object>();
		Map<String, Object> map =new HashMap<String, Object>();
		try {
			map.put("teachingID", teachingID);
			teachingManageService.updateTeachingStatus(teachingID);
			result.put("flag", true);
			result.put("massge", "审核成功");
			return result;
		} catch (Exception e) {
			result.put("flag", false);
			result.put("massgefalse", "审核失败");
			return result;
		}

	}


	/**
	 * 
	 * @Title: getCourseArrangementeInfoPage
	 * @author wangxiaolong
	 * @Description:获取课程安排信息分页
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/listArrangePage")
	@ResponseBody
	public PagePojo listArrangePage(HttpSession session,@RequestParam("courseName")String courseName,
			@Param(value="pageNo")Integer pageNo,@Param(value="pageSize")Integer pageSize){

		UserInfo userInfo=(UserInfo)session.getAttribute(SysConstants.SYS_USER);
		Integer groupId=userInfo.getGroupId();
		Map<String, Object> params =new HashMap<String, Object>();
		params.put("groupId", groupId);
		params.put("courseName", courseName);
		List<Map<String, Object>> map=teachingManageService.listArrangePage(params,pageNo,pageSize);

		return PageUtil.Map2PageInfo(map);

	}

	/**
	 * 
	 * @Title: toCourseArrangementStatus
	 * @author wangxiaolong
	 * @Description:改变排课申请表状态
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/toCourseArrangementStatus/{id}")
	@ResponseBody
	public Map<String,Object> toCourseArrangementStatus(@PathVariable("id")int  id){
		Map<String,Object>  result=new HashMap<String,Object>();
		try {
			teachingManageService.updateCourseArrangementStatus(id);
			result.put("flag", true);
			result.put("massge", "审核成功");
			return result;
		} catch (Exception e) {
			result.put("flag", true);
			result.put("massge", "审核失败");
			return result;
		}

	}

	/**
	 * 
	 * @Title: listRegister
	 * @author wangxiaolong
	 * @Description:报名申请
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/listRegister")
	@ResponseBody
	public PagePojo listRegister(HttpServletRequest request,@RequestParam("courseName")String courseName,
			@Param(value="pageNo")Integer pageNo,@Param(value="pageSize")Integer pageSize){

		List<Map<String, Object>> map=teachingManageService.listRegister(courseName,pageNo,pageSize);
		return PageUtil.Map2PageInfo(map);
	}


}
