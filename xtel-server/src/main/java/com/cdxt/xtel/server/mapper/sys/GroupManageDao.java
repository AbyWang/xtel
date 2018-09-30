package com.cdxt.xtel.server.mapper.sys;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cdxt.xtel.pojo.sys.GroupInfo;

public interface GroupManageDao {


	List<GroupInfo> getGroupTree(@Param("parentId")Integer parentId);


	List<Map<String, Object>> getGroupRoomMemberWithPage(@Param("roomId")Integer roomId);


	List<GroupInfo>  listGroup();

	List<GroupInfo> listGroupTree(Integer groupId);

	/**
	 * 
	 * @Title: addGroup
	 * @author wangxiaolong
	 * @Description:新增群组
	 * @param
	 * @return
	 */
	int addGroup(Map<String,Object>map);
	
	/**
	 * 
	 * @Title: updateLeafById
	 * @author wangxiaolong
	 * @Description:更新叶子节点
	 * @param
	 * @return
	 */
	int updateLeafById(@Param("isLeaf")Integer isLeaf,@Param("parentId")Integer parentId);
	
	/**
	 * 
	 * @Title: deleteGroupById
	 * @author wangxiaolong
	 * @Description:根据id删除群组
	 * @param
	 * @return
	 */
	int deleteGroupById(Integer id);
	
	
	int updateGroupById(@Param("id")Integer id,@Param("groupName")String groupName);
}
