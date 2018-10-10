package com.cdxt.xtel.web.lesson;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.time.DateUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.lesson.ExamService;
import com.cdxt.xtel.api.lesson.LessonCenterService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.lesson.ChoiceQuestion;
import com.cdxt.xtel.pojo.lesson.EssayQuestion;
import com.cdxt.xtel.pojo.lesson.ExamArrangement;
import com.cdxt.xtel.pojo.lesson.ExamPaper;
import com.cdxt.xtel.pojo.lesson.Exercises;
import com.cdxt.xtel.pojo.lesson.UserPerformance;
import com.cdxt.xtel.pojo.sys.UserInfo;
import com.sun.istack.internal.logging.Logger;

@Controller
@RequestMapping("/examController")
public class ExamController {

	private static final Logger logger = Logger.getLogger(ExamController.class);

	@Reference
	private  ExamService  examService;

	@Reference
	private LessonCenterService lessonCenterService;
	/**
	 * 
	 * @Title: listExcemPaper
	 * @author wangxiaolong
	 * @Description:试题管理
	 * @param
	 * @return
	 */
	@RequestMapping("/listExercise")
	@ResponseBody
	public PagePojo listExercise(HttpServletRequest request,@RequestParam(value="briefName")String briefName,
			@RequestParam(value="pageNo",defaultValue="0")Integer pageNo,
			@RequestParam(value="pageSize",defaultValue="10")Integer pageSize) throws Exception{

		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		Map<String, Object> params=new HashMap<>();
		params.put("userID", userID);
		params.put("briefName", briefName);
		return examService.listExercise(pageNo,pageSize,params);

	}

	/**
	 * @Title: addExercise
	 * @author wangxiaolong
	 * @Description:添加习题
	 * @param
	 * @return
	 */
	@RequestMapping("/addExercise")
	@ResponseBody
	public ResJson addExercise(HttpServletRequest request,Exercises exercises,ChoiceQuestion choiceQuestion,EssayQuestion essayQuestion){
		HttpSession session=request.getSession();
		UserInfo userinfo=(UserInfo) session.getAttribute("userInfo");
		int userID = userinfo.getUserId();
		exercises.setUploaderId(userID);
		return examService.addExercise(exercises,choiceQuestion,essayQuestion);
	}

	/**
	 * 
	 * @Title: listExcemPaper
	 * @author wangxiaolong
	 * @Description:考试试卷列表
	 * @param
	 * @return
	 */
	@RequestMapping("/listExcemPaper")
	@ResponseBody
	public PagePojo listExcemPaper(HttpServletRequest request,@RequestParam(value="paperName")String paperName,@Param("courseId")Integer courseId,
			@RequestParam(value="pageNo",defaultValue="0")Integer pageNo,@RequestParam(value="pageSize",defaultValue="10")Integer pageSize){
		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		Map<String, Object> params=new HashMap<>();
		params.put("userID", userID);
		params.put("paperName", paperName);
		params.put("courseId", courseId);
		return examService.listExaminationPage(pageNo,pageSize,params);
	}

	/**
	 * @Title: listExamPlan
	 * @author wangxiaolong
	 * @Description:考试安排
	 * @param
	 * @return
	 */
	@RequestMapping("/listExamPlan")
	@ResponseBody
	public PagePojo listExamPlan( HttpServletRequest request,@RequestParam(value="pageNo",defaultValue="0")Integer pageNo,@RequestParam(value="pageSize",defaultValue="10")Integer pageSize) throws Exception{
		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		return examService.getExaminationArrangementPage(userID,pageNo,pageSize);
	}


	/**
	 * 
	 * @Title: listOwnGrade
	 * @author wangxiaolong
	 * @Description:查询自己的成绩
	 * @param
	 * @return
	 */
	@RequestMapping("/listOwnGrade")
	@ResponseBody
	public PagePojo listOwnGrade( HttpServletRequest request,@Param(value="pageNo")Integer pageNo,@RequestParam(value="pageSize",defaultValue="10")Integer pageSize) throws Exception{
		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		return examService.getUserPerformancePage(userID,pageNo,pageSize);


	}

	/**
	 * 
	 * @Title: 
	 * @author 
	 * @Description:试题详情查询
	 * @param
	 * @return
	 */
	@RequestMapping("/getExerciseList/{type}")
	@ResponseBody
	public PagePojo getExerciseList(HttpSession session,@PathVariable("type")Integer type,@RequestParam(value="pageNo",defaultValue="0")Integer pageNo,@RequestParam(value="pageSize",defaultValue="10")Integer pageSize) throws Exception{
		UserInfo userinfo=(UserInfo) session.getAttribute("userInfo");
		int userID = userinfo.getUserId();
		return examService.getExerciseList(userID,type,pageNo,pageSize);

	}

	/**
	 * 
	 * @Title: listExerciseByUserId
	 * @author wangxiaolong
	 * @Description:根据用户id查询用户
	 * @param
	 * @return
	 */
	@RequestMapping("/listExerciseByIds")
	@ResponseBody
	public ResJson listExerciseByUserId(@RequestParam(value="ids[]")Integer[] ids,@RequestParam(value="type")Integer type) {

		try{
			List<Map<String, Object>>mapList=examService.listExerciseByIds(ids,type);
			return new ResJson(SysConstants.STRING_ONE,"查询成功",mapList);
		}catch(Exception e){
			logger.info(e.getMessage(),e);
		}
		return new ResJson(SysConstants.STRING_TWO,"查询失败");
	}



	/**
	 * 
	 * @Title: addExam
	 * @author wangxiaolong
	 * @Description:新增试卷
	 * @param
	 * @return
	 */
	@RequestMapping("/addExam")
	@ResponseBody
	public ResJson addExam(HttpServletRequest request,HttpSession session,ExamPaper paper) {
		try{
			String exerIds=request.getParameter("exerIds");
			String paperName=request.getParameter("paperName");
			String courseId=request.getParameter("courseId");
			String totalScore=request.getParameter("totalScore");
			String passScore=request.getParameter("passScore");
			UserInfo userInfo=(UserInfo) session.getAttribute(SysConstants.SYS_USER);
			paper.setCourseId(Integer.parseInt(courseId));
			paper.setPaperName(paperName);
			paper.setTotalScore(Integer.parseInt(totalScore));
			paper.setPassScore(Integer.parseInt(passScore));
			paper.setUploaderId(userInfo.getUserId());
			examService.addExam(exerIds,paper);
			return new ResJson(SysConstants.STRING_ONE,"保存成功");
		}catch(Exception e){
			logger.info(e.getMessage(),e);
			return new ResJson(SysConstants.STRING_TWO,"保存失败");
		}

	}

	/**
	 * 
	 * @Title: gotoAddExamPlan
	 * @author wangxiaolong
	 * @Description:考试安排
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoAddExamPlan")
	public ModelAndView gotoAddExamPlan(HttpServletRequest request){

		HttpSession session=request.getSession();
		UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
		List<Map<String, Object>>mapList=lessonCenterService.listAllValidCourseByUserId(SysConstants.INTEGER_TWO,userInfo.getUserId());
		request.setAttribute("courseList", mapList);
		return new ModelAndView("teach/exam/exam_plan");

	}
	/**
	 * 
	 * @Title: gotoExam
	 * @author wangxiaolong
	 * @Description:测验
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoExam")
	public ModelAndView gotoExam(HttpServletRequest request,@Param("paperId")Integer paperId,
			@Param("examId")Integer examId){
		request.setAttribute("examId", examId);
		request.setAttribute("paperId", paperId);
		return new ModelAndView("user/exam/exam");
	}

	/**
	 * 
	 * @Title: gotoExam
	 * @author wangxiaolong
	 * @Description:测验
	 * @param
	 * @return
	 */
	@RequestMapping("/gotoCheckExam")
	public ModelAndView gotoCheckExam(HttpServletRequest request,@Param("paperId")Integer paperId,
			@Param("id")Integer id,@Param("passScore")Integer passScore,@Param("examId")Integer examId){
        request.setAttribute("paperId", paperId);
        request.setAttribute("id", id);
        request.setAttribute("passScore", passScore);
        request.setAttribute("examId", examId);
		return new ModelAndView("teach/exam/exam_check");
	}

	/**
	 * 
	 * @Title: listExamArrangeByUserId
	 * @author wangxiaolong
	 * @Description:查询自己的考试安排
	 * @param
	 * @return
	 */
	@RequestMapping("/listExamArrangeByUserId")
	@ResponseBody
	public PagePojo listExamArrangeByUserId(HttpSession session,@Param("pageNo")Integer pageNo,
			@Param("pageSize")Integer pageSize){
		UserInfo user=(UserInfo) session.getAttribute(SysConstants.SYS_USER);
		return examService.listExamArrangeByUserId(pageNo,pageSize,user.getUserId());
	}

	/**
	 * 
	 * @Title: listExercisesByPaperId
	 * @author wangxiaolong
	 * @Description:根据试卷查询试题
	 * @param
	 * @return
	 */
	@RequestMapping("/listExercisesByPaperId")
	@ResponseBody
	public ResJson listExercisesByPaperId(@Param("paperId")Integer paperId){
		try{
			List<Map<String, Object>>mapList=examService.listExercisesByPaperId(paperId);
			return new ResJson(SysConstants.STRING_ONE,"查询成功",mapList);
		}catch(Exception e){
			logger.info(e.getMessage(),e);
			return new ResJson(SysConstants.STRING_TWO,"查询失败");
		}
	}	
	/**
	 * 
	 * @Title: addExamRecord
	 * @author wangxiaolong
	 * @Description:
	 * @param
	 * @return
	 */
	@RequestMapping("/addExamRecord")
	@ResponseBody
	public ResJson addExamRecord(HttpSession session,@Param("examId")Integer examId,@Param("answers")String answers){

		try{
			UserInfo userInfo=(UserInfo) session.getAttribute(SysConstants.SYS_USER);

			examService.addExamRecord(userInfo.getUserId(),examId,answers);
			return new ResJson(SysConstants.STRING_ONE,"保存成功");
		}catch(Exception e){
			logger.info(e.getMessage(),e);
			return new ResJson(SysConstants.STRING_TWO,"保存失败");
		}
	}
	/**
	 * 
	 * @Title: listExamRecord
	 * @author wangxiaolong
	 * @Description:试卷列表
	 * @param
	 * @return
	 */
	@RequestMapping("/listExamRecord")
	@ResponseBody
	public PagePojo listExamRecord(HttpSession session,@Param("pageNo")Integer pageNo,
			@Param("pageSize")Integer pageSize){

		UserInfo userInfo=(UserInfo) session.getAttribute(SysConstants.SYS_USER);

		return	examService.listExamRecord(pageNo,pageSize,userInfo.getUserId());

	}
	/**
	 * 
	 * @Title: getUserAnswers
	 * @author wangxiaolong
	 * @Description:获取用户答题记录
	 * @param
	 * @return
	 */
	@RequestMapping("/getUserDetailAnswers")
	@ResponseBody
	public ResJson getUserDetailAnswers(@Param("id")Integer id){
		try{
			List<Map<String, Object>>mapList=examService.getUserDetailAnswers(id);
			return new ResJson(SysConstants.STRING_ONE,"保存成功",mapList);
		}catch(Exception e){
			logger.info(e.getMessage(),e);
			return new ResJson(SysConstants.STRING_TWO,"保存失败");
		}
	}
	/**
	 * 
	 * @Title: getExamPaperByCourseId
	 * @author wangxiaolong
	 * @Description:根据课程查询试卷
	 * @param
	 * @return
	 */
	@RequestMapping("/getExamPaperByCourseId")
	@ResponseBody
	public ResJson getExamPaperByCourseId(@Param("courseId")Integer courseId){
		try{
			List<Map<String, Object>>mapList=examService.getExamPaperByCourseId(courseId);
			return new ResJson(SysConstants.STRING_ONE,"查询成功",mapList);
		}catch(Exception e){
			logger.info(e.getMessage(),e);
			return new ResJson(SysConstants.STRING_TWO,"查询失败");
		}
		
	}
	/**
	 * 
	 * @Title: addExamArrange
	 * @author wangxiaolong
	 * @Description:保存考试安排
	 * @param
	 * @return
	 */
	@RequestMapping("/addExamArrange")
	@ResponseBody
	public ResJson addExamArrange(HttpServletRequest request,ExamArrangement examArrangement){
		try{
			HttpSession session=request.getSession();
			//时间参数，待解决
	   //	 Long time =DateUtils.parseLong(request.getParameter("time"));
		//	ExamArrangement examArrangement=new ExamArrangement();

			UserInfo userInfo=(UserInfo) session.getAttribute(SysConstants.SYS_USER);
			examArrangement.setUserId(userInfo.getUserId());
		//	examArrangement.setCourseId(courseId);
		//	examArrangement.setPaperId(paperId);
		//	examArrangement.setTime(time);
		//	examArrangement.setType(type);
			examService.addExamArrange(examArrangement);
			return new ResJson(SysConstants.STRING_ONE,"保存成功");
		}catch(Exception e){
			logger.info(e.getMessage(),e);
			return new ResJson(SysConstants.STRING_TWO,"保存失败");
		}
	}
	/**
	 * 
	 * @Title: saveUserPerformance
	 * @author wangxiaolong
	 * @Description:
	 * @param
	 * @return
	 */
	@RequestMapping("/saveUserPerformance")
	@ResponseBody
	public ResJson saveUserPerformance(HttpSession session,UserPerformance userPerformance){
		try{
			UserInfo userInfo=(UserInfo) session.getAttribute(SysConstants.SYS_USER);
			userPerformance.setUserId(userInfo.getUserId());
			examService.saveUserPerformance(userPerformance);
			return new ResJson(SysConstants.STRING_ONE,"保存成功");
		}catch(Exception e){
			logger.info(e.getMessage(),e);
			return new ResJson(SysConstants.STRING_TWO,"保存失败");
		}		
	}
}
