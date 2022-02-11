package com.hex.amaze.application.petstore.model;

import java.io.Serializable;

/**
 * A class to hold display format in case of error response
 * 
 */
public class ErrorDisplay implements Serializable {

	private static final long serialVersionUID = 4698967597298743904L;
	
	private ErrorResponse status;
	
	public ErrorDisplay(ErrorResponse status) {
		super();
		this.status = status;
	}

	public ErrorResponse getStatus() {
		return status;
	}

	public void setStatus(ErrorResponse status) {
		this.status = status;
	}
	

}
