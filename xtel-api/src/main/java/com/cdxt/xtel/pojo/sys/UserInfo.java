/**
 * 
 * @ClassName: MenuFuction.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月11日
 */
package com.cdxt.xtel.pojo.sys;

import java.io.Serializable;

/**
 * 
 * @ClassName: MenuFuction.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月11日
 */
public class UserInfo  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 481550340251084555L;
	
	private Integer userId;//用户ID
	private String userName;//登录用户名
	private Integer groupId;//用户所属的群组ID
	private String groupName;//用户所属的群组ID
	private Long registTime;//用户注册时间
	private Integer purchasedCourse;//已购买课程数量
	private Integer passCourse;//及格课程数
	private Integer excellentCourse;//得优课程数
	private Integer learningCourse;//正在学习课程数
	private Integer completecourse;//已完成课程数
	private Integer lectures;//成为讲师的次数
	private Integer isOnline;//当前在线状态
	private long loginTime;//最近登录时间
	private String  password;//登录密码
	private Integer status;//用户状态
	private String nickName;//用户昵称
	private Integer userType;//用户类型
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Integer getGroupId() {
		return groupId;
	}
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public Integer getPurchasedCourse() {
		return purchasedCourse;
	}
	public void setPurchasedCourse(Integer purchasedCourse) {
		this.purchasedCourse = purchasedCourse;
	}
	public Integer getPassCourse() {
		return passCourse;
	}
	public void setPassCourse(Integer passCourse) {
		this.passCourse = passCourse;
	}

	public Integer getExcellentCourse() {
		return excellentCourse;
	}
	public void setExcellentCourse(Integer excellentCourse) {
		this.excellentCourse = excellentCourse;
	}
	public Integer getLearningCourse() {
		return learningCourse;
	}
	public void setLearningCourse(Integer learningCourse) {
		this.learningCourse = learningCourse;
	}
	public Integer getCompletecourse() {
		return completecourse;
	}
	public void setCompletecourse(Integer completecourse) {
		this.completecourse = completecourse;
	}
	public Integer getLectures() {
		return lectures;
	}
	public void setLectures(Integer lectures) {
		this.lectures = lectures;
	}
	public Integer getIsOnline() {
		return isOnline;
	}
	public void setIsOnline(Integer isOnline) {
		this.isOnline = isOnline;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Long getRegistTime() {
		return registTime;
	}
	public void setRegistTime(Long registTime) {
		this.registTime = registTime;
	}
	public long getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(long loginTime) {
		this.loginTime = loginTime;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getUserType() {
		return userType;
	}
	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	

}
