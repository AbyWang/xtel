package com.cdxt.xtel.server.impl.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.dubbo.config.annotation.Service;
import com.cdxt.xtel.api.sys.GroupManageService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.util.DateUtils;
import com.cdxt.xtel.pojo.sys.GroupInfo;
import com.cdxt.xtel.pojo.sys.UserInfo;
import com.cdxt.xtel.server.mapper.sys.GroupManageDao;
import com.github.pagehelper.PageHelper;


@Service
public class GroupManageServiceImpl implements GroupManageService {


	@Resource
	HttpSession session;

	@Autowired
	private GroupManageDao groupManageDao;

	@Override
	public ResJson getGroupTree(Integer parentId){

		if(parentId==null){
			UserInfo user=(UserInfo)session.getAttribute(SysConstants.SYS_USER);
			parentId=user.getGroupId();
		}
		List<GroupInfo>list=groupManageDao.getGroupTree(parentId);
		Map<String,Object> map = null;
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();

		for(GroupInfo group:list){
			map = new HashMap<String,Object>();
			map = new HashMap<String,Object>();
			map.put("name",group.getName());
			map.put("id", group.getId());
			if (group.getIsLeaf()!=null&&group.getIsLeaf()==1) {
				map.put("type","item");
			}else {
				map.put("type","folder");
			}
			if (group.getSuperiorGroupID()!=null) {
				map.put("parentId",group.getSuperiorGroupID());
			}else {
				map.put("parentId",0);
			}
			dataList.add(map);
		}
		return new ResJson(SysConstants.STRING_ONE,"查询成功",dataList);
	}



	@Override
	public List<Map<String, Object>> getGroupRoomMemberWithPage(Integer roomId, Integer pageNo, Integer pageSize){

		PageHelper.startPage(pageNo, pageSize);
		return groupManageDao.getGroupRoomMemberWithPage(roomId);

	}



	public  ResJson addGroup(Integer parentId,String groupName,Integer parentLeaf){
		int result=0;int ups=0;
		if(parentId==null){
			UserInfo user=(UserInfo)session.getAttribute(SysConstants.SYS_USER);
			parentId=user.getGroupId();
		}
		Map<String, Object>map=new HashMap<String, Object>();
		map.put("parentId", parentId);
		map.put("groupName", groupName);
		map.put("createTime", DateUtils.getMillis());
		map.put("isLeaf", SysConstants.INTEGER_ONE);
		//新增节点
		result= groupManageDao.addGroup(map);
		if(result==0){
			return new ResJson(SysConstants.STRING_TWO,"添加失败");
		}
		if(parentLeaf==1){
			ups=groupManageDao.updateLeafById(SysConstants.INTEGER_ZERO,parentId);
			if(ups==1){
				return new ResJson(SysConstants.STRING_ONE,"添加成功");
			}
		}
		return new ResJson(SysConstants.STRING_ONE,"添加成功");
	}

	/**
	 * 
	 * @Title: deleteGroup
	 * @Description:
	 * @param
	 * @return
	 */
	public  ResJson deleteGroup(Integer id,Integer parentId){
		int result=0;

		result=groupManageDao.deleteGroupById(id);
		if(result==0){
			return new ResJson(SysConstants.STRING_TWO,"删除失败");
			
		}
		//查询该菜单下是否还有节点
		List<GroupInfo>list=groupManageDao.getGroupTree(parentId);
		if(list.size()==0){
			//没有子节点，更新leaf
			groupManageDao.updateLeafById(SysConstants.INTEGER_ONE,parentId);
		}
		return new ResJson(SysConstants.STRING_ONE,"删除成功");
	}

	/**
	 * 
	 * @Title: updateGroup
	 * @Description:
	 * @param
	 * @return
	 */
	public  ResJson updateGroup(Integer id,String groupName){
		int result=0;
		result=groupManageDao.updateGroupById(id,groupName);
		if(result==1){
			return new ResJson(SysConstants.STRING_ONE,"更新成功");
		}
		return new ResJson(SysConstants.STRING_TWO,"更新失败");
	}
}
