package com.cdxt.xtel.web.sys;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.sys.UserService;
import com.cdxt.xtel.core.model.AjaxJson;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.sys.UserInfo;
import com.github.pagehelper.PageInfo;

/**
 * 
 * 
 * @ClassName: LoginController.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年7月20日
 */
@Controller
@RequestMapping("/user")
public class UserController {


	@Reference
	private UserService userService;




	/***
	 * 
	 * @Title: checkuser
	 * @author wangxiaolong
	 * @Description:检查用户名称
	 * @param
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public AjaxJson checkuser(HttpServletRequest request,@RequestParam("loginname")String loginName,
			@RequestParam("password")String password)  {
		Subject subject=SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(loginName, password);
		AjaxJson json=new AjaxJson();
		try {
			// 登录，即身份验证
			subject.login(token);
			UserInfo userInfo=(UserInfo) subject.getSession().getAttribute("userInfo");
			UserInfo user=new UserInfo();
			user.setUserId(userInfo.getUserId());
			user.setLoginTime(new Date().getTime());
			//更新在线状态和登录时间
			userService.updateUserinfo(user);
		} catch (UnknownAccountException e) {
			json.setSuccess(false);
			json.setMsg("用户名或密码错误");
			return json;
		} catch (IncorrectCredentialsException e) {
			json.setSuccess(false);
			json.setMsg("用户名或密码错误");
			return json;
		} catch (ExcessiveAttemptsException e) {
			json.setSuccess(false);
			json.setMsg("用户已锁定,请联系管理员");
			return json;
		} catch (AuthenticationException e) {
			// 其他错误，比如锁定，如果想单独处理请单独catch处理
			json.setSuccess(false);
			json.setMsg("其他错误：" + e.getMessage());
			return json;
		}

		return json;
	}




	/**
	 * 
	 * @Title: getRootMenus
	 * @author wangxiaolong
	 * @Description:c查询所有的菜单
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/getMenus")
	@ResponseBody
	public  Map<String, Object> getRootMenus(HttpServletRequest request,HttpSession session) {
		UserInfo userInfo=(UserInfo) session.getAttribute("userInfo");
		int userType=userInfo.getUserType();
		int[] userTypeArray;

		if(userType==0){
			userTypeArray=new int[]{0,1,2,3};
		}else if(userType==1){
			userTypeArray=new int[]{1,2,3};
		}else {
			userTypeArray=new int[]{2,3};
		}
		return userService.getUserMenuList(userTypeArray);
	}


	/**
	 * 
	 * @Title: addUser
	 * @Description: 添加用户
	 * @最后修改人:mabaoying
	 * @最后修改时间:2018年9月4日
	 * @return:
	 */
	@RequestMapping(value="/addUser")
	@ResponseBody
	public ResJson addUser(UserInfo userInfo){
		ResJson json=new ResJson();
		try {
			json= userService.addUser(userInfo);
		} catch (Exception e) {
			e.printStackTrace();;
		}
		return json ;
	}


	/**
	 * 
	 * @Title: changePwd
	 * @author wangxiaolong
	 * @Description:修改密码
	 * @param
	 * @return
	 */
	@RequestMapping("/changePwd")
	@ResponseBody
	public ResJson changePwd(HttpServletRequest  request,@Param("userId")Integer userId,
			@Param("newPwd")String newPwd,@Param("oldPwd")String oldPwd){
		return userService.changePwd(userId, newPwd,oldPwd);
	}	

	/**
	 * 
	 * @Title: getUserWithPage
	 * @author wangxiaolong
	 * @Description:获取用户信息
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/getUserWithPage")
	@ResponseBody
	public PagePojo getUserWithPage(Model model,@Param(value="nameVlaue")String nameVlaue,@Param(value="idVlaue")Integer idVlaue,@Param(value="limit")Integer limit,
			@Param(value="pageNo")Integer pageNo){

		List<Map<String, Object>> userInfos=userService.getUserWithPage(nameVlaue,idVlaue,limit,pageNo);

		//将数据放入pageInfo，pageInfo会对数据进行处理，这个是封装好的类，直接调用即可
		PageInfo<Map<String, Object>> pageInfo=new PageInfo<Map<String, Object>>(userInfos);
		//封装bootstrap
		PagePojo page=new PagePojo();
		page.setPage(pageInfo.getPageNum());
		//age.getPage()(pageInfo.getPages());
		page.setTotal(pageInfo.getTotal());
		page.setRows(userInfos);
		return page;
	}

	/**
	 * 
	 * @Title: getRoleWithPage
	 * @author wangxiaolong
	 * @Description:获取角色信息
	 * @param
	 * @return
	 */
	@RequestMapping(value ="/getRoleWithPage")
	@ResponseBody
	public PagePojo getRoleWithPage(@RequestParam(value="pageNo",defaultValue="1")Integer pageNo,@RequestParam(value="limit",defaultValue="10")Integer limit){

		List<Map<String, Object>> map=userService.getRoleWithPage(limit,pageNo);
		//将数据放入pageInfo，pageInfo会对数据进行处理，这个是封装好的类，直接调用即可
		PageInfo<Map<String, Object>> pageInfo=new PageInfo<Map<String, Object>>(map);
		//封装bootstrap
		PagePojo page=new PagePojo();
		page.setPage(pageInfo.getPageNum());
		page.setTotal(pageInfo.getTotal());
		page.setRows(map);
		return page;

	}

	/**
	 * 
	 * @Title: updateUserStatus
	 * @Description:更新用户状态
	 * @最后修改人:mabaoying
	 * @最后修改时间:2018年9月3日
	 * @return:
	 */
	@RequestMapping(value="/updateUserStatus")
	@ResponseBody
	public AjaxJson updateUserStatus(@RequestParam(value="userId")String userId,@RequestParam(value="status")String status){
		AjaxJson result=new AjaxJson();
		try {
			userService.updateUserStatus(userId,status);
			result.setSuccess(true);
			result.setMsg("操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("操作失败！");
		}
		return result;
	}
	/**
	 * 
	 * @Title: toAddUserPage
	 * @Description: 跳转到新增用户页面
	 * @最后修改人:mabaoying
	 * @最后修改时间:2018年9月3日
	 * @return:
	 */
	@RequestMapping(value="/toAddUserPage")
	public ModelAndView toAddUserPage(ModelAndView mav){
		List<Map<String, Object>> groupInfoList=userService.getGroupInfo();
		mav.addObject("groupInfoList", groupInfoList);
		mav.setViewName("sys/addUser");
		return mav;
	}


}
