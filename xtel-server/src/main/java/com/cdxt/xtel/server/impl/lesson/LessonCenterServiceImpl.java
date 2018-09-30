package com.cdxt.xtel.server.impl.lesson;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;
import com.cdxt.xtel.api.lesson.LessonCenterService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.util.DateUtils;
import com.cdxt.xtel.core.util.PageUtil;
import com.cdxt.xtel.pojo.lesson.CourseInfo;
import com.cdxt.xtel.pojo.lesson.CoursePlan;
import com.cdxt.xtel.server.mapper.lesson.LessonCenterDao;
import com.github.pagehelper.PageHelper;



@Service
@Transactional
public class LessonCenterServiceImpl implements LessonCenterService {

	@Autowired
	private LessonCenterDao lessonCenterDao;

	@Override
	public PagePojo listAllLesson(Integer userId, Integer pageNo,Integer pageSize,String courseName)  {
		//分页
		PageHelper.startPage(pageNo, pageSize);
		Map<String, Object> params=new HashMap<>();
		params.put("userId", userId);
		params.put("courseName", courseName);
		List<Map<String, Object>> mapList=lessonCenterDao.listAllLesson(params);
		return PageUtil.Map2PageInfo(mapList);
	}

	@Override
	public PagePojo listMyLessonPage(Integer userID, Integer pageNo, Integer pageSize,String courseName){
		List<Map<String, Object>> list=new ArrayList<Map<String, Object>>();
		//分页
		PageHelper.startPage(pageNo, pageSize);
		Map<String, Object> params=new HashMap<>();
		params.put("userId", userID);
		params.put("courseName", courseName);
		list=lessonCenterDao.listMyLessonPage(params);

		return PageUtil.Map2PageInfo(list);
	}

	public 	ResJson updateArrangeById(Integer id,String updateTime){
		int result=0;
		result=lessonCenterDao.updateArrangeById(id,SysConstants.INTEGER_ZERO,DateUtils.str2Long(updateTime));
		if(result==0){
			return new ResJson(SysConstants.STRING_TWO,"更新失败");
		}
		return new ResJson(SysConstants.STRING_ONE,"更新成功");
	}
	/**
	 * @Title: listRegisteredLessonPage
	 * @Description:
	 * @param
	 * @return
	 */
	@Override
	public PagePojo listRegisteredLessonPage(Integer userID, Integer pageNo, Integer pageSize,String courseName) {
		//分页
		PageHelper.startPage(pageNo, pageSize);
		Map<String, Object> params=new HashMap<>();
		params.put("userID", userID);
		params.put("courseName", courseName);
		List<Map<String, Object>> list= lessonCenterDao.listRegisteredLessonPage(params);
		return PageUtil.Map2PageInfo(list);
	}

	/**
	 * @Title: listRegisteredLessonPage
	 * @Description:
	 * @param
	 * @return
	 */
	@Override
	public PagePojo listStudentByCourseId(Integer pageNo, Integer pageSize,Map<String, Object> params) {
		//分页
		PageHelper.startPage(pageNo, pageSize);
		List<Map<String, Object>> list= lessonCenterDao.listStudentByCourseId(params);
		return PageUtil.Map2PageInfo(list);
	}


	@Override
	public PagePojo listCourseArrangeInfoPage(Integer userID,Integer pageNo, Integer pageSize,String courseName) {
		//分页
		PageHelper.startPage(pageNo, pageSize);
		Map<String, Object> params=new HashMap<>();
		params.put("userID", userID);
		params.put("courseName", courseName);
		List<Map<String, Object>> list= lessonCenterDao.listCourseArrangeInfoPage(params);
		return PageUtil.Map2PageInfo(list);
	}


	/**
	 * 
	 * @Title: outTimeCourse
	 * @Description:查询是否有超时未结束的课程
	 * @param
	 * @return
	 */
	public  List<Map<String, Object>> outTimeCourse(Integer userId){
		Map<String, Object>map=new HashMap<String, Object>();
		
		Long newTime=DateUtils.getMillis();
		//默认一节课45分钟，延迟30分钟
		Long delay=75*60*1000L;
		Long deadTime=newTime-delay;
		map.put("userId", userId);
		map.put("deadTime", deadTime);
		map.put("id", null);
		return lessonCenterDao.outTimeCourse(map);
	}


	public  ResJson startClass(Integer courseId, Integer id,Integer roomId){
		Map<String, Object>map=lessonCenterDao.getArrangeByid(id);
		Map<String, Object> paramMap=null;
		int status=Integer.parseInt(map.get("STATUS").toString());
		if(status==2){
			return new ResJson(SysConstants.STRING_ONE,"开课成功");
		}
		if(status==1){
			long newTime=DateUtils.getMillis();
			long delay=30*60*1000L;
			long time=Long.parseLong(map.get("TIME").toString());
			//现在到开课时间前半个小时相差的毫秒数
			long sumTime=time-newTime-delay;
			//开课时间不到半小时
			if(sumTime<0){
				paramMap = new HashMap<String, Object>();
				paramMap.put("ROOMID_in", roomId);
				paramMap.put("LOCK_TYPE", SysConstants.INTEGER_ONE);
				paramMap.put("RESULT_out", 0);
				lessonCenterDao.unlockRoom(paramMap);
				Integer resultOut=(Integer) paramMap.get("RESULT_out");
				if(resultOut==0){
					lessonCenterDao.updateArrangeStatusById(SysConstants.INTEGER_TWO,id);
					return  new ResJson(SysConstants.STRING_ONE,"开课成功");
				}
			}
			return new ResJson(SysConstants.STRING_TWO,"还未到开课时间");
		}
		return  new ResJson(SysConstants.STRING_TWO,"开课失败");
	}

	@Override
	public ResJson stopClass(Integer id,Integer roomId,Integer courseId,String time,Integer userId) {
		int result=0;
		Map<String, Object> map=new HashMap<String, Object>();
		Long newTime=DateUtils.getMillis();
		//默认一节课45分钟，延迟30分钟
		Long delay=75*60*1000L;
		Long deadTime=newTime-delay;
		map.put("userId", userId);
		map.put("deadTime", deadTime);
		map.put("id", id);
		List<Map<String, Object>>mapList=lessonCenterDao.outTimeCourse(map);
		if(mapList==null||mapList.size()==0){
			return new ResJson(SysConstants.STRING_TWO,"课程未完成，不能结束");
		}
		Map<String, Object> paramMap=new HashMap<String, Object>();
		paramMap.put("ROOMID_in", roomId);
		paramMap.put("LOCK_TYPE", SysConstants.INTEGER_ONE);

		lessonCenterDao.lockRoom(paramMap);
		Integer resultOut=(Integer) paramMap.get("RESULT_out"); 
		if(resultOut!=1){
			return new ResJson(SysConstants.STRING_ZERO,"结束失败,请清空会议室");
		}
		result=lessonCenterDao.updateCourseArrangementStatusById(SysConstants.INTEGER_FOUR,id);
		if(result==0){
			return new ResJson(SysConstants.STRING_ZERO,"结束失败");
		}

		Map<String,Object> params=new HashMap<>();
		params.put("courseId", courseId);
		params.put("time", time);
		List<Map<String, Object>> list=lessonCenterDao.findArrangeByCourseIdMoreThanTime(params);
		//Map<String, Object> courseArrange=lessonCenterDao.getOneArrange(params);//获取下次排课信息
		if(list.size()==0){//下次没有课程安排记录，则更新课程状态为结束
			params.put("status", SysConstants.INTEGER_FOUR);
		}else{//更新下次开课时间
			params.put("lastClassTime", list.get(0).get("TIME"));
		}
		lessonCenterDao.updateCourseInfo(params);//更新课程信息
		//查询这门课所有的排课计划
		//		List<Map<String,Object>>mapList=lessonCenterDao.getCourseArrangementeByCouorseId(courseId);
		//		Boolean status=false;
		//		for(Map<String,Object>map:mapList){
		//			map.get("STATUS");
		//		}
		return new ResJson(SysConstants.STRING_ONE,"关闭成功");
	}

	public ResJson  deleteStudent(Integer id,String userName,Integer roomId){
		Map<String, Object> map =null;
		Map<String, Object> paramMap =null;
		Map<String, Object>dataMap=null;
		int result=0;

		//获取会议室用户id
		map=new HashMap<String, Object>();
		map.put("USERSTRPARAM", userName);
		//获取录制客户端id
		lessonCenterDao.getUserId(map);
		Integer userId=(Integer) map.get("USERID_RET");
		//从会议室中删除成员
		paramMap=new HashMap<String, Object>();
		paramMap.put("ROOMID_in",roomId);
		paramMap.put("USERID_in",userId);
		lessonCenterDao.delMemberFromRoom(paramMap);

//		dataMap=lessonCenterDao.getStudentById(id);
//		int status=Integer.parseInt(dataMap.get("STATUS").toString());
//		if(status==1){
//			return new ResJson(SysConstants.STRING_TWO,"已审核，不能删除");
//		}
		result=lessonCenterDao.deleteSignupById(id);
		if(result==0){
			return new ResJson(SysConstants.STRING_TWO,"删除失败");
		}
		return new ResJson(SysConstants.STRING_ONE,"删除成功");
	}

	@Override
	public Map<String, Object> getCourseInfoByid(Integer cpurseID){
		Map<String, Object> map=lessonCenterDao.getCourseInfoByid(cpurseID);
		return map;
	}

	@Override
	public ResJson insertSignup(Integer courseId,Integer userId) {
		//		int result=0;
		//Map<String, Object> map=new HashMap<String, Object>();
		//		CourseInfo courseDetailInfo=lessonCenterDao.getCourseInfobyCpurseID(courseId);
		//		//数据库版本号
		//		int version=courseDetailInfo.getVersion();
		//		//已售出数量
		//		int sold=courseDetailInfo.getSold();
		//		int total=courseDetailInfo.getNumberOfExpected();
		//		if(sold>=total){
		//			return new ResJson(SysConstants.STRING_TWO,"名额已满");
		//		}
		//		result=lessonCenterDao.updateSignupSold(version,courseId);
		//		int num=0;
		//		//CAS模式库存扣减
		//		while (result == 0) {
		//			CourseInfo	courseInfo=new CourseInfo();
		//			courseInfo=lessonCenterDao.getCourseInfobyCpurseID(courseId);
		//			if(courseInfo.getSold()>courseInfo.getNumberOfExpected()){
		//				return new ResJson(SysConstants.STRING_TWO,"名额已满");
		//			}
		//			result=lessonCenterDao.updateSignupSold(version,courseId);
		//			num++;
		//			if(num==3){
		//				//跳出循环
		//				return new ResJson(SysConstants.STRING_TWO,"报名失败，请重试");
		//			}
		//		}
		int res=0;
		res= lessonCenterDao.insertSignup(userId,courseId,new Date().getTime());
		if(res==0){
			return new ResJson(SysConstants.STRING_TWO,"保存失败");
		}
		return new ResJson(SysConstants.STRING_ONE,"保存成功");
	}




	@Override
	public void deleteClassInfo(Integer cpurseID) {
		lessonCenterDao.deleteClassInfo(cpurseID);

	}

	@Override
	public void insertCourseInfo(CourseInfo courseInfo,String divArrayStr){

		courseInfo.setStatus(SysConstants.INTEGER_ONE);
		courseInfo.setSold(SysConstants.INTEGER_ZERO);
		courseInfo.setPass(SysConstants.INTEGER_ZERO);
		courseInfo.setVersion(SysConstants.INTEGER_ZERO);

		if(StringUtils.isNoneBlank(divArrayStr)){
			List<CoursePlan>list=new ArrayList<CoursePlan>();
			divArrayStr= divArrayStr.replace("[", "").trim();
			divArrayStr= divArrayStr.replace("]", "").trim();
			String[]  divArrays= divArrayStr.split(",");
			Long array[] = new Long[divArrays.length];  
			for(int i=0;i<divArrays.length;i++){  
				String planArr = divArrays[i].replace("\"", "").trim();
				array[i]=DateUtils.str2Long(planArr); 
			}
			//数组排序
			Arrays.sort(array);
			//设置最后一次上课时间
			courseInfo.setLastClassTime(array[0]);
			lessonCenterDao.insertCourseInfo(courseInfo);
			int classNumber=1;
			for(Long time:array){
				CoursePlan coursePlan=new CoursePlan();
				//排课
				coursePlan.setCourseID(courseInfo.getCourseID());
				coursePlan.setTime(time);
				coursePlan.setClassNumber(classNumber);
				coursePlan.setStatus(SysConstants.INTEGER_ZERO);
				coursePlan.setUpdateTime(0L);
				list.add(coursePlan);
				classNumber++;
			}
			lessonCenterDao.batchInsertCoursePlan(list);
		}
	}

	/**
	 * 
	 * @Title: getCourseInfobyCpurseID
	 * @author wangxiaolong
	 * @Description:查询课程信息单一记录
	 * @param
	 * @return
	 */
	@Override
	public CourseInfo getCourseInfobyCpurseID(Integer cpurseID)  {

		return lessonCenterDao.getCourseInfobyCpurseID(cpurseID);

	}

	/**
	 * 
	 * @Title: updateCourse
	 * @Description:修改课程信息
	 * @param
	 * @return
	 */
	public ResJson updateCourse(CourseInfo courseInfo, String divArrayStr){
		int result=0;
		result=lessonCenterDao.updateCourse(courseInfo);
		if(result==0){
			return new ResJson(SysConstants.STRING_ZERO,"修改失败");
		}
		if(StringUtils.isNoneBlank(divArrayStr)){
			List<CoursePlan>list=new ArrayList<CoursePlan>();
			divArrayStr= divArrayStr.replace("[", "").trim();
			divArrayStr= divArrayStr.replace("]", "").trim();
			String[]  divArrays= divArrayStr.split(",");
			Long array[] = new Long[divArrays.length];  
			for(int i=0;i<divArrays.length;i++){  
				String planArr = divArrays[i].replace("\"", "").trim();
				array[i]=DateUtils.str2Long(planArr); 
			}
			//数组排序
			Arrays.sort(array);
			//设置最后一次上课时间
			courseInfo.setLastClassTime(array[0]);

			if(result==0){
				return new ResJson(SysConstants.STRING_ZERO,"修改失败");
			}
			//先将所有的课程计划删除掉，再新增
			lessonCenterDao.deleteCourseArrangement(courseInfo.getCourseID());
			int classNumber=1;
			for(Long time:array){
				CoursePlan coursePlan=new CoursePlan();
				//排课
				coursePlan.setCourseID(courseInfo.getCourseID());
				coursePlan.setTime(time);
				coursePlan.setClassNumber(classNumber);
				coursePlan.setStatus(SysConstants.INTEGER_ZERO);
				coursePlan.setUpdateTime(0L);
				list.add(coursePlan);
				classNumber++;
			}
			lessonCenterDao.batchInsertCoursePlan(list);	
		}
		return new ResJson(SysConstants.STRING_ONE,"修改成功");
	}

	@Override
	public Map<String, Object> getArrangeByid(Integer id){
		return lessonCenterDao.getArrangeByid(id);
	}

	@Override
	public void updateCourseArrangeTime(Map<String, Object> map) {
		lessonCenterDao.updateCourseArrangeTime(map);
	}

	@Override
	public void insertExpapersInfo(Map<String, Object> map){
		map.put("uplodaTime", new Date().getTime());
		map.put("TOTALSCORE", 0);
		map.put("PASSSCORE", 0);
		map.put("NUMBEROFPARTICIPANTS", 0);
		map.put("NUMBEROFPASS", 0);
		lessonCenterDao.insertExpapersInfo(map);
	}


	public 	List<Map<String, Object>> listAllValidCourseByUserId(Integer status,Integer userId){
		Map<String, Object> params=new HashMap<>();
		params.put("userId", userId);
		params.put("status", status);
		return lessonCenterDao.listMyLessonPage(params);
	}

}
