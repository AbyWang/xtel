package com.cdxt.xtel.api.res;

import java.util.List;
import java.util.Map;

public interface DataService {

	List<Map<String, Object>> getdataPage(Map<String, Object> newmap, Integer startRow, Integer pageSize);

}
