package com.cdxt.xtel.core.interceptor;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.sys.UserService;
import com.cdxt.xtel.pojo.sys.UserInfo;



/**
* @Description: (shiro验证框架登录信息和用户验证信息验证) 
 */

public class ShiroRealm extends AuthorizingRealm {
	
	@Reference
	private UserService userService;
	
	/**
	* @Description: (登录信息和用户验证信息验证)
	* @param token
	* @return
	* @throws AuthenticationException 对方法的参数进行描述
	* @throws
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username = (String) token.getPrincipal(); //得到用户名 
		UserInfo userInfo=userService.getUserInfoByLoginName(username);
		if (userInfo==null) {// 抛出 帐号找不到异常
			throw new UnknownAccountException();
		} else if(userInfo.getStatus()==0){// 判断帐号是否锁定
			throw new LockedAccountException();
		}else{
			SecurityUtils.getSubject().getSession().removeAttribute("userInfo");//清空session中的信息
			SecurityUtils.getSubject().getSession().setAttribute("userInfo",userInfo);//  把用户信息放session中
			return new SimpleAuthenticationInfo(username, userInfo.getPassword(),getName());
		}
	}

	/**
	* @Description: (授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用,负责在应用程序中决定用户的访问控制的方法)
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection pc) {
		return null;
	}

}
