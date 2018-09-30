package com.cdxt.xtel.web.sys;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.enums.StoreUploadFilePathEnum;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.utils.PropertiesConfig;

/**
 * @ClassName: SystemController.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月18日
 */
@Controller
public class CommonController {

	private static final Logger logger = Logger.getLogger(CommonController.class);
	/**
	 * WebUploader
	 * 文件上传处理/删除处理
	 */
	@RequestMapping("/filedeal")
	@ResponseBody
	public ResJson filedeal(HttpServletRequest request, HttpServletResponse response) {
		ResJson res=new ResJson();
		String msg="啥都没干-没传参数吧！";
		String upFlag=request.getParameter("isup");
		String delFlag=request.getParameter("isdel");
		//String ctxPath = request.getSession().getServletContext().getRealPath("");
		String ctxPath=PropertiesConfig.getConfigByName("uploadpath");//demo中设置为D://upFiles,实际项目应因事制宜
		logger.debug("----ctxPath-----"+ctxPath);
		try {
			//如果是上传操作
			if("1".equals(upFlag)){
				String fileName = null;
				String bizType=request.getParameter("bizType");//上传业务名称
				logger.debug("---bizType----"+bizType);
				String bizPath=StoreUploadFilePathEnum.getPath(bizType);//根据业务名称判断上传路径
				String nowday=new SimpleDateFormat("yyyyMMdd").format(new Date());
				logger.debug("---nowday----"+nowday);
				File file = new File(ctxPath+File.separator+bizPath+File.separator+nowday);
				if (!file.exists()) {
					file.mkdirs();// 创建文件根目录
				}
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
				Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
				for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
					MultipartFile mf = entity.getValue();// 获取上传文件对象
					String orgName = mf.getOriginalFilename();// 获取文件名
					fileName = orgName.substring(0,orgName.lastIndexOf("."))+"_"+System.currentTimeMillis()+orgName.substring(orgName.indexOf("."));

					String savePath = file.getPath() + File.separator + fileName;
					File savefile = new File(savePath);
					FileCopyUtils.copy(mf.getBytes(), savefile);
					msg="上传成功";
					res.setMessage(msg);	
					String photo_url=PropertiesConfig.getConfigByName("photo_url");//demo中设置为D://upFiles,实际项目应因事制宜
					String dbpath=photo_url+File.separator+bizPath+File.separator+nowday+File.separator+fileName;
					logger.debug("---dbpath----"+dbpath);
					res.setData(dbpath);

					//1、将文件路径赋值给obj,前台可获取之,随表单提交,然后数据库中存储该路径
					//2、demo这里用的是AjaxJson对象,开发者可自定义返回对象,但是用t标签的时候路径属性名需为  obj或 filePath 或自己在标签内指定若在标签内指定则action返回路径的名称应保持一致
					//如果是删除操作
				}
			}else if("1".equals(delFlag)){
				String path=request.getParameter("path");
				String delpath=ctxPath+File.separator+path;
				File fileDelete = new File(delpath);
				if (!fileDelete.exists() || !fileDelete.isFile()) {
					msg="警告: " + delpath + "不存在!";
					logger.info(msg);
					res.setCode(SysConstants.STRING_ZERO);
				}else{
					if(fileDelete.delete()){
						msg="--------成功删除文件---------"+delpath;
						logger.info(msg);
					}else{
						res.setCode(SysConstants.STRING_ZERO);
						msg="没删除成功--jdk的问题还是你文件的问题请重新试试";
						logger.info(msg);
					}
				}
			}else{
				msg="没有传参指定上传还是删除操作！";
				res.setCode(SysConstants.STRING_ZERO);
			}
		} catch (IOException e) {
			res.setCode(SysConstants.STRING_ZERO);
			logger.info(e.getMessage());
		}catch (Exception b) {
			res.setCode(SysConstants.STRING_ZERO);
			logger.info(b.getMessage());
			b.printStackTrace();
		}
		logger.debug("-----systemController/filedeal.do------------"+msg);
		res.setMessage(msg);
		res.setCode(SysConstants.STRING_ONE);
		return res;
	}
}
