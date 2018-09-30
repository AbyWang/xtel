package com.cdxt.xtel.web.sys;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.sys.UserService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.pojo.sys.UserInfo;

/**
 * @ClassName: SystemController.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月18日
 */
@Controller
public class RedirectController {

	

	@Reference
	private UserService userService;


	/**
	 * 
	 * @Title: gotoSignUp
	 * @author wangxiaolong
	 * @Description:
	 * @param
	 * @return
	 */
	@RequestMapping("/toSignUp")
	public String gotoSignUp(HttpServletRequest request){
		List<Map<String, Object>>groupList=userService.getAllGroup();
		request.setAttribute("group", groupList);
		return "main/signup";
	}

	/**
	 * 
	 * @Title: toUser
	 * @author wangxiaolong
	 * @Description:登录页面跳转
	 * @param
	 * @return
	 */
	@RequestMapping("/toLogin")
	public ModelAndView toLogin(){

		return new ModelAndView("main/login");
	}
	

	/**
	 * 
	 * @Title: changePwd
	 * @author wangxiaolong
	 * @Description:修改密码
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoChangePwd")
	public ModelAndView gotoChangePwd(){

		return new ModelAndView("main/changePwd");
	}

	/**
	 * 
	 * @Title: gotoRegisterReview
	 * @author wangxiaolong
	 * @Description:报名审核
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoRegisterApply")
	public String gotoRegisterApply(){
		return "admin/lesson/registerList";
	}

	/**
	 * 
	 * @Title: systemLogin
	 * @author wangxiaolong
	 * @Description:登录页面跳转
	 * @param
	 * @return
	 */
	@RequestMapping("/login")
	public String systemLogin(HttpServletRequest request){

		return "main/main";
	}


	@RequestMapping(value ="/gotoGroupPage")
	public String gotoGroupPage(){
		return "admin/group/group_list";
	}

	/**
	 * 
	 * @Title: gotoRole
	 * @author wangxiaolong
	 * @Description:课程安排
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/gotoDatabasePage")
	public String gotoDatabasePage(){
		return "admin/sys/database";
	}


	/**
	 * 
	 * @Title: gotoCoursePage
	 * @author wangxiaolong
	 * @Description:
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/gotoVersionRelease")
	public String gotoVersionRelease(){
		return "admin/sys/versionList";
	}
	/**
	 * 
	 * @Title: gotoUserInfo
	 * @author wangxiaolong
	 * @Description:用户页面跳转
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/gotoUserInfo")
	public String gotoUserInfo(){
		return "admin/sys/userList";
	}
	/**
	 * 
	 * @Title: gotoRole
	 * @author wangxiaolong
	 * @Description:用户页面跳转
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/gotoRole")
	public String gotoRole(){
		return "admin/sys/roleList";
	}



	/**
	 * 
	 * @Title: logout
	 * @author wangxiaolong
	 * @Description:注销登录
	 * @param
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception{
		UserInfo userM = (UserInfo) session.getAttribute(SysConstants.SYS_USER);
		if(userM!=null){
		//	userInfoService.updateSystemManager(sysM.getId(), 0,SysConstants.INTEGER_ZERO);
			session.removeAttribute(SysConstants.SYS_USER);
		}
		session.invalidate();
		return "redirect:/toLogin";
	}

	
	/**
	 * 
	 * @Title: gotoRole
	 * @author wangxiaolong
	 * @Description:课程安排
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/gotoCoursePage")
	public String gotoCoursePage(){
		return "admin/lesson/courseList";
	}
	
	
	@RequestMapping(value ="/gotoArrangePage")
	public String gotoArrangePage(){
		return "admin/lesson/arrangeList";
	}
	
	
	@RequestMapping(value ="/gotoExamCheckList")
	public String gotoExamCheckList(){
		return "teach/exam/examCheck_list";
	}
	/**
	 * 
	 * @Title: gotoAllLesson
	 * @author wangxiaolong
	 * @Description:课程报名列表
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoAllLessonList")
	public String gotoAllLessonList(){
		return "user/lesson/allLesson_list";
	}
	
	/**
	 * 
	 * @Title: gotoMyLesson
	 * @author wangxiaolong
	 * @Description:课程管理列表
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoMyLessonList")
	public String gotoApplyLessonList(){
		return "teach/lesson/myLesson_list";
	}
	/**
	 * 
	 * @Title: gotoRegistered
	 * @author wangxiaolong
	 * @Description:已报名课程
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoRegisteredList")
	public String gotoRegisteredList(){
		return "user/lesson/registered_list";
	}
	/**
	 * 
	 * @Title: gotoRegistered
	 * @author wangxiaolong
	 * @Description:课程安排列表
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoManageList")
	public String gotoManageList(){
		return "teach/lesson/manage_list";
	}


	/**
	 * 
	 * @Title: gotoLessonPlan
	 * @author wangxiaolong
	 * @Description:课程安排
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoLessonPlan")
	public String gotoLessonArrange(){
		return "teach/lesson/lessonPlan";
	}

	/**
	 * 
	 * @Title: listExercise
	 * @author wangxiaolong
	 * @Description:试题管理列表
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoExerciseList")
	public String  listExercise(HttpServletRequest request){

		return "teach/exam/exercise_list";
	}


	/**
	 * 
	 * @Title: gotoAddExercise
	 * @author wangxiaolong
	 * @Description:新增习题
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoAddExercise")
	public String gotoAddExercise(){
		return "teach/exam/addExercise";
	}

	/**
	 * 
	 * @Title: gotoMyLibraryList
	 * @author wangxiaolong
	 * @Description:我的文库
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoMyLibraryList")
	public String gotoMyLibraryList(){
		return "user/cloud/myLibrary_list";
	}
	/**
	 * 
	 * @Title: gotoMyLibraryList
	 * @author wangxiaolong
	 * @Description:我的资料
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoMyDataList")
	public String gotoMyDataList(){
		return "user/cloud/myData_list";
	}
	
	/**
	 * 
	 * @Title: gotoMyLibraryList
	 * @author wangxiaolong
	 * @Description:文库
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoLibraryList")
	public String gotoLibraryList(){
		return "user/res/library_list";
	}
	/**
	 * 
	 * @Title: gotoMyLibraryList
	 * @author wangxiaolong
	 * @Description:资料
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoDataList")
	public String gotoDataList(){
		return "user/res/data_list";
	}

	/**
	 * 
	 * @Title: gotoMyLibraryList
	 * @author wangxiaolong
	 * @Description:试卷管理列表
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoExamPaperList")
	public String gotoExamPaperList(HttpServletRequest request ,@Param("courseId")Integer courseId){
		request.setAttribute("courseId", courseId);
		return "teach/exam/examPaper_list";
	}

	/**
	 * 
	 * @Title: gotoMyLibraryList
	 * @author wangxiaolong
	 * @Description:考试安排列表
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoExamPlanList")
	public String gotoExamPlanList(){
		return "teach/exam/examPlan_list";
	}

	/**
	 * 
	 * @Title: gotoMyLibraryList
	 * @author wangxiaolong
	 * @Description:我的成绩列表
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoOwnGradeList")
	public String gotoOwnGradeList(){
		return "user/exam/ownGrade_list";
	}

	@RequestMapping("/gotoChoiceExamList")
	public String gotoChoiceExamList(){
		
		return "teach/exam/choiceExam_list";
	}

	@RequestMapping("/gotoExamArrangeList")
	public String gotoExamArrangeList(){
		
		return "user/exam/examArrange_list";
	}
	
	
}
