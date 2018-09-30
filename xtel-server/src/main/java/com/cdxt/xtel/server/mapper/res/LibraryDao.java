package com.cdxt.xtel.server.mapper.res;

import java.util.List;
import java.util.Map;

import com.cdxt.xtel.pojo.res.ArticleLibrary;

public interface LibraryDao {



	List<Map<String, Object>> getlibraryPage(Map<String, Object> newmap);


	int deleteArticleById(Integer id);

	int addArticle(Map<String, Object> params);

	ArticleLibrary getArticleById(Integer id);

	int updateArticle(ArticleLibrary article);
	
	List<ArticleLibrary> listMyLibraryPage(Map<String, Object> map);


	List<Map<String, Object>> getArticleGalRecord(Map<String, Object> params);


	int addArticleGalRecord(Map<String, Object> params);


	int deleteArticleGalRecordById(int id);


	int countArticleGalRecordByArticleId(int articleId);


	int countArticleClickRecord(Map<String, Object> params);


	int addArticleClickRecord(Map<String, Object> params);
}
