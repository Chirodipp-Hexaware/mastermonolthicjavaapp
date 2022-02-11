package com.hex.amaze.application.petstore.exceptions;

public interface IFieldDetailException {

	/**
	 * Return the field name for which error has occurred
	 * @return the field name
	 */
	public abstract String getFieldName();
	
	/**
	 * Return the detail field error message
	 * @return  the error message
	 */
	public abstract String getFieldErrorMessage();
}
