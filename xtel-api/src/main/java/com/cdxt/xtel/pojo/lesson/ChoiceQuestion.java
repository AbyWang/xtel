/**
 * 
 * @ClassName: ChoiceQuestion.java
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
 * @ClassName: ChoiceQuestion.java
 * @Description:选择题
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年8月23日
 */
public class ChoiceQuestion implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1055824374649799553L;
	
	private Integer id;
	//题干
	private String  stem;
	//选项个数
	private Integer numberOfOptions;
	
	//选项
	private String  option1;
	
	private String option2;
	
	private String option3;
	
	private String option4;
	
	private String option5;
	
	private String option6;

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

	public String getStem() {
		return stem;
	}

	public void setStem(String stem) {
		this.stem = stem;
	}

	public Integer getNumberOfOptions() {
		return numberOfOptions;
	}

	public void setNumberOfOptions(Integer numberOfOptions) {
		this.numberOfOptions = numberOfOptions;
	}
	public String getOption1() {
		return option1;
	}

	public void setOption1(String option1) {
		this.option1 = option1;
	}

	public String getOption2() {
		return option2;
	}

	public void setOption2(String option2) {
		this.option2 = option2;
	}

	public String getOption3() {
		return option3;
	}

	public void setOption3(String option3) {
		this.option3 = option3;
	}

	public String getOption4() {
		return option4;
	}

	public void setOption4(String option4) {
		this.option4 = option4;
	}

	public String getOption5() {
		return option5;
	}

	public void setOption5(String option5) {
		this.option5 = option5;
	}

	public String getOption6() {
		return option6;
	}

	public void setOption6(String option6) {
		this.option6 = option6;
	}

	@Override
	public String toString() {
		return "ChoiceQuestion [id=" + id + ", stem=" + stem + ", numberOfOptions=" + numberOfOptions + ", option1="
				+ option1 + ", option2=" + option2 + ", option3=" + option3 + ", option4=" + option4 + ", option5="
				+ option5 + ", option6=" + option6 + "]";
	}
	
}
