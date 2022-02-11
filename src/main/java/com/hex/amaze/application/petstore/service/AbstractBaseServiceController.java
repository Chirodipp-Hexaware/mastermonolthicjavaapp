package com.hex.amaze.application.petstore.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.TypeMismatchException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.hex.amaze.application.petstore.exceptions.AttributeFilterException;
import com.hex.amaze.application.petstore.exceptions.IFieldDetailException;
import com.hex.amaze.application.petstore.exceptions.ResourceNotFoundException;
import com.hex.amaze.application.petstore.exceptions.ResourceNotFoundSuccessMessageException;
import com.hex.amaze.application.petstore.model.ErrorDisplay;
import com.hex.amaze.application.petstore.model.ErrorField;
import com.hex.amaze.application.petstore.model.ErrorResponse;
import com.hex.amaze.application.petstore.model.UriConstants;

public abstract class AbstractBaseServiceController {

	private static Logger LOG = Logger.getLogger(AbstractBaseServiceController.class);

	protected static final String JSON = "application/json";
	protected static final String XML = "application/xml";
	
	//gatekeeper service hyperLink 
	public static final String GK = "GK";
	//gateway service hyperLink
	public static final String GW = "GW";
	
	
	protected Map<String,Object> createOutputMap(Object o, String fields) 
		throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		Map<String,Object> rval = new LinkedHashMap<String,Object>();
		String [] fieldArray = fields.split(",");
		for( String f : fieldArray ) {
			Object p = PropertyUtils.getProperty(o, f.trim());
			if( p != null ) {
				rval.put(f.trim(),p);
			}
		}
		return rval;
	}
	
	/**
	 * this method helps in validating the sm_user value from gatekeeper
	 * and the sso input we get from URL
	 * 
	 * @param smUser
	 * @param Sso
	 * @return
	 */
	public boolean validateSmUserData(String smUser, Long Sso) {
		if(Long.valueOf(smUser).compareTo(Sso) == 0) {
			return true;
		}
		return false;
	}
	
	@ExceptionHandler(AttributeFilterException.class)
	@ResponseStatus(value=HttpStatus.UNAUTHORIZED)
	@ResponseBody
	public ErrorDisplay handleAttributeAccessException(final Exception e) {
		
		return handleException(HttpStatus.UNAUTHORIZED.value(), HttpStatus.UNAUTHORIZED.getReasonPhrase(), null, e.getMessage());		
	}
	
	
	@ExceptionHandler(ResourceNotFoundException.class)
	@ResponseStatus(value=HttpStatus.NOT_FOUND)
	@ResponseBody
	public ErrorDisplay handleResourceNotFoundException(final Exception e) {
		
		return handleException(HttpStatus.NOT_FOUND.value(), HttpStatus.NOT_FOUND.getReasonPhrase(), e);
	}
	
	@ExceptionHandler(ResourceNotFoundSuccessMessageException.class)
	@ResponseStatus(value=HttpStatus.OK)
	@ResponseBody
	public ErrorDisplay handleResourceNotFoundSuccessMessageException(final Exception e) {
		
		return handleException(HttpStatus.OK.value(), HttpStatus.NOT_FOUND.getReasonPhrase(), e);
	}
	
	@ExceptionHandler({IllegalArgumentException.class, TypeMismatchException.class})
	@ResponseStatus(value=HttpStatus.BAD_REQUEST)
	@ResponseBody
	public ErrorDisplay handleIllegalArgumentException(final Exception e) {
		
		return handleException(HttpStatus.BAD_REQUEST.value(), HttpStatus.BAD_REQUEST.getReasonPhrase(), e);
	}
	
	@ExceptionHandler(Throwable.class)
	@ResponseStatus(value=HttpStatus.INTERNAL_SERVER_ERROR)
	@ResponseBody
	public ErrorDisplay handleException(final Throwable e) {
		
		return handleException(HttpStatus.INTERNAL_SERVER_ERROR.value(), HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase(), e);
	}
	
	/**
	 * Create ErrorDisplay object from given exception, HTTP status code and status message. 
	 * 
	 * @param code  the HTTP status code
	 * @param message  the HTTP status message
	 * @param e  the Exception object
	 * @return  the created ErrorDisplay object
	 */
	protected ErrorDisplay handleException(Integer code, String message, Throwable e) {
		
		return handleException(code, message, e, null);
	}

	/**
	 * Overloaded method to create ErrorDisplay object with error message
	 * 
	 * @param code  the HTTP status code
	 * @param message  the HTTP status message
	 * @param e  the Exception object
	 * @param errorMsg  the error message
	 * @return  the created ErrorDisplay object
	 */
	protected ErrorDisplay handleException(Integer code, String message, Throwable e, String errorMsg) {
		
		String strErrorMsg = errorMsg;
		ArrayList<ErrorField> fieldList = null;
		
		//if given exception is not null
		if(e != null) {
			
			if(strErrorMsg == null) {
				if(code != 500)
					strErrorMsg = e.getMessage();
				else
					strErrorMsg = UriConstants.INTERNAL_ERROR_MESSAGE;
			}
			
			//check if exception has error field details
			if(e instanceof IFieldDetailException) {
				IFieldDetailException feEx = (IFieldDetailException)e;
				ErrorField ef = new ErrorField(feEx.getFieldName(), feEx.getFieldErrorMessage());
				fieldList = new ArrayList<ErrorField>();
				fieldList.add(ef);
			}
			
			LOG.error(strErrorMsg, e);
		}
		
		//if given human readable message is null, then initialize with HTTP message
		if (strErrorMsg == null) {
			strErrorMsg = message;
		}
		
		return new ErrorDisplay(new ErrorResponse(code, message, new Date(), strErrorMsg, fieldList));
	}
}
