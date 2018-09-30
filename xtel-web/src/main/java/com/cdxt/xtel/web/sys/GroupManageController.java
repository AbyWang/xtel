package com.cdxt.xtel.web.sys;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.cdxt.xtel.api.sys.GroupManageService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.utils.PageUtil;
import com.cdxt.xtel.pojo.sys.UserInfo;


@Controller
@RequestMapping("/group")
public class GroupManageController {

	@Reference
	private GroupManageService groupManageService;

	
	/**
	 * 
	 * @Title: getgroupManagePage
	 * @author wangxiaolong
	 * @Description:查询群组分页信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getGroupTree")
	@ResponseBody
	public ResJson getGroupTree(HttpSession session,@Param("parentId")Integer parentId){
		if(parentId==null){
			UserInfo user=(UserInfo)session.getAttribute(SysConstants.SYS_USER);
			parentId=user.getGroupId();
		}
		return groupManageService.getGroupTree(parentId);
	}

	/**
	 * 
	 * @Title: addGroup
	 * @author wangxiaolong
	 * @Description:新增群组
	 * @param
	 * @return
	 */
	@RequestMapping("/addGroup")
	@ResponseBody
	public ResJson addGroup(HttpSession session,@Param("parentId")Integer parentId,@Param("groupName")String groupName,
			@Param("parentLeaf")Integer parentLeaf){
		if(parentId==null){
			UserInfo user=(UserInfo)session.getAttribute(SysConstants.SYS_USER);
			parentId=user.getGroupId();
		}
		return groupManageService.addGroup(parentId,groupName,parentLeaf);
	}
	
	/**
	 * 
	 * @Title: deleteGroup
	 * @author wangxiaolong
	 * @Description:删除群组
	 * @param
	 * @return
	 */
	@RequestMapping("/deleteGroup")
	@ResponseBody
	public ResJson deleteGroup(@Param("parentId")Integer id,@Param("parentId")Integer parentId){
		
		return groupManageService.deleteGroup(id,parentId);
	}
	
	/**
	 * 
	 * @Title: updateGroup
	 * @author wangxiaolong
	 * @Description:修改群组
	 * @param
	 * @return
	 */
	@RequestMapping("/updateGroup")
	@ResponseBody
	public ResJson updateGroup(@Param("groupId")Integer groupId,@Param("groupName")String groupName){
		
		return groupManageService.updateGroup(groupId,groupName);
	}
	/**
	 * 
	 * @Title: getGroupRoomMemberWithPage
	 * @author wangxiaolong
	 * @Description:查看群组人员分页信息
	 * @param
	 * @return
	 */
	@RequestMapping("/getGroupRoomMemberWithPage")
	@ResponseBody
	public PagePojo getGroupRoomMemberWithPage(@Param(value="roomId")Integer roomId,@Param(value="pageNo")Integer pageNo,@RequestParam(value="pageSize")Integer pageSize){
		List<Map<String, Object>> list=groupManageService.getGroupRoomMemberWithPage(roomId,pageNo,pageSize);
		return PageUtil.Map2PageInfo(list);
	}




}
