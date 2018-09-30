/**
 * 
 * @ClassName: PagePojo.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月17日
 */
package com.cdxt.xtel.core.model;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * @ClassName: PagePojo.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月17日
 */
public class PagePojo implements Serializable{

	private static final long serialVersionUID = 1L;
	private  Integer page;
    private Long total;
    private List<?> rows;
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	public List<?> getRows() {
		return rows;
	}
	public void setRows(List<?> rows) {
		this.rows = rows;
	}
 
}