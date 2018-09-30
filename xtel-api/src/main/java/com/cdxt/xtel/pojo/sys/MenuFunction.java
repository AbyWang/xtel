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
import java.util.List;

/**
 * 
 * @ClassName: MenuFuction.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月11日
 */
public class MenuFunction implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;//id
	private Integer parent;//父id
	private Integer pageLevel;//该结点在树形结构中所属的层级
	private Integer pageOrder;//序号
	private Integer userType;//菜单类型0 – 列表
	private Integer createDate;//创建时间
	private String url;//菜单地址
	private String icon;//图标地址
	private String pageName;//菜单名称
	private List<MenuFunction>menuFunctions;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getParent() {
		return parent;
	}
	public void setParent(Integer parent) {
		this.parent = parent;
	}
	public Integer getPageLevel() {
		return pageLevel;
	}
	public void setPageLevel(Integer pageLevel) {
		this.pageLevel = pageLevel;
	}
	public Integer getPageOrder() {
		return pageOrder;
	}
	public void setPageOrder(Integer pageOrder) {
		this.pageOrder = pageOrder;
	}

	public Integer getUserType() {
		return userType;
	}
	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	public Integer getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Integer createDate) {
		this.createDate = createDate;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	public List<MenuFunction> getMenuFunctions() {
		return menuFunctions;
	}
	public void setMenuFunctions(List<MenuFunction> menuFunctions) {
		this.menuFunctions = menuFunctions;
	}
}
