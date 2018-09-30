package com.cdxt.xtel.core.model;

import java.io.Serializable;

/**
 * 返回值对象
 * @author HanChengBing
 * @date 2018-03-13 17:50
 *
 */
@SuppressWarnings("javadoc")
public class ResJson implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String code;
	private String message;
	private Object data;
	
	
	public ResJson(){
		super();
	}
	
	public ResJson(String code, String message){
		super();
		this.code =code;
		this.message = message;
	}
	
	public ResJson(String code, String message, Object data){
		super();
		this.code =code;
		this.message = message;
		this.data = data;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}
