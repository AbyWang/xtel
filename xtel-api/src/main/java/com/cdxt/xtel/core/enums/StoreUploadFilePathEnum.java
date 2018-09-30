package com.cdxt.xtel.core.enums;

import java.io.File;

import org.apache.commons.lang3.StringUtils;

/**
 * 
 * 
 * @ClassName: StoreUploadFilePathEnum.java
 * @Description: 文件上传设置枚举类
 * @author wangxiaolong
 * @Copyright: Copyright (c) 2017
 * @Company:成都信通网易医疗科技发展有限公司
 * @date 2018年8月21日
 */
public enum StoreUploadFilePathEnum {
	PHOTOSUCAI("photosucai", "upload"+File.separator+"img"+File.separator+"photosucai"), 
	DEFAULT("default", "upload"+File.separator+"files");	 
	 
	private String name;
	private String path;  
    // 构造方法  
	private StoreUploadFilePathEnum(String name, String path) {  
	    this.name = name;  
	    this.path = path;  
	}  
	
	//获取路径 
    public static String getPath(String name) {
    	if(StringUtils.isNotEmpty(name)){
    		for (StoreUploadFilePathEnum storePath : StoreUploadFilePathEnum.values()) {  
                if (storePath.getName().equals(name)) {  
                    return storePath.path;  
                }  
            }  
    	}
        return DEFAULT.path;  
    }

    
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	} 
    
    
}
