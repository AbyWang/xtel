package com.cdxt.xtel.web.res;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.res.LibraryService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.utils.PageUtil;
import com.cdxt.xtel.pojo.res.ArticleLibrary;
import com.cdxt.xtel.pojo.sys.UserInfo;
/**
 * 
	* @author mabaoying
	* @ClassName:  LibraryController
	* @Description: 文库控制器
	* @date: 2018年9月17日
	* @最后修改人:
	* @最后修改时间:
	*
 */
@Controller
@RequestMapping(value="/library")
public class LibraryController {
	
	@Reference
	private LibraryService libraryService;
	
	
	@RequestMapping(value ="/gotoLibraryPage")
	public String gotoResourcesPage(){
		return "res/library_list";
	}
	
	/**
	 * 
	 * @Title: getlibraryPage
	 * @author wangxiaolong
	 * @Description:查询文库分页信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getlibraryPage")
	@ResponseBody
	public PagePojo getlibraryPage(@Param(value="nameValue")String nameValue,@Param(value="idVlaue")Integer idVlaue,@Param(value="pageNo")Integer pageNo,@Param(value="pageSize")Integer pageSize) {
		Map<String, Object> newmap =new HashMap<String, Object>();
		newmap.put("nameValue", nameValue);
		newmap.put("idVlaue", idVlaue);
		List<Map<String, Object>> list =libraryService.getlibraryPage(newmap,pageNo,pageSize);
		return PageUtil.Map2PageInfo(list);
	}
	
	/**
	 * 
		 * @Title: deleteArticle
		 * @Description:删除通过id删除文库
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月11日
		 * @return:
	 */
	@RequestMapping(value="/deleteArticleById/{id}")
	@ResponseBody
	public ResJson deleteArticleById(@PathVariable("id")Integer id){
		ResJson resJson;
		try {
			libraryService.deleteArticleById(id);
			resJson=new ResJson(SysConstants.STRING_ONE, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			resJson=new ResJson(SysConstants.STRING_TWO, "操作失败");
		}
		return resJson;
	}
	
	/**
	 * 
		 * @Title: toAddArticlePage
		 * @Description: 跳转到新增文库文章页面
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月11日
		 * @return:
	 */
	@RequestMapping(value="/toAddArticlePage")
	public String toAddArticlePage(){
		
		return "user/cloud/addArticle";
	}
	/**
	 * 
		 * @Title: addArticle
		 * @Description:新增文库文章
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月11日
		 * @return:
	 */
	@RequestMapping(value="/addArticle")
	@ResponseBody
	public ResJson addArticle(HttpSession session,@RequestParam("name")String name,@RequestParam("content")String content){
		ResJson result;
		UserInfo userinfo=(UserInfo)session.getAttribute("userInfo");
		Map<String, Object> params=new HashMap<>();
		params.put("uploaderId", userinfo.getUserId());//上传人
		params.put("name", name);//文章名
		params.put("content", content);//文章内容
		try {
			libraryService.addArticle(params);
			result=new ResJson(SysConstants.STRING_ONE, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			result=new ResJson(SysConstants.STRING_TWO, "操作失败");
		}
		return result;
	}
	
	/**
	 * 
		 * @Title: toEditArticlePage
		 * @Description: 跳转到修改文库文章页面
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月11日
		 * @return:
	 */
	@RequestMapping(value="/toEditArticlePage/{id}")
	public ModelAndView toEditArticlePage(@PathVariable("id")Integer id){
		ModelAndView mav=new ModelAndView();
		ArticleLibrary article=libraryService.getArticleById(id);
		mav.setViewName("user/cloud/editArticle");
		mav.addObject("article", article);
		return mav;
	}
	
	/**
	 * 
		 * @Title: updateArticle
		 * @Description:更新文库文章信息
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月12日
		 * @return:
	 */
	@RequestMapping(value="/updateArticle")
	@ResponseBody
	public ResJson updateArticle(@RequestParam("id")Integer id,@RequestParam("name")String name,@RequestParam("content")String content){
		ResJson result;
		ArticleLibrary article=new ArticleLibrary();
		article.setId(id);
		article.setName(name);
		article.setContent(content);
		try {
			libraryService.updateArticle(article);
			result=new ResJson(SysConstants.STRING_ONE, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			result=new ResJson(SysConstants.STRING_TWO, "操作失败");
		}
		return result;
	}
	
	/**
	 * 
		 * @Title: listAllLibraryPage
		 * @Description:获取全部文库文章信息
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月12日
		 * @return:
	 */
	@RequestMapping("/listAllLibraryPage")
	@ResponseBody
	public PagePojo listAllLibraryPage(@RequestParam(value="name")String name,
			@Param(value="pageNo")Integer pageNo,@RequestParam(value="pageSize")Integer pageSize) {
		Map<String, Object> map=new HashMap<>();
		map.put("name", name);
		return libraryService.listMyLibraryPage(map,pageNo,pageSize);	
	}
	
	/**
	 * 
		 * @Title: listAllLibraryPage
		 * @Description:获取当前用户文库文章信息
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月12日
		 * @return:
	 */
	@RequestMapping("/listMyLibraryPage")
	@ResponseBody
	public PagePojo listMyLibraryPage(@RequestParam(value="name")String name,HttpServletRequest request,@Param(value="pageNo")Integer pageNo,@RequestParam(value="pageSize")Integer pageSize) {

		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		Map<String, Object> map=new HashMap<>();
		map.put("userID", userID);
		map.put("name", name);
		return libraryService.listMyLibraryPage(map,pageNo,pageSize);	
	}
	
	/**
	 * 
		 * @Title: toArtileDetailPage
		 * @Description:去文库文章详情页面
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月12日
		 * @return:
	 */
	@RequestMapping(value="/toArtileDetailPage/{id}")
	public ModelAndView toArtileDetailPage(@PathVariable("id")Integer id){
		ModelAndView mav=new ModelAndView();
		ArticleLibrary article=libraryService.getArticleById(id);
		mav.setViewName("user/res/detailArticle");
		mav.addObject("article", article);
		return mav;
	}
	
	/**
	 * 
		 * @Title: onLikes
		 * @Description: 点赞
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月17日
		 * @return:
	 */
	@RequestMapping(value="/onLikes/{articleId}")
	@ResponseBody
	public ResJson onLikes(HttpSession session,@PathVariable("articleId")Integer articleId){
		UserInfo userinfo=(UserInfo) session.getAttribute("userInfo");
		int userId = userinfo.getUserId();
		Map<String, Object> params=new HashMap<>();
		params.put("articleId", articleId);
		params.put("userId", userId);
		ResJson result;
		try {
			result=libraryService.onLikes(params);
		} catch (Exception e) {
			result=new ResJson(SysConstants.STRING_TWO, "操作失败");
		}
		return result;
	}
	
	/**
	 * 
		 * @Title: onLikes
		 * @Description: 阅读数
		 * @最后修改人:mabaoying
		 * @最后修改时间:2018年9月17日
		 * @return:
	 */
	@RequestMapping(value="/onHits/{articleId}")
	@ResponseBody
	public ResJson onHits(HttpSession session,@PathVariable("articleId")Integer articleId){
		UserInfo userinfo=(UserInfo) session.getAttribute("userInfo");
		int userId = userinfo.getUserId();
		Map<String, Object> params=new HashMap<>();
		params.put("articleId", articleId);
		params.put("userId", userId);
		ResJson result;
		try {
			result=libraryService.onHits(params);
		} catch (Exception e) {
			result=new ResJson(SysConstants.STRING_TWO, "操作失败");
		}
		return result;
	}
	

}
