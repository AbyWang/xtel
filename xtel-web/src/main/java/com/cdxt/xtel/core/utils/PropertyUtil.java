/**
 * 
 * @ClassName: PropertyUtil.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年6月19日
 */
package com.cdxt.xtel.core.utils;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * 
 * @ClassName: PropertyUtil.java
 * @Description: 
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年6月19日
 */
public class PropertyUtil {

	public static   Map<String,String> getPropertiesValues(String fileName)  {

		Properties properties;

		Map<String,String> propMap = new HashMap<String,String>();
		try {
			properties = PropertyUtil.getProperties(fileName);
			Enumeration<Object> enums =  properties.keys();
			while(enums.hasMoreElements()){
				String key = (String)enums.nextElement();
				String value = properties.getProperty(key);
				propMap.put(key, value);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return propMap;
	}

	public static Properties getProperties(String fileName) throws IOException {
		Map<Integer, Properties> propertiesMap = new HashMap<Integer, Properties>();
		Properties property = propertiesMap.get(fileName.hashCode());
		if(property==null){
			Properties properties = new Properties();
			properties.load(PropertyUtil.class.getClassLoader().getResourceAsStream(fileName));
			System.out.println(PropertyUtil.class.getClassLoader().getResourceAsStream(fileName));
			propertiesMap.put(fileName.hashCode(), properties);
			property = properties;
		}
		return property;
	}

	//修改方法
	public static void writeProperties(String fileName,Map<String, String>keyValueMap) throws IOException{
		String filePath = PropertyUtil.class.getClassLoader()
				.getResource(fileName).getFile();// 文件的路径
		System.out.println("propertiesPath:" + filePath);
		try{
			//加载配置文件
			Properties pro = new Properties();
			InputStream in = null;
			in = new BufferedInputStream (new FileInputStream(filePath));
			pro.load(in);
			//重新写入配置文件
			FileOutputStream file = new FileOutputStream(filePath);
			for(String key:keyValueMap.keySet()){
				pro.put(key,keyValueMap.get(key));
			}
			pro.store(file, "系统配置修改"); 
		} catch (IOException e) {
			e.printStackTrace();
		}


	}


}
