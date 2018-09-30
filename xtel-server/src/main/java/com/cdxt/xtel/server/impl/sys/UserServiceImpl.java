package com.cdxt.xtel.server.impl.sys;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;
import com.cdxt.xtel.api.sys.UserService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.AjaxJson;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.util.MD5;
import com.cdxt.xtel.pojo.sys.MenuFunction;
import com.cdxt.xtel.pojo.sys.UserInfo;
import com.cdxt.xtel.server.mapper.sys.UserDao;
import com.github.pagehelper.PageHelper;


@Service
@Component
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	@Resource
	HttpSession session;

	public AjaxJson checkuser(String loginName,String password)  {


		AjaxJson json=new AjaxJson();
		//通过登录名名查询manager
		UserInfo userInfo=userDao.getUserInfoByLoginName(loginName);
		//登录密码MD5加密
		String pwMd5=MD5.toMD5(password);
		if(userInfo==null || !pwMd5.equals(userInfo.getPassword())){
			json.setSuccess(false);
			json.setMsg("用户名或密码错误");
			return json;
		}
		if(userInfo.getStatus()==0){
			json.setSuccess(false);
			json.setMsg("用户已锁定,请联系管理员");
			return json;
		}
		UserInfo user=new UserInfo();
		user.setUserId(userInfo.getUserId());
		user.setLoginTime(new Date().getTime());
		//更新在线状态和登录时间
		userDao.updateUserinfo(user);


		return json;
	}


	public void insertUserInfo(Map<String, Object> map)  {


		userDao.insertUserInfo(map);
	}


	/**
	 * 
	 * @Title: getUserMenuList
	 * @Description:获取菜单
	 * @param
	 * @return
	 */
	public 	List<MenuFunction> getUserMenuList(Integer parentId){

		return userDao.getUserMenuList(parentId);
	}




	public  List<Map<String, Object>> getAllGroup(){
		return userDao.getAllGroup();
	}

	public ResJson changePwd(Integer userId, String newPwd, String oldPwd) {
		int result=0;
		result= userDao.changePwd(userId, MD5.toMD5(newPwd),MD5.toMD5(oldPwd));
		if(result==1){
			return new ResJson(SysConstants.STRING_ONE,"修改成功");
		}
		return new ResJson(SysConstants.STRING_TWO,"请输入正确的旧密码");
	}


	@Override
	public UserInfo getUserInfoByLoginName(String username) {

		return userDao.getUserInfoByLoginName(username);
	}


	@Override
	public int updateUserinfo(UserInfo user) {
		return userDao.updateUserinfo(user);
	}

	/**
	 * 
	 * @Title: getChild
	 * @author wangxiaolong
	 * @Description:递归查找子菜单
	 * @param id
	 *            当前菜单id
	 * @param menuList
	 *            要查找的列表
	 * @return
	 */
	@Override
	public Map<String, Object> getUserMenuList(int[] userTypeArray) {

		List<MenuFunction> menuList=userDao.getUserMenuList(userTypeArray);
		Map<String, Object>map=null;
		Map<String, Object>dataMap=new HashMap<String, Object>();
		List<Map<String, Object>>  userList=new ArrayList<Map<String, Object>>();
		List<Map<String, Object>>  adminList=new ArrayList<Map<String, Object>>();
		List<Map<String, Object>>  teachList=new ArrayList<Map<String, Object>>();
		//查询所有的一级菜单
		for(MenuFunction menuFunction:menuList){
			if(menuFunction.getParent()==0){
				map=new HashMap<String, Object>();
				map.put("id", menuFunction.getId());
				map.put("title", menuFunction.getPageName());
				map.put("icon", menuFunction.getIcon());
				map.put("href", menuFunction.getUrl());
				map.put("spread", false);
				if(menuFunction.getUserType()==2){
					userList.add(map);
				}else if(menuFunction.getUserType()==3){
					teachList.add(map);
				}else{
					adminList.add(map);
				}
			}
		}
		for (Map<String, Object>paramMap: userList) {
			paramMap.put("children",getChild(paramMap, menuList));
		}
		for (Map<String, Object>paramMap: adminList) {
			paramMap.put("children",getChild(paramMap, menuList));
		}
		for (Map<String, Object>paramMap: teachList) {
			paramMap.put("children",getChild(paramMap, menuList));
		}
		dataMap.put("userCenter", userList);
		dataMap.put("adminCenter", adminList);
		dataMap.put("teachCenter", teachList);
		return dataMap;
	}

	/**
	 * 
	 * @Title: getChild
	 * @author wangxiaolong
	 * @Description:递归查找子菜单
	 * @param id
	 *            当前菜单id
	 * @param menuList
	 *            要查找的列表
	 * @return
	 */
	private List<Map<String, Object>> getChild(Map<String, Object>map, List<MenuFunction> menuList) {
		Integer id=(Integer) map.get("id");
		// 子菜单
		List<Map<String, Object>> childList = new ArrayList<Map<String, Object>>();
		Map<String, Object>dataMap=null;
		for (MenuFunction menu : menuList) {
			// 遍历所有节点，将父菜单id与传过来的id比较
			if (menu.getParent()!=0) {
				if (menu.getParent().equals(id)) {
					dataMap=new HashMap<String, Object>();
					dataMap.put("id", menu.getId());
					dataMap.put("title", menu.getPageName());
					dataMap.put("icon", menu.getIcon());
					dataMap.put("href", menu.getUrl());
					dataMap.put("spread", false);
					childList.add(dataMap);
				}
			}
		}
		if (childList.size() == 0) {
			return null;
		}
		return childList;
	}


	/**
	 * 
	 * @Title: getUserWithPage
	 * @Description:
	 * @param
	 * @return
	 */
	@Override
	public 	 List<Map<String, Object>> getUserWithPage(String nameVlaue,Integer idVlaue,Integer limit,Integer pageNumber){

		//分页
		PageHelper.startPage(pageNumber, limit);
		//List<Map<String, Object>>  map=userInfoDao.getUserWithPage(nameVlaue,idVlaue);

		return userDao.getUserWithPage(nameVlaue,idVlaue);
	}

	/**
	 * 
	 * @Title: getRoleWithPage
	 * @Description:
	 * @param
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getRoleWithPage(Integer limit,Integer pageNumber)  {

		//分页
		PageHelper.startPage(pageNumber, limit);
		return  userDao.getRoleWithPage();

	}



	/**
	 * 
	 * @Title: updateUserStatus
	 * @Description:更新用户状态
	 * @param
	 * @return
	 */
	@Override
	public int updateUserStatus(String userId, String status) {
		return userDao.updateUserStatus(userId,status);
	}

	/**
	 * 获取全部群组信息
	 */
	@Override
	public List<Map<String, Object>> getGroupInfo() {

		return userDao.gerGroupInfo();
	}


	/*
	 * 添加用户
	 */
	@Override
	public ResJson addUser(UserInfo userInfo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		//普通用户
		Integer userType=2;
		if(userInfo.getUserType()!=null){
			userType=userInfo.getUserType();
		}
		//把密码进行加密处理
		paramMap.put("uName", userInfo.getUserName());
		paramMap.put("pwd",MD5.toMD5(userInfo.getPassword()) );
		paramMap.put("groupId", userInfo.getGroupId());
		paramMap.put("userType",userType);
		paramMap.put("returnValue", 1);
		userDao.addUser(paramMap);
		if((int)paramMap.get("returnValue")==0){
			return new ResJson(SysConstants.STRING_TWO,"注册失败");
		}
		return new ResJson(SysConstants.STRING_ONE,"注册成功");
	}


}
