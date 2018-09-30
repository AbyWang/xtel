package com.cdxt.xtel.web.lesson;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.lesson.LessonCenterService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.lesson.CourseInfo;
import com.cdxt.xtel.pojo.sys.UserInfo;
import com.cdxt.xtel.web.sys.CommonController;


@Controller
@RequestMapping("/lessonCenterController")
public class LessonCenterController {

	private static final Logger logger = Logger.getLogger(CommonController.class);
	
	@Reference
	private LessonCenterService lessonCenterService;

	/**
	 * 
	 * @Title: gotoAddExercise
	 * @author wangxiaolong
	 * @Description:组卷
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoAddExam")
	public String gotoAddExam(HttpServletRequest request){
		HttpSession session=request.getSession();
		UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
		List<Map<String, Object>>mapList=lessonCenterService.listAllValidCourseByUserId(SysConstants.INTEGER_TWO,userInfo.getUserId());
		request.setAttribute("courseList", mapList);
		return "teach/exam/addExam";
	}

	
	/**
	 * 
	 * @Title: listAllLesson
	 * @author wangxiaolong
	 * @Description:查询已通过课程的信息，带分页
	 * @param
	 * @return
	 */
	@RequestMapping("/listAllLesson")
	@ResponseBody
	public PagePojo listAllLesson(HttpServletRequest request, @Param(value="pageNo")Integer pageNo,
			@Param(value="pageSize")Integer pageSize) {
		String courseName=request.getParameter("courseName");
		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		return lessonCenterService.listAllLesson(userID,pageNo,pageSize,courseName);
	}

	/**
	 * 
	 * @Title: stopClass
	 * @author wangxiaolong
	 * @Description:课时结束
	 * @param
	 * @return
	 */
	@RequestMapping("/stopClass")
	@ResponseBody
	public ResJson stopClass(HttpSession session,
			Integer id,Integer roomId,Integer courseId,String time){
		
		UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
		Integer userId=userInfo.getUserId();
		
		
		return lessonCenterService.stopClass(id,roomId,courseId,time,userId);
	}

	/**
	 * 
	 * @Title: outTimeCourse
	 * @author wangxiaolong
	 * @Description:查询超时未结束的课程
	 * @param
	 * @return
	 */
	@RequestMapping("/outTimeCourse")
	@ResponseBody
	public ResJson  outTimeCourse(HttpSession session){
		try{
			UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
			Integer userId=userInfo.getUserId();
			List<Map<String, Object>>mapList=lessonCenterService.outTimeCourse(userId);
			return new ResJson(SysConstants.STRING_ONE,"查询成功",mapList);
		}catch(Exception e){
			logger.info(e.getMessage());
			return new ResJson(SysConstants.STRING_TWO,"查询失败");
		}
	}

	/**
	 * 
	 * @Title: getoSignUp
	 * @author wangxiaolong
	 * @Description:报名跳转
	 * @param
	 * @return
	 */
	@RequestMapping("/getoRegister")
	public String getoRegister(HttpServletRequest request,@Param(value="courseId")Integer courseId){
		CourseInfo courseInfo=lessonCenterService.getCourseInfobyCpurseID(courseId);
		request.setAttribute("courseInfo", courseInfo);
		return "user/lesson/register";
	}



	@RequestMapping("/addApply")
	public String add(HttpServletRequest request,Integer id,Integer time){
		request.setAttribute("id", id);
		request.setAttribute("time", time);
		return "teach/lesson/addApply";
	}





	/**
	 * 
	 * @Title: gotoStudent
	 * @author wangxiaolong
	 * @Description:课程下的学生列表
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoStudent")
	public String gotoStudent(HttpServletRequest request,@Param("courseId")Integer courseId){
		request.setAttribute("courseId", courseId);
		return "teach/lesson/student_list";
	}


	@RequestMapping("/updateApply")
	public String updateApply(HttpServletRequest request){
		String courseId=request.getParameter("courseId");
		if(StringUtils.isNotBlank(courseId)){
			Integer id= Integer.valueOf(courseId);
			CourseInfo courseInfo=lessonCenterService.getCourseInfobyCpurseID(id);
			request.setAttribute("courseInfo", courseInfo);
		}
		return "teach/lesson/updateApply";
	}

	/**
	 * 
	 * @Title: listStudentByCourseId
	 * @author wangxiaolong
	 * @Description:查询某门课下的所有学员
	 * @param
	 * @return
	 */
	@RequestMapping("/listStudentByCourseId")
	@ResponseBody
	public PagePojo listStudentByCourseId(@Param(value="pageNo")Integer pageNo,@RequestParam(value="userName")String userName,
			@Param(value="pageSize")Integer pageSize,@Param("courseId")Integer courseId){
		Map<String, Object> params=new HashMap<>();
		params.put("courseId", courseId);
		params.put("userName",userName);
		return lessonCenterService.listStudentByCourseId(pageNo,pageSize,params);
	}

	/**
	 * 
	 * @Title: getmycuriculumPage
	 * @author wangxiaolong
	 * @Description:获取自己的已申请课程分页信息
	 * @param
	 * @return
	 */
	@RequestMapping("/listMyLessonPage")
	@ResponseBody
	public PagePojo listMyLessonPage(HttpServletRequest request,@RequestParam(value="courseName")String courseName, 
			@RequestParam(value="pageNo",defaultValue="0")Integer pageNo,
			@RequestParam(value="pageSize",defaultValue="10")Integer pageSize) {
		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		//只查询未审核的
		return lessonCenterService.listMyLessonPage(userID,pageNo,pageSize,courseName);
	}


	/**
	 * 
	 * @Title: deleteStudent
	 * @author wangxiaolong
	 * @Description:删除某门课的成员
	 * @param
	 * @return
	 */
	@RequestMapping("/deleteStudent")
	@ResponseBody
	public ResJson deleteStudent(@Param("id")Integer id,@Param("roomId")Integer roomId,
			@Param("userName")String  userName) {
		try{
			return lessonCenterService.deleteStudent(id,userName,roomId);
		}catch(Exception e){
			logger.info(e.getMessage());
			return new ResJson(SysConstants.STRING_TWO,"删除失败");
		}
	}
	/**
	 * 
	 * @Title: listRegisteredLessonPage
	 * @author wangxiaolong
	 * @Description:获取已报名信息
	 * @param
	 * @return
	 */
	@RequestMapping("/listRegisteredLessonPage")
	@ResponseBody
	public PagePojo listRegisteredLessonPage(HttpServletRequest request,@RequestParam(value="courseName")String courseName,
			@RequestParam(value="pageNo",defaultValue="0")Integer pageNo,
			@RequestParam(value="pageSize",defaultValue="10")Integer pageSize) {
		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		return lessonCenterService.listRegisteredLessonPage(userID,pageNo,pageSize,courseName);

	}	





	/**
	 * 
	 * @Title: listCourseArrangeInfoPage
	 * @author wangxiaolong
	 * @Description:查询我的课程安排信息
	 * @param
	 * @return
	 */
	@RequestMapping("/listLsssonArrangePage")
	@ResponseBody
	public PagePojo listLsssonArrangePage(HttpServletRequest request,@RequestParam(value="courseName")String courseName, 
			@RequestParam(value="pageNo")Integer pageNo,
			@RequestParam(value="pageSize",defaultValue="10")Integer pageSize){
		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		return lessonCenterService.listCourseArrangeInfoPage(userID,pageNo,pageSize,courseName);
	}	

	/**
	 * @Title: updateCoursePlan
	 * @author wangxiaolong
	 * @Description:修改课程
	 * @param
	 * @return
	 */
	@RequestMapping("/updateCourse")
	@ResponseBody
	public ResJson updateCourse(HttpServletRequest request,CourseInfo courseInfo,@RequestParam("divArrayStr")String divArrayStr){

		return lessonCenterService.updateCourse(courseInfo,divArrayStr);

	}
	/**
	 * 
	 * @Title: insertSignup
	 * @author wangxiaolong
	 * @Description:课程报名
	 * @param
	 * @return
	 */
	@RequestMapping("/insertSignup")
	@ResponseBody
	public ResJson insertSignup(HttpServletRequest request,@Param("courseId")int courseId){
		HttpSession session=request.getSession();
		UserInfo user = (UserInfo)session.getAttribute("userInfo");

		return 	lessonCenterService.insertSignup(courseId,user.getUserId());
	}


	/**
	 * 
	 * @Title: updateArrangeById
	 * @author wangxiaolong
	 * @Description:修改课程安排
	 * @param
	 * @return
	 */
	@RequestMapping("/updateArrangeById")
	@ResponseBody
	public ResJson updateArrangeById(HttpServletRequest request){
		String id=request.getParameter("id");
		String updateTime=request.getParameter("updateTime");
		return lessonCenterService.updateArrangeById(Integer.parseInt(id),updateTime);
	}


	/**
	 * 
	 * @Title: startClass
	 * @author wangxiaolong
	 * @Description:开课
	 * @param
	 * @return
	 */
	@RequestMapping("/startClass")
	@ResponseBody
	public ResJson startClass(@Param("courseId")int courseId,@Param("id")int id,@Param("roomId")int roomId){

		return lessonCenterService.startClass(courseId,id,roomId);
	}



	/**
	 * @描述:新增试卷信息
	 * @方法名: insertExpapersInfo
	 * @param id
	 * @param expapersNmae
	 * @param expapersurl
	 * @param request
	 * @return
	 * @返回类型 Map<String,Object>
	 * @创建人 张兴成
	 * @创建时间 2018年5月22日上午11:07:45
	 * @修改人 张兴成
	 * @修改时间 2018年5月22日上午11:07:45
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/insertExpapersInfo")
	@ResponseBody
	public Map<String,Object> insertExpapersInfo(HttpServletRequest  request,@RequestParam("id")int id,@RequestParam("expapersNmae")String expapersNmae,@RequestParam("expapersurl")String expapersurl){
		Map<String, Object> result =new HashMap<String, Object>();
		Map<String, Object> map =new HashMap<String, Object>();
		try {
			UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
			int userID = userinfo.getUserId();
			map.put("id", id);
			map.put("expapersNmae", expapersNmae);
			map.put("expapersUrl", expapersurl);
			map.put("userID", userID);
			lessonCenterService.insertExpapersInfo(map);

			result.put("flag", true);
			result.put("massge", "添加成功");
			return result;
		} catch (Exception e) {
			result.put("flag", false);
			result.put("massgefalse", "添加失败");
			return result;
		}

	}

	/**
	 * 
	 * @Title: insertCourseInfo
	 * @author wangxiaolong
	 * @Description:新增课程
	 * @param
	 * @return
	 */
	@RequestMapping("/insertCourseInfo")
	@ResponseBody
	public ResJson insertCourseInfo(CourseInfo courseInfo,HttpServletRequest  request ){
		String divArrayStr=request.getParameter("divArrayStr");
		try {
			UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
			courseInfo.setLectureID(userinfo.getUserId());

			lessonCenterService.insertCourseInfo(courseInfo,divArrayStr);
			return new ResJson(SysConstants.STRING_ONE,"添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResJson(SysConstants.STRING_ZERO,"添加失败");
		}
	}





}
