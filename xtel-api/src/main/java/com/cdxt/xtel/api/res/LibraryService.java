package com.cdxt.xtel.api.res;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.res.ArticleLibrary;

public interface LibraryService {

	List<Map<String, Object>>getlibraryPage(Map<String, Object> newmap, Integer startRow, Integer pageSize);

	int deleteArticleById(Integer id);

	int addArticle(Map<String, Object> params) throws IOException;

	ArticleLibrary getArticleById(Integer id);

	int updateArticle(ArticleLibrary article);
	
	PagePojo listMyLibraryPage(Map<String, Object> map, Integer pageNo, Integer pageSize);

	ResJson onLikes(Map<String, Object> params);

	ResJson onHits(Map<String, Object> params);
}
