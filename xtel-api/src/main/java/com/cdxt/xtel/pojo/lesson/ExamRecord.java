/**
 * 
 * @ClassName: ExamRecord.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年9月28日
 */
package com.cdxt.xtel.pojo.lesson;

import java.io.Serializable;

/**
 * 
 * @ClassName: ExamRecord.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年9月28日
 */
public class ExamRecord implements Serializable{

	private static final long serialVersionUID = 1940946819697711752L;

	private Integer id;
	//用户id
	private Integer userId;
	//考试安排记录
	private Integer examId;
	//答卷时间
	private Long time;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getExamId() {
		return examId;
	}

	public void setExamId(Integer examId) {
		this.examId = examId;
	}

	public Long getTime() {
		return time;
	}

	public void setTime(Long time) {
		this.time = time;
	}
	
}
