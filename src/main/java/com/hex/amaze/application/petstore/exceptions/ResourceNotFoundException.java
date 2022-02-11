package com.hex.amaze.application.petstore.exceptions;

public class ResourceNotFoundException extends RuntimeException {
	private static final long serialVersionUID = -7378974549867902182L;
	public ResourceNotFoundException( String type, long id ) {
		super( String.format("%s resource with id=%d not found", type, id) );
		/*StackTraceElement[] st = new StackTraceElement[1];
        st[0] = new StackTraceElement("Test", "throwMe", "Test.java", 28);
		setStackTrace(st);*/
		
	}	
	public ResourceNotFoundException( String type, String id ) {
		super( String.format("%s resource with id=%s not found", type, id) );
	}
	
	public ResourceNotFoundException( String type, String id , Long sso) {
		super( String.format("%s resource with id=%s and sso=%s not found", type, id , sso) );
	}
	
	public ResourceNotFoundException(String msg ) {
		super(msg);
	}
	
	public synchronized Throwable fillInStackTrace(){ 
		return this; 
	}
	
}
