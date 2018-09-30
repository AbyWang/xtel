/**
 * 
 * @ClassName: Exer2ExamPaper.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年9月19日
 */
package com.cdxt.xtel.pojo.lesson;

import java.io.Serializable;

/**
 * 
 * @ClassName: Exer2ExamPaper.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年9月19日
 */
public class Exer2ExamPaper implements Serializable{

	private static final long serialVersionUID = -9137760429541225697L;

	private Integer exerId ;
	
	private Integer paperId;

	private Integer id;
	
	//分数
	private Integer score;
	
	public Integer getExerId() {
		return exerId;
	}

	public void setExerId(Integer exerId) {
		this.exerId = exerId;
	}

	public Integer getPaperId() {
		return paperId;
	}

	public void setPaperId(Integer paperId) {
		this.paperId = paperId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}
	
}
