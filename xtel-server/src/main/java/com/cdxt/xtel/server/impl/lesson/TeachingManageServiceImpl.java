package com.cdxt.xtel.server.impl.lesson;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;
import com.cdxt.xtel.api.lesson.TeachingManageService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.lesson.CourseInfo;
import com.cdxt.xtel.server.mapper.lesson.TeachingManageDao;
import com.github.pagehelper.PageHelper;


@Service
@Component
@Transactional
public class TeachingManageServiceImpl implements TeachingManageService {
	@Autowired
	private TeachingManageDao teachingManageDao;


	/**
	 * 
	 * @Title: listCourseApply
	 * @Description:查询排课申请
	 * @param
	 * @return
	 */
	public List<Map<String,Object>> listCourseApply(Map<String, Object> params,Integer pageNo, Integer pageSize){
		//分页
		PageHelper.startPage(pageNo, pageSize);
		return teachingManageDao.listCourseApply(params);
	}

	public	List<Map<String, Object>> listArrangePage(Map<String, Object> params, Integer pageNo, Integer pageSize){
		//分页
		PageHelper.startPage(pageNo, pageSize);
		return teachingManageDao.listArrangePage(params);
	}

	/**
	 * 
	 * @Title: unlockRoom
	 * @Description:房间解锁
	 * @param
	 * @return
	 */
//	public  void unlockRoom(int roomId,int lockType,int id){
//
//
//		teachingManageDao.updateArrangeStatusById(SysConstants.INTEGER_TWO,id);
//		Map<String, Object> paramMap = new HashMap<String, Object>();
//		paramMap.put("ROOMID_in", roomId);
//		paramMap.put("LOCK_TYPE", lockType);
//		teachingManageDao.unlockRoom(paramMap);
//	}


	public  ResJson updateArrangeById(Integer id,Long updateTime){
		int result=0;
		result=teachingManageDao.updateArrangeById(id,updateTime);

		if (result==0){
			return new ResJson(SysConstants.STRING_ZERO,"审核失败");
		}
		return new ResJson(SysConstants.STRING_ONE,"审核成功");
	}
	/**
	 * 
	 * @Title: courseApply
	 * @Description:课程申请审批
	 * @param
	 * @return
	 */
	public ResJson  applyAndAddMeetingRoom(String userName,Integer courseId,Integer numberOfExpected,String courseName){
		int result=0;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map<String, Object> map =null;
		Map<String, Object> idMap =null;
		Map<String, Object> retMap =null;
		Map<String, Object> getUserMap =null;
		Map<String, Object> addUserMap =null;
		Map<String, Object> hostMap =null;
		paramMap.put("ROOMNAME", courseName);
		paramMap.put("ROOM_CAPACITY", numberOfExpected);
		//创建会议室
		teachingManageDao.addMeetingRoom(paramMap);
		//存储过程返回roomId
		Integer roomId=(Integer) paramMap.get("ROOM_ID");
		if(roomId==null){
			return new ResJson(SysConstants.STRING_ZERO,"审核失败");
		}
		try{
			//审核通过,更新课程申请状态、roomid
			result=teachingManageDao.courseApply(roomId,courseId);
		}catch(Exception e){
			System.out.println(243);
			e.printStackTrace();
		}

		if(result!=1){
			return new ResJson(SysConstants.STRING_ZERO,"审核失败");
		}
		//更新排课安排状态
		teachingManageDao.updateCourseArrangementStatusByCourseId(courseId);

		//List<Map<String, Object>>mapList=teachingManageDao.getCourseArrangementeByCouorseId(courseId);
		//Boolean lessHalfHour=addDelay(mapList,roomId);

		map=new HashMap<String, Object>();
		map.put("ROOMID_in", roomId);
		map.put("LOCK_TYPE", SysConstants.INTEGER_ONE);
		teachingManageDao.lockRoom(map);
		//存储过程返回锁定结果
		Integer resultOut=(Integer) map.get("RESULT_out"); 


		//获取录制客户端id
		String userStrPapam=roomId+"_Recorder";
		idMap=new HashMap<String, Object>();
		idMap.put("USERSTRPARAM", userStrPapam);

		teachingManageDao.getUserId(idMap);
		Integer useridRet=(Integer) idMap.get("USERID_RET");
		if(useridRet!=null){
			//添加客户端
			retMap=new  HashMap<String, Object>();
			retMap.put("USERID_IN", useridRet);
			retMap.put("ROOMID_IN", roomId);
			teachingManageDao.addRecorder(retMap);
		}
		//获取会议室用户id
		getUserMap=new HashMap<String, Object>();
		getUserMap.put("USERSTRPARAM", userName);
		teachingManageDao.getUserId(getUserMap);
		Integer userIdRet=(Integer) getUserMap.get("USERID_RET");

		//向会议室中添加用户
		addUserMap=new HashMap<String, Object>();
		addUserMap.put("ROOMID_in", roomId);
		addUserMap.put("USERID_in", userIdRet);
		addUserMap.put("USERPWD_in", roomId);
		teachingManageDao.addMember2Room(addUserMap);

		//设置讲师为主持人
		hostMap=new HashMap<String, Object>();
		hostMap.put("ROOMID_in", roomId);
		hostMap.put("USERID_in", userIdRet);
		teachingManageDao.setRoomHost(hostMap);
		return new ResJson(SysConstants.STRING_ONE,"审核成功");
	}

	/**
	 * 
	 * @Title: addDelay
	 * @author wangxiaolong
	 * @Description:新增延时队列，开课前半小时，解除课程锁定
	 * @param
	 * @return
	 */
	/**
	public Boolean addDelay(List<Map<String, Object>>mapList,Integer roomId){
		long newTime=DateUtils.getMillis();
		Boolean lessHalfHour=false;
		//提前半个小时
		long delay=30*60*1000L;
		Map<String, Object>dataMap=null;
		for(Map<String, Object>planMap:mapList){
			Integer id=Integer.parseInt(planMap.get("ID").toString());
			long time=Long.parseLong(planMap.get("TIME").toString());
			//现在到开课时间前半个小时相差的毫秒数
			long sumTime=time-newTime-delay;
			//离开课时间大于半个小时的全部丢进延时队列中
			if(sumTime>0){
				dataMap=new HashMap<String, Object>();
				dataMap.put("delay", sumTime);
				dataMap.put("roomId", roomId);
				dataMap.put("id", id);
			//	sendMessage(destination, dataMap);
			}else{
				//其中出现小于半小时的课程
				lessHalfHour=true;
				teachingManageDao.updateArrangeStatusById(SysConstants.INTEGER_TWO,id);
			}
		}
		return lessHalfHour;
	}*/
	/**
	 * 
	 * @Title: applyAndAddRoom
	 * @Description:报名审核
	 * @param
	 * @return
	 */
	public 	ResJson applyAndAddRoom(int id,String userName,String roomId,Integer courseId){
		Map<String, Object> map =null;
		Map<String, Object> paramMap =null;
		int result=0 ,ups=0;
		CourseInfo course=teachingManageDao.getCourseInfoByid(courseId);
		if(course.getStatus()==4){//判断课程是否结束
			return new ResJson(SysConstants.STRING_TWO,"课程已结束");
		}
		//获取会议室用户id
		map=new HashMap<String, Object>();
		map.put("USERSTRPARAM", userName);
		//获取录制客户端id
		teachingManageDao.getUserId(map);
		Integer useridRet=(Integer) map.get("USERID_RET");

		//向会议室添加新成员
		paramMap=new HashMap<String, Object>();
		paramMap.put("ROOMID_in", roomId);
		paramMap.put("USERID_in", useridRet);
		paramMap.put("USERPWD_in", roomId);
		//创建会议室
		teachingManageDao.addMember2Room(paramMap);

		CourseInfo courseDetailInfo=teachingManageDao.getCourseInfoByid(courseId);
		//数据库版本号
		int version=courseDetailInfo.getVersion();
		//已售出数量
		int sold=courseDetailInfo.getSold();
		int total=courseDetailInfo.getNumberOfExpected();
		if(sold>=total){
			return new ResJson(SysConstants.STRING_TWO,"名额已满");
		}
		result=teachingManageDao.updateSignupSold(version,courseId);
		int num=0;
		//CAS模式库存扣减
		while (result == 0) {
			CourseInfo	courseInfo=new CourseInfo();
			courseInfo=teachingManageDao.getCourseInfoByid(courseId);
			if(courseInfo.getSold()>courseInfo.getNumberOfExpected()){
				return new ResJson(SysConstants.STRING_TWO,"名额已满");
			}
			result=teachingManageDao.updateSignupSold(version,courseId);
			num++;
			if(num==3){
				//跳出循环
				return new ResJson(SysConstants.STRING_TWO,"报名失败，请重试");
			}
		}
		//更新审核状态
		ups= teachingManageDao.registerApply(id);
		if(ups==0){
			return new ResJson(SysConstants.STRING_ZERO,"审核失败");
		}
		return new ResJson(SysConstants.STRING_ONE,"审核成功");

	}
	/**
	 * 
	 * @Title: getTeachingPage
	 * @Description:查询课程的信息，带分页
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> getTeachingPage(Map<String, Object> newmap, Integer pageNo, Integer pageSize) {

		//分页
		PageHelper.startPage(pageNo, pageSize);
		return teachingManageDao.getTeachingPage(newmap, pageNo, pageSize);

	}

	/**
	 * 
	 * @Title: getTeachingByid
	 * @author wangxiaolong
	 * @Description:根据id查看单一课程信息
	 * @param
	 * @return
	 */
	public Map<String, Object> getTeachingByid(int cpurseID) {

		return teachingManageDao.getTeachingByid(cpurseID);
	}


	/**
	 * 
	 * @Title: updateTeachingStatus
	 * @author wangxiaolong
	 * @Description:根据id修改课程审核状态
	 * @param
	 * @return
	 */
	public int updateTeachingStatus(int teachingID) {

		return teachingManageDao.updateTeachingStatus(teachingID);

	}



	public void updateCourseArrangementStatus(int id){

		//teachingManageDao.updateCourseArrangementStatus(id);

	}

	public 	List<Map<String,Object>> listRegister(String courseName,Integer pageNo, Integer pageSize){
		//分页
		PageHelper.startPage(pageNo, pageSize);
		return teachingManageDao.listRegister(courseName);
	}

	/**
	 * 
	 * @Title: getCourseInfobyCpurseID
	 * @author wangxiaolong
	 * @Description:查询课程信息单一记录
	 * @param
	 * @return
	 */
	public CourseInfo getCourseInfoByid(int cpurseID)  {

		return teachingManageDao.getCourseInfoByid(cpurseID);

	}


	/**
	public void sendMessage(Destination destination,final Map<String, Object> map){
		System.out.println(Thread.currentThread().getName()+" 向队列"+destination.toString()+"发送消息---------------------->");
		//	Map<String, Object>map=(Map<String, Object>) object;
		final Long delay=(Long) map.get("delay");

		//	jmsTemplate.convertAndSend(object,new ScheduleMessagePostProcessor(delay));
		jmsTemplate.send(new MessageCreator() {
			@Override
			public Message createMessage(Session session) throws JMSException {
				MapMessage message = session.createMapMessage();
				message.setObject("data", map);
				message.setLongProperty(ScheduledMessage.AMQ_SCHEDULED_DELAY, delay);//延时，delay为延时时长，以毫秒为单位
				return message;
			}
		});


	}*/
}
