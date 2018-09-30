/**
 * 
 * @ClassName: Exercises.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年8月23日
 */
package com.cdxt.xtel.pojo.lesson;

import java.io.Serializable;

/**
 * 
 * @ClassName: Exercises.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年8月23日
 */
public class Exercises implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2190627769104500615L;

	//习题ID
	private Integer id;
	
	//上传者ID
    private Integer uploaderId;
    
    //习题类型 0 – 选择题 1 – 问答题 2 – 填空题
    private Integer type;
    
    //习题记录的ID
    private Integer recordId;
    
    //上传时间
    private Long uploadTime;
    
    //习题摘要
    private String brief;
    
    //参考答案
    private String referenceAnswer;
    

	public String getReferenceAnswer() {
		return referenceAnswer;
	}

	public void setReferenceAnswer(String referenceAnswer) {
		this.referenceAnswer = referenceAnswer;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUploaderId() {
		return uploaderId;
	}

	public void setUploaderId(Integer uploaderId) {
		this.uploaderId = uploaderId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getRecordId() {
		return recordId;
	}

	public void setRecordId(Integer recordId) {
		this.recordId = recordId;
	}

	public Long getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Long uploadTime) {
		this.uploadTime = uploadTime;
	}

	public String getBrief() {
		return brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	@Override
	public String toString() {
		return "Exercises [id=" + id + ", uploaderId=" + uploaderId + ", type=" + type + ", recordId=" + recordId
				+ ", uploadTime=" + uploadTime + ", brief=" + brief + "]";
	} 

}
