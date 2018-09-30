package com.cdxt.xtel.api.sys;

import java.util.List;
import java.util.Map;

import com.cdxt.xtel.core.model.AjaxJson;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.sys.UserInfo;

public interface UserService {

	AjaxJson checkuser(String loginName,String password) ;

	//void insertUserInfo(Map<String, Object> map);

	List<Map<String, Object>> getUserWithPage(String nameVlaue,Integer idVlaue,Integer limit,Integer pageNumber);

	List<Map<String, Object>> getRoleWithPage(Integer limit, Integer pageNumber);

	/**
	 * 
	 * @Title: updateUserStatus
	 * @author wangxiaolong
	 * @Description:修改密码
	 * @param
	 * @return
	 */
	int updateUserStatus(String userId, String status);


	List<Map<String, Object>> getGroupInfo();


	//ResJson  addUser(String name,String password,Integer groupId);


	ResJson addUser(UserInfo userInfo);

	/**
	 * 
	 * @Title: getAllGroup
	 * @author wangxiaolong
	 * @Description:查询所有群组
	 * @param
	 * @return
	 */
	List<Map<String, Object>> getAllGroup();

	ResJson changePwd(Integer userId, String newPwd, String oldPwd);

	UserInfo getUserInfoByLoginName(String username);

	int updateUserinfo(UserInfo user);

	Map<String, Object> getUserMenuList(int[] userTypeArray);
}
