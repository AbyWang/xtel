package com.cdxt.xtel.pojo.res;

import java.io.Serializable;

/**
 * 
	* @author mabaoying
	* @ClassName:  ArticleGalRecord
	* @Description: 文章点赞表
	* @date: 2018年9月17日
	* @最后修改人:
	* @最后修改时间:
	*
 */
public class ArticleGalRecord implements Serializable{

	private static final long serialVersionUID = 1L;

	private Integer id;
	
	private Long time;
	
	private Integer articleId;
	
	private Integer userId;

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

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "ArticleGalRecord [id=" + id + ", time=" + time + ", articleId=" + articleId + ", userId=" + userId
				+ "]";
	}
	
	
}
