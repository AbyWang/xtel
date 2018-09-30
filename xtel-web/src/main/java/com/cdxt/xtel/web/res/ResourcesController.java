package com.cdxt.xtel.web.res;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.res.ResourcesService;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.utils.PageUtil;
import com.cdxt.xtel.pojo.sys.UserInfo;

@Controller
@RequestMapping(value="/resourcesController")
public class ResourcesController {
	
	@Reference
	private ResourcesService resourcesService;
	
	
	@RequestMapping(value ="/gotoResourcesPage")
	public String gotoResourcesPage(){
		return "res/courseWare_list";
	}
	

	/**
	 * 
	 * @Title: getResourcesPage
	 * @author wangxiaolong
	 * @Description:获取课件管理分页信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getResourcesPage")
	@ResponseBody
	public PagePojo getResourcesPage(@Param(value="nameVlaue")String nameVlaue,@Param(value="idVlaue")Integer idVlaue,@Param(value="pageNo")Integer pageNo,@RequestParam(value="pageSize")Integer pageSize){
		
	
			Map<String, Object> newmap =new HashMap<String, Object>();
			newmap.put("nameVlaue", nameVlaue);
			newmap.put("idVlaue", idVlaue);
			List<Map<String, Object>> map=resourcesService.getResourcesPage(newmap,pageNo,pageSize);
			return PageUtil.Map2PageInfo(map);
	
	}
	
	
	/**
	 * @描述:查询课件属于课程的数量
	 * @方法名: findCoursewareInfoByidcount
	 * @param courseId
	 * @return
	 * @返回类型 Map<String,Object>
	 * @创建人 张兴成
	 * @创建时间 2018年4月27日下午2:45:07
	 * @修改人 张兴成
	 * @修改时间 2018年4月27日下午2:45:07
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/findCoursewareInfoByidcount/{courseId}")
	@ResponseBody
	public Map<String,Object> findCoursewareInfoByidcount(@PathVariable(value="courseId")int courseId){
		
		Map<String,Object> result=new HashMap<>();
		try {
			int  count=resourcesService.findCoursewareInfoByidcount(courseId);
			result.put("flag", true);
			result.put("courseCount", count);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			result.put("flag", false);
			result.put("massge", "查询异常");
			return result;
		}
		
	}
	
	/**
	 * @描述:根据id删除课件信息
	 * @方法名: deleteCoursewareInfoByid
	 * @param courseId
	 * @return
	 * @返回类型 Map<String,Object>
	 * @创建人 张兴成
	 * @创建时间 2018年4月27日下午2:46:26
	 * @修改人 张兴成
	 * @修改时间 2018年4月27日下午2:46:26
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/deleteCoursewareInfoByid/{courseId}")
	@ResponseBody
	public Map<String,Object> deleteCoursewareInfoByid(@PathVariable(value="courseId")int courseId){
		
		Map<String,Object> result=new HashMap<>();
		try {
			resourcesService.deleteCoursewareInfoByid(courseId);
			result.put("flag", true);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			result.put("flag", false);
			result.put("massge", "查询异常");
			return result;
		}
		
	}
	
	

	/**
	 * @ 
	 * @描述:查询资料信息分页
	 * @方法名: getdataPage
	 * @return
	 * @返回类型 Map<String,Object>
	 * @创建人 张兴成
	 * @创建时间 2018年5月30日上午11:09:59
	 * @修改人 张兴成
	 * @修改时间 2018年5月30日上午11:09:59
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/listDataPage")
	@ResponseBody
	public PagePojo  listDataPage(@Param(value="strname") String strname,@RequestParam(value="pageNo",defaultValue="0")Integer pageNo,@RequestParam(value="pageSize",defaultValue="10")Integer pageSize) {

		return resourcesService.listDataPage(strname,pageNo,pageSize);

	}


	/**
	 * @描述:修改资料权限
	 * @方法名: updateLearningData
	 * @return
	 * @返回类型 Map<String,Object>
	 * @创建人 张兴成
	 * @创建时间 2018年5月30日下午3:08:54
	 * @修改人 张兴成
	 * @修改时间 2018年5月30日下午3:08:54
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/updateLearningData")
	@ResponseBody
	public Map<String,Object> updateLearningData(@RequestParam(value="id")int id,@RequestParam(value="uplodaPermissions")int uplodaPermissions,@RequestParam(value="collectionPermissions")int collectionPermissions){
		Map<String,Object> result=new HashMap<String, Object>();
		Map<String,Object> map=new HashMap<String, Object>();
		try {
			map.put("id", id);
			map.put("uplodaPermissions", uplodaPermissions);
			map.put("collectionPermissions", collectionPermissions);
			resourcesService.updateLearningData(map);
			result.put("flag", true);
			result.put("message", "修改成功");
		} catch (Exception e) {
			result.put("flag", false);
			result.put("message", "修改失败");
		}
		return result;
	}



	/**
	 * @描述:上传资料信息
	 * @方法名: uploadDataFile
	 * @param request
	 * @param response
	 * @return
	 * @返回类型 Map<String,Object>
	 * @创建人 张兴成
	 * @创建时间 2018年5月31日下午2:37:24
	 * @修改人 张兴成
	 * @修改时间 2018年5月31日下午2:37:24
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/uploadDataFile")
	@ResponseBody
	public Map<String,Object> uploadDataFile(HttpServletRequest request,HttpServletResponse response,@RequestParam(value="dataNameId") String dataNameId,
			@RequestParam(value="uplodaPermissions")int uplodaPermissions,@RequestParam(value="collectionPermissions")int collectionPermissions,@RequestParam(value="type")int type){

		Map<String, Object> result=new HashMap<String, Object>();
		try {
			UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
			int userID = userinfo.getUserId();
			String userName=userinfo.getUserName();

			//获取服务器中保存文件的路径
			Date date=new Date();
			//时间日期
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			//转换成字符时间
			String format = formatter.format(date);
			//得到上传文件父路径绝对地址
			//String path = request.getServletContext().getRealPath("upload\\");
			String path ="F:/TwoPersonalDisk";
			//以当前上传时间来当做文件夹放置文件
			String path2=path+"/"+userName+"/"+format+"/";
			//获取解析器  
			CommonsMultipartResolver resolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
			//判断是否是文件  
			if(resolver.isMultipart(request)){  
				//进行转换  
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)(request);
				//获取所有文件名称  
				Iterator<String> it = multiRequest.getFileNames();
				//父路径不存在则创建 
				File pathFile = new File(path2);  
				if(!pathFile.exists()){  
					pathFile.mkdirs();  
				}
				while(it.hasNext()){  
					//根据文件名称取文件  
					MultipartFile file = multiRequest.getFile(it.next());  
					String fileName = file.getOriginalFilename();
					String subStr=fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
					String newfileName=date.getTime()+subStr;
					String localPath = path2 + newfileName;  
					//创建一个新的文件对象，创建时需要一个参数，参数是文件所需要保存的位置
					File newFile = new File(localPath);  
					//上传的文件写入到指定的文件中  
					file.transferTo(new File(path2,newfileName)); 
					Map<String, Object> map=new HashMap<String, Object>();
					map.put("type", type);
					map.put("Name", dataNameId);
					map.put("URL", localPath);
					map.put("dataSize", file.getSize());
					map.put("userID", userID);
					map.put("uplodaPermissions", uplodaPermissions);
					map.put("collectionPermissions", collectionPermissions);
					map.put("Downloads", 0);
					map.put("Collects", 0);
					map.put("UploadTime",date.getTime());
					resourcesService.insertLearningData(map);
					result.put("successFlag", true);
					result.put("message", "上传成功");
				}
			}	
		} catch (Exception e) {
			result.put("successFlag", false);
			result.put("message", "上传失败");

		}
		return result;
	}


	/**
	 * @描述:下载资料文件
	 * @方法名: todaloadDatafile
	 * @param request
	 * @param response
	 * @返回类型 void
	 * @创建人 张兴成
	 * @创建时间 2018年5月31日下午6:08:04
	 * @修改人 张兴成
	 * @修改时间 2018年5月31日下午6:08:04
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/todaloadDatafile/{id}")
	public void  todaloadDatafile(@PathVariable(value="id")int id,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> map;
		try {
			map = resourcesService.getLearningDataByid(id);
			String  datapath = (String)map.get("URL");
			File file=new File(datapath);
			String filename = file.getName();
			System.out.println(file.exists());
			// 读到流中
			InputStream inStream=new FileInputStream(file);
			// 清空response
			response.reset();
			// 设置输出的格式
			response.setContentType("application/force-download");// 设置强制下载不打开
			response.addHeader("Content-Disposition",
					"attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
			response.addHeader("Content-Length",""+ file.length());//显示文件大小
			// 循环取出流中的数据
			byte[] b = new byte[1024];//缓冲区的大小
			int len;
			OutputStream out=response.getOutputStream();
			while ((len = inStream.read(b)) !=-1){
				out.write(b, 0, len);
			}
			out.flush();
			inStream.close();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}



	/**
	 * @描述:删除资料信息跟文件
	 * @方法名: deletedataInfo
	 * @return
	 * @返回类型 Map<String,Object>
	 * @创建人 张兴成
	 * @创建时间 2018年6月1日下午2:18:29
	 * @修改人 张兴成
	 * @修改时间 2018年6月1日下午2:18:29
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/deletedataInfo/{id}")
	@ResponseBody
	public Map<String,Object> deletedataInfo(@PathVariable(value="id") int id){
		Map<String,Object> result=new HashMap<String,Object>();

		Map<String, Object> map;
		try {
			map = resourcesService.getLearningDataByid(id);

			String  datapath = (String)map.get("URL");
			File file=new File(datapath);

			if(file.delete()){
				resourcesService.deletedataInfo(id);
				result.put("flag", true);
				result.put("massge", "文件删除成功");
			}else{
				result.put("flag", 1);
				result.put("massge", "文件删除失败");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;

	}

	


	/**
	 * @描述:获取当前用户的资料信息
	 * @方法名: getMydataPage
	 * @param strname
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @
	 * @返回类型 Map<String,Object>
	 * @创建人 张兴成
	 * @创建时间 2018年6月5日上午10:29:24
	 * @修改人 张兴成
	 * @修改时间 2018年6月5日上午10:29:24
	 * @修改备注
	 * @since
	 * @throws
	 */
	@RequestMapping("/listMydataPage")
	@ResponseBody
	public PagePojo  listMydataPage(HttpServletRequest request,@Param(value="strname") String strname,
			@RequestParam(value="pageNo",defaultValue="0")Integer pageNo,@RequestParam(value="pageSize",defaultValue="10")Integer pageSize) {


		UserInfo userinfo=(UserInfo) request.getSession().getAttribute("userInfo");
		int userID = userinfo.getUserId();
		Map<String, Object> map=new HashMap<>();
		map.put("userID", userID);
		map.put("strname", strname);

		return  resourcesService.listMydataPage(map,pageNo,pageSize);

	}

	

}
