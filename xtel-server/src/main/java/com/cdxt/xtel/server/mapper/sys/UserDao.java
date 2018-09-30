package com.cdxt.xtel.server.mapper.sys;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cdxt.xtel.pojo.sys.MenuFunction;
import com.cdxt.xtel.pojo.sys.UserInfo;

public interface UserDao {


	/**
	 * 
	 * @Title: getuUserInfoByLoginName
	 * @author wangxiaolong
	 * @Description:通过名字查询用户
	 * @param
	 * @return
	 */
	UserInfo getUserInfoByLoginName(String loginName);

	/**
	 * 
	 * @Title: updateUserinfo
	 * @author wangxiaolong
	 * @Description:更新用户信息
	 * @param
	 * @return
	 */
	int updateUserinfo(UserInfo userInfo);

	/**
	 * 
	 * @Title: insertUserInfo
	 * @author wangxiaolong
	 * @Description:插入用户信息
	 * @param
	 * @return
	 */
	void insertUserInfo(@Param("map")Map<String, Object> map);


	/**
	 * 
	 * @Title: getUserMenuList
	 * @author wangxiaolong
	 * @Description:查询菜单
	 * @param
	 * @return
	 */
	List<MenuFunction> getUserMenuList(Integer parentId);

	/**
	 * 
	 * @Title: addUser
	 * @author wangxiaolong
	 * @Description:添加用户
	 * @param
	 * @return
	 */
	Map<String, Object> addUser(Map<String, Object> paramMap);

	/**
	 * 
	 * @Title: getAllGroup
	 * @author wangxiaolong
	 * @Description:查询所有群组
	 * @param
	 * @return
	 */
	List<Map<String, Object>>getAllGroup();

	int changePwd(@Param("userId")Integer userId,@Param("newPwd")String newPwd,@Param("oldPwd")String oldPwd);

	List<MenuFunction> getUserMenuList(int[] userTypeArray);



	/**
	 * 
	 * @Title: getSystemManagerByLoginName
	 * @author wangxiaolong
	 * @Description:通过名字查询管理员
	 * @param
	 * @return
	 */
	List<Map<String, Object>>    getUserWithPage(@Param("nameVlaue")String nameVlaue,@Param("idVlaue")Integer idVlaue);

	/**
	 * 
	 * @Title: updateSystemManager
	 * @author wangxiaolong
	 * @Description:更新在线时间
	 * @param
	 * @return
	 */
	List<Map<String, Object>> getRoleWithPage();

	/**
	 * 
	 * @Title: updateUserStatus
	 * @Description:更新用户状态
	 * @最后修改人:mabaoying
	 * @最后修改时间:2018年9月3日
	 * @return:
	 */
	int updateUserStatus(@Param("userId")String userId,@Param("status")String status);

	

	List<Map<String, Object>> gerGroupInfo();

	/**
	 * 
	 * @Title: updateOnlineByUserId
	 * @author wangxiaolong
	 * @Description:更新用户登录状态
	 * @param
	 * @return
	 */
	int updateOnlineByUserId(@Param("id")Integer id,@Param("lastLoginTime")long lastLoginTime,@Param("isOnline")Integer isOnline);

}
