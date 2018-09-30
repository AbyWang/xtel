package com.cdxt.xtel.server.mapper.res;

import java.util.List;
import java.util.Map;

public interface DataDao {


	List<Map<String, Object>> getdataPage(Map<String, Object> newmap);

}
