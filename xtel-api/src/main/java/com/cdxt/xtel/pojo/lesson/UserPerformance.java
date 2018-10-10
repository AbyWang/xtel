/**
 * 
 * @ClassName: UserPerformance.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年10月9日
 */
package com.cdxt.xtel.pojo.lesson;

import java.io.Serializable;

/**
 * 
 * @ClassName: UserPerformance.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年10月9日
 */
public class UserPerformance implements Serializable{

	private static final long serialVersionUID = 7437518464637281089L;
	
	private Integer userId;
	//试卷id
	private Integer paperId;
    //考试安排id
	private Integer examId;
	//成绩录入时间
	private Long time;
	//具体的得分
	private Long performance;
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getPaperId() {
		return paperId;
	}
	public void setPaperId(Integer paperId) {
		this.paperId = paperId;
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
	public Long getPerformance() {
		return performance;
	}
	public void setPerformance(Long performance) {
		this.performance = performance;
	}
	
}
