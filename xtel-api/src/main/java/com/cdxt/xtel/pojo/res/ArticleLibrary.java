package com.cdxt.xtel.pojo.res;

import java.io.Serializable;
import java.util.List;

/**
 * 
	* @author mabaoying
	* @ClassName:  ArticleLibrary
	* @Description: 文库
	* @date: 2018年9月12日
	* @最后修改人:
	* @最后修改时间:
	*
 */
public class ArticleLibrary implements Serializable{

	private static final long serialVersionUID = 1L;
	private Integer id;//id
	private String name;//文章名
	private Integer uploaderId;//上传人
	private String userName;
	private Long uploadTime;//上传时间
	private String url;//url
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	private Integer hits;//点击量
	private Integer likes;//点赞数
	private String content;//文章内容
	
	private List<ArticleGalRecord> articleGalRecordList;
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
	public Integer getUploaderId() {
		return uploaderId;
	}
	public void setUploaderId(Integer uploaderId) {
		this.uploaderId = uploaderId;
	}
	public Long getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Long uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getHits() {
		return hits;
	}
	public void setHits(Integer hits) {
		this.hits = hits;
	}
	public Integer getLikes() {
		return likes;
	}
	public void setLikes(Integer likes) {
		this.likes = likes;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<ArticleGalRecord> getArticleGalRecordList() {
		return articleGalRecordList;
	}
	public void setArticleGalRecordList(List<ArticleGalRecord> articleGalRecordList) {
		this.articleGalRecordList = articleGalRecordList;
	}
	@Override
	public String toString() {
		return "ArticleLibrary [id=" + id + ", name=" + name + ", uploaderId=" + uploaderId + ", userName=" + userName
				+ ", uploadTime=" + uploadTime + ", url=" + url + ", hits=" + hits + ", likes=" + likes + ", content="
				+ content + ", articleGalRecordList=" + articleGalRecordList + "]";
	}
	
	
	
	
}
