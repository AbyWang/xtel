package com.cdxt.xtel.api.sys;

import java.util.List;
import java.util.Map;



public interface SystemService {

	List<Map<String, Object>> listSystemVersion(String id,Integer pageNo,Integer pageSize);


	void updateStatus(Integer id, Integer startStatus, Integer closeStatus);

}
