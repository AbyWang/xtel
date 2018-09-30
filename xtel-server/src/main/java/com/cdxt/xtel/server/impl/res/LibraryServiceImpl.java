package com.cdxt.xtel.server.impl.res;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;
import com.cdxt.xtel.api.res.LibraryService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.util.PageUtil;
import com.cdxt.xtel.pojo.res.ArticleLibrary;
import com.cdxt.xtel.server.mapper.res.LibraryDao;
import com.github.pagehelper.PageHelper;
@Service
@Transactional
public class LibraryServiceImpl implements LibraryService {
	@Autowired
	private LibraryDao libraryDao;

	@Override
	public 	List<Map<String, Object>>  getlibraryPage(Map<String, Object> newmap, Integer pageNo, Integer pageSize){
		
		//分页
		PageHelper.startPage(pageNo, pageSize);
		return libraryDao.getlibraryPage(newmap);
	}
	
	/**
	 * 通过id删除文库文章
	 */
	@Override
	public int deleteArticleById(Integer id) {
		
		return libraryDao.deleteArticleById(id);
	}

	/**
	 * 添加文库文章
	 */
	@Override
	public int addArticle(Map<String, Object> params) throws IOException {
		
		params.put("uploadTime",new Date().getTime());//上传时间
		params.put("hits", 0);//点击量
		params.put("likes", 0);//点赞数
		return libraryDao.addArticle(params);
	}

	/**
	 * 通过id获取文库文章
	 */
	@Override
	public ArticleLibrary getArticleById(Integer id) {
		return libraryDao.getArticleById(id);
	}

	/**
	 * 更新文库文章信息
	 */
	@Override
	public int updateArticle(ArticleLibrary article) {
		
		return libraryDao.updateArticle(article);
	}
	
	/**
	 * 查询文章文库信息
	 */
	@Override
	public PagePojo listMyLibraryPage(Map<String, Object> map, Integer pageNo, Integer pageSize)  {
		PageHelper.startPage(pageNo, pageSize);
		List<ArticleLibrary> list= libraryDao.listMyLibraryPage(map);
		return PageUtil.ObjectPageInfo(list);
	
	}
	/**
	 * 文章文库点赞
	 */
	@Override
	public ResJson onLikes(Map<String, Object> params) {
		
		//先查询artcleId和userId是否在点赞表有记录
		List<Map<String, Object>> list=libraryDao.getArticleGalRecord(params);
		if(list.size()==0){//没有记录就新增  点赞
			params.put("time", new Date().getTime());
			libraryDao.addArticleGalRecord(params);
		}else{//有就删除  取消赞
			libraryDao.deleteArticleGalRecordById(Integer.parseInt(list.get(0).get("ID").toString()));
		}
		int count=libraryDao.countArticleGalRecordByArticleId((int) params.get("articleId"));//统计点赞数
		return new ResJson(SysConstants.STRING_ONE, "成功", count);
	}
	/**
	 * 文库文章阅读数
	 */
	@Override
	public ResJson onHits(Map<String, Object> params) {
		
		int count=libraryDao.countArticleClickRecord(params);//统计每个文章每个用户每天的记录
		if(count==0){//新增阅读记录
			params.put("time", new Date().getTime());
			libraryDao.addArticleClickRecord(params);
		}
		return new ResJson(SysConstants.STRING_ONE, "成功");
	}
}
