package com.hex.amaze.application.petstore.exceptions;

public class AttributeFilterException extends RuntimeException {

	private static final long serialVersionUID = 2299515266859056864L;
	
	public AttributeFilterException(String message) {
		super(message);
		
	}
	
	public static RuntimeException wrap(Throwable exception) {
		  if (exception instanceof RuntimeException) {
			  RuntimeException se = (RuntimeException)exception;
		    //if (errorCode != null && errorCode != se.getErrorCode()) {
			  //if (errorCode != null) {
			  return new RuntimeException(exception.getMessage(), exception);
		    //}
		    //return se;
		  } else {
		    return new RuntimeException(exception.getMessage(), exception);
		  }
	}
	

}
