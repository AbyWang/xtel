package com.cdxt.xtel.server.mapper.sys;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface SystemDao {



	List<Map<String, Object>>   listSystemVersion(@Param("id")String id);

	int updateStatus(@Param("id")Integer id,@Param("status")Integer status);


	
}
