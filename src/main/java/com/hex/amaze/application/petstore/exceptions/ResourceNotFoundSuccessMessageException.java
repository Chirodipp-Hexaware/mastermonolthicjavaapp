package com.hex.amaze.application.petstore.exceptions;


public class ResourceNotFoundSuccessMessageException extends RuntimeException {

	private static final long serialVersionUID = -7378974549867902182L;
	
	public ResourceNotFoundSuccessMessageException( String type, long id )  {
		super( String.format("%s resource with id=%d not found", type, id) );
	}	
	public ResourceNotFoundSuccessMessageException( String type, String id ) {
		super( String.format("%s resource with id=%s not found", type, id) );
	}
	
	public ResourceNotFoundSuccessMessageException( String type, String id , Long sso) {
		super( String.format("%s resource with id=%s and sso=%s not found", type, id , sso) );
	}
	
	public synchronized Throwable fillInStackTrace(){ 
		return this; 
	} 

}
