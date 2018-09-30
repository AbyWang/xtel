/**
 * 
 * @ClassName: ExamArrangement.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年9月30日
 */
package com.cdxt.xtel.pojo.lesson;

import java.io.Serializable;

/**
 * 
 * @ClassName: ExamArrangement.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年9月30日
 */
public class ExamArrangement implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6916026355617147174L;

	private Integer id;
	
	private Long time; 

	private Integer courseId;
	
	private Integer paperId;
	
	private Integer userId;
	
	private Integer type;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Long getTime() {
		return time;
	}

	public void setTime(Long time) {
		this.time = time;
	}

	public Integer getCourseId() {
		return courseId;
	}

	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

	public Integer getPaperId() {
		return paperId;
	}

	public void setPaperId(Integer paperId) {
		this.paperId = paperId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	
}
