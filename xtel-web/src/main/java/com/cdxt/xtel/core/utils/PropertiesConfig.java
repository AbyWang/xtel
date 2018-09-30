package com.cdxt.xtel.core.utils;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.Set;  

public class PropertiesConfig {
	
	
	
	
	private static final ResourceBundle bundle = java.util.ResourceBundle.getBundle("sysConfig");

    /** 
     * 根据KEY，读取文件对应的值 
     * @param filePath 文件路径，即文件所在包的路径，例如：java/util/config.properties 
     * @param key 键 
     * @return key对应的值 
     */  
    public static String readData(String filePath, String key) {  
        //获取绝对路径  
        filePath = PropertiesConfig.class.getResource("/" + filePath).toString();  
        //截掉路径的”file:“前缀  
        filePath = filePath.substring(6);  
        Properties props = new Properties();  
        try {  
            InputStream in = new BufferedInputStream(new FileInputStream(filePath));  
            props.load(in);  
            in.close();  
            String value = props.getProperty(key);  
            return value;  
        } catch (Exception e) {  
            e.printStackTrace();  
            return null;  
        }  
    }  
    /** 
     * 修改或添加键值对 如果key存在，修改, 反之，添加。 
     * @param filePath 文件路径，即文件所在包的路径，例如：java/util/config.properties 
     * @param key 键 
     * @param value 键对应的值 
     */  
    public static void writeData(String filePath, String key, String value) {  
        //获取绝对路径  
        filePath = PropertiesConfig.class.getResource("/" + filePath).toString();  
        //截掉路径的”file:/“前缀  
        filePath = filePath.substring(6);  
        Properties prop = new Properties();  
        try {  
            File file = new File(filePath);  
            if (!file.exists())  
                file.createNewFile();  
            InputStream fis = new FileInputStream(file);  
            prop.load(fis);  
            //一定要在修改值之前关闭fis  
            fis.close();  
            OutputStream fos = new FileOutputStream(filePath);  
            prop.setProperty(key, value);  
            //保存，并加入注释  
            prop.store(fos, "Update '" + key + "' value");  
            fos.close();  
        } catch (IOException e) {  
            System.err.println("Visit " + filePath + " for updating " + value + " value error");  
        }  
    }  
      
    /**
     * 新增或修改资源文件的内容
     * 
     * @param resourceFile
     *          资源文件（绝对路径+文件名，不需要.properties后缀）
     * @param key 键
     * @param value 值
     */
    public static void setString(String resourceFile,Map<String,Object> map){

        Properties prop = new Properties(); 
        
        try {
            if(resourceFile.indexOf(".properties")==-1){
                resourceFile+=".properties";
            }
            FileInputStream fis = new FileInputStream(resourceFile);
            try {
                prop.load(fis);
                fis.close();
                for (String key : map.keySet()) {
                	  prop.setProperty(key, (String) map.get(key));
                	  }
                //prop.setProperty(key, value);
                FileOutputStream fos = new FileOutputStream(resourceFile);
                prop.store(fos, "Copyright Thcic");
                fos.close();
                System.out.println("修改成功");
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println("修改资源文件："+resourceFile+"异常！msg："+e.getMessage());
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.out.println("无法获得资源文件：" + resourceFile);
        }    
    }
    

	/**
	 * 获取配置文件参数
	 * 
	 * @param name
	 * @return
	 */
	public static final String getConfigByName(String name) {
		return bundle.getString(name);
	}

	/**
	 * 获取配置文件参数
	 * 
	 * @param name
	 * @return
	 */
	public static final Map<Object, Object> getConfigMap(String path) {
		ResourceBundle bundle = ResourceBundle.getBundle(path);
		Set set = bundle.keySet();
		return SetToMap(set);
	}

	
	/**
	 * SET转换MAP
	 * 
	 * @param str
	 * @return
	 */
	public static Map<Object, Object> SetToMap(Set<Object> setobj) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		for (Iterator iterator = setobj.iterator(); iterator.hasNext();) {
			Map.Entry<Object, Object> entry = (Map.Entry<Object, Object>) iterator.next();
			map.put(entry.getKey().toString(), entry.getValue() == null ? "" : entry.getValue().toString().trim());
		}
		return map;

	}

    
    public static void main(String[] args) {  
        //System.out.println(PropertiesConfig.readData("jdbc.properties", "jdbc.url"));  
   // String	 filePath = PropertiesConfig.class.getResource("/" + filePath).toString();
    	Map<String,Object>  map=new HashMap<>();
    	map.put("jdbc.username", "us246");
    	map.put("jdbc.password", "us246p");
    	
    	setString("F:/meetingSystem-01/resources/jdbc",map);

    	
    } 

}
