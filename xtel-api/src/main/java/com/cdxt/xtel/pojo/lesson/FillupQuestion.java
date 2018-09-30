/**
 * 
 * @ClassName: FillupQuestion.java
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
 * @ClassName: FillupQuestion.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年8月23日
 */
public class FillupQuestion implements Serializable{

	private static final long serialVersionUID = 2482328810098667968L;

	private Integer id;
	
	private String  stem;
	
	//待填写答案的空白处在题干中的位置，是一串json字符串
	private String gapPos;
	
	//空白个数
	private String gapNumber;

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

	public String getGapPos() {
		return gapPos;
	}

	public void setGapPos(String gapPos) {
		this.gapPos = gapPos;
	}

	public String getGapNumber() {
		return gapNumber;
	}

	public void setGapNumber(String gapNumber) {
		this.gapNumber = gapNumber;
	}
	
	
}
