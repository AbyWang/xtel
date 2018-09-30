/**
 * 
 * @ClassName: GroupInfo.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月24日
 */
package com.cdxt.xtel.pojo.sys;

import java.io.Serializable;

/**
 * 
 * @ClassName: GroupInfo.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月24日
 */
public class GroupInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3988973057016036194L;
	
	private Integer id;
	//群组名称
	private String name;
	//上级id
	private Integer superiorGroupID;
	//群组当前人数
	private Integer currentHead;
	//群组最大容纳人数
	private Integer maxNumber;
	//群组对内开设的课程数量
	private Integer courseInner;
	//群组对外开设的课程数量
	private Integer courseOutter;
	//该群组的创建时间
	private Long createTime;
	//群组等级
	private Integer groupLevel;
	//是否叶子节点，1，子节点
	private Integer isLeaf;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSuperiorGroupID() {
		return superiorGroupID;
	}
	public void setSuperiorGroupID(Integer superiorGroupID) {
		this.superiorGroupID = superiorGroupID;
	}
	public Integer getCurrentHead() {
		return currentHead;
	}
	public void setCurrentHead(Integer currentHead) {
		this.currentHead = currentHead;
	}
	public Integer getMaxNumber() {
		return maxNumber;
	}
	public void setMaxNumber(Integer maxNumber) {
		this.maxNumber = maxNumber;
	}
	public Integer getCourseInner() {
		return courseInner;
	}
	public void setCourseInner(Integer courseInner) {
		this.courseInner = courseInner;
	}
	public Integer getCourseOutter() {
		return courseOutter;
	}
	public void setCourseOutter(Integer courseOutter) {
		this.courseOutter = courseOutter;
	}

	public Long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}
	public Integer getGroupLevel() {
		return groupLevel;
	}
	public void setGroupLevel(Integer groupLevel) {
		this.groupLevel = groupLevel;
	}
	public Integer getIsLeaf() {
		return isLeaf;
	}
	public void setIsLeaf(Integer isLeaf) {
		this.isLeaf = isLeaf;
	}

}
