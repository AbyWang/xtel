package com.cdxt.xtel.api.sys;

import java.util.List;
import java.util.Map;

import com.cdxt.xtel.core.model.ResJson;

public interface GroupManageService {

	/**
	 * 
	 * @Title: getgroupManagePage
	 * @author wangxiaolong
	 * @Description:查询群组分页信息
	 * @param
	 * @return
	 */
	ResJson  getGroupTree(Integer parentId);
	
	/**
	 * 
	 * @Title: addGroup
	 * @author wangxiaolong
	 * @Description:添加群组
	 * @param
	 * @return
	 */
	ResJson addGroup(Integer parentId,String GroupName,Integer parentLeaf);

	/**
	 * 
	 * @Title: deleteGroup
	 * @author wangxiaolong
	 * @Description:删除
	 * @param
	 * @return
	 */
	ResJson deleteGroup(Integer id,Integer parentId);
	
	/**
	 * 
	 * @Title: updateGroup
	 * @author wangxiaolong
	 * @Description:修改群组
	 * @param
	 * @return
	 */
	ResJson updateGroup(Integer id,String groupName);
	
	List<Map<String, Object>>  getGroupRoomMemberWithPage(Integer roomId, Integer startRow, Integer pageSize);



}
