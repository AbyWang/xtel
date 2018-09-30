package com.cdxt.xtel.core.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

public class FileUtil {
	
	
	 /** 
     * 写文件 
     *  
     * @param newStr 
     *            新内容 
     * @throws IOException 
     */  
    public static boolean writeTxtFile(String newStr,String filenameTemp) throws IOException {  
        // 先读取原有文件内容，然后进行写入操作  
        boolean flag = false;  
        String filein = newStr + "\r\n";  
        String temp = "";  
  
        FileInputStream fis = null;  
        InputStreamReader isr = null;  
        BufferedReader br = null;  
        FileOutputStream fos = null;  
        PrintWriter pw = null;  
        try {  
            // 文件路径  
            File file = new File(filenameTemp);  
            // 将文件读入输入流  
            fis = new FileInputStream(file);  
            isr = new InputStreamReader(fis);  
            br = new BufferedReader(isr);  
            StringBuffer buf = new StringBuffer();  
  
            // 保存该文件原有的内容  
            for (int j = 1; (temp = br.readLine()) != null; j++) {  
                buf = buf.append(temp);  
                // System.getProperty("line.separator")  
                // 行与行之间的分隔符 相当于“\n”  
                buf = buf.append(System.getProperty("line.separator"));  
            }  
            buf.append(filein);  
  
            fos = new FileOutputStream(file);  
            pw = new PrintWriter(fos);  
            pw.write(buf.toString().toCharArray());  
            pw.flush();  
            flag = true;  
        } catch (IOException e1) {  
            // TODO 自动生成 catch 块  
            throw e1;  
        } finally {  
            if (pw != null) {  
                pw.close();  
            }  
            if (fos != null) {  
                fos.close();  
            }  
            if (br != null) {  
                br.close();  
            }  
            if (isr != null) {  
                isr.close();  
            }  
            if (fis != null) {  
                fis.close();  
            }  
        }  
        return flag;  
    }  

  
   
/**
 * @描述:读取txt文件类容
 * @方法名: readtxt
 * @param path
 * @return
 * @返回类型 String
 * @创建人 张兴成
 * @创建时间 2018年5月29日下午5:08:26
 * @修改人 张兴成
 * @修改时间 2018年5月29日下午5:08:26
 * @修改备注
 * @since
 * @throws
 */
public static String readtxt(String path){
       String result = "";
       File file = new File(path);
       try {
           InputStreamReader reader = new InputStreamReader(new FileInputStream(file),"gbk");
           BufferedReader br = new BufferedReader(reader);
           String s = null;
           while((s=br.readLine())!=null){
               result = result  + s;
           }
       } catch (IOException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }
       /*try {
           BufferedReader br = new BufferedReader(new FileReader(new File(path)));
           String s = null;
           while((s=br.readLine())!=null){
               result = result + "\n" + s;
           }
       } catch (FileNotFoundException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       } catch (IOException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }*/
       return result;
   }
    
}
