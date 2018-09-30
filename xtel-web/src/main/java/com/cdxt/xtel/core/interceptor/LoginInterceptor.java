package com.cdxt.xtel.core.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.pojo.sys.UserInfo;
/**
 * 
 * 
 * @ClassName: LoginInterceptor.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年9月3日
 */
public class LoginInterceptor implements HandlerInterceptor {

	/** 
	 * preHandle方法是进行处理器拦截用的，顾名思义，该方法将在Controller处理之前进行调用，SpringMVC中的Interceptor拦截器是链式的，
	 * 可以同时存在多个Interceptor，然后SpringMVC会根据声明的前后顺序一个接一个的执行，而且所有的Interceptor中的preHandle方法都会在 
	 * Controller方法调用之前调用。SpringMVC的这种Interceptor链式结构也是可以进行中断的，这种中断方式是令preHandle的返 
	 * 回值为false，当preHandle的返回值为false的时候整个请求就结束了。 
	 */  
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		//获取请求的URL  
		String url = request.getRequestURI();  
		Map<String ,String[]> map=request.getParameterMap();
		//下载页面和下载文件放行
		if(url.indexOf("toDownloadPage")>=0 || url.indexOf("downloadFile")>=0){
			return true;
		}
		//URL:login.jsp是公开的;其它的URL都进行拦截控制  
		if(url.indexOf("checkuser")>=0 && !map.isEmpty()){  
			return true;  
		}
		//登录页面放行
		if(url.indexOf("toLogin")>=0){
			return true;
		}
		//获取username  
		//SystemManager systemManager = (SystemManager) request.getSession().getAttribute(SysConstants.SUPPER_ADMIN);  
		UserInfo admin = (UserInfo) request.getSession().getAttribute(SysConstants.SYS_USER);  
		if(admin!=null){  
			return true;  
		}
		//不符合条件的，跳转到登录界面  
		response.sendRedirect(request.getSession().getServletContext().getContextPath()+"/toLogin");
		return false;  
	}

	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}


	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {

	}

}
