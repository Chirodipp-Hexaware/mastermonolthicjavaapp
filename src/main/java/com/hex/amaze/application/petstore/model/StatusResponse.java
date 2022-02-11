package com.hex.amaze.application.petstore.model;

import java.io.Serializable;

public class StatusResponse implements Serializable {

	private static final long serialVersionUID = 6323434565239598416L;
	
	private Integer code;
	private String message;
	
	public StatusResponse() {
		super();
	}

	public StatusResponse(Integer code, String message) {
		super();
		this.code = code;
		this.message = message;
	}
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

}
