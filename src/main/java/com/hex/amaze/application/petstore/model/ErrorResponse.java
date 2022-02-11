package com.hex.amaze.application.petstore.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * A class to hold error response information
 * 
 */
@XmlType
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ErrorResponse extends StatusResponse {

	private static final long serialVersionUID = 959909460930388004L;
	private static final DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss zzz");
	
	@XmlAttribute protected String errorMessage;
	private Date timestamp;
	private ArrayList<ErrorField> errors;
	

	public ErrorResponse() {
		super();
	}
	
	public ErrorResponse(Integer code, String message, Date timestamp, String errorMessage) {
		this(code, message, timestamp, errorMessage, null);
	}
	
	public ErrorResponse(Integer code, String message, Date timestamp, String errorMessage, ArrayList<ErrorField> errors) {
		super(code, message);
		this.timestamp = timestamp;
		this.errorMessage = errorMessage;
		this.errors = errors;
	}
	
	
	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getTimestamp() {
		return format.format(timestamp);
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	public ArrayList<ErrorField> getErrors() {
		return errors;
	}

	public void setErrors(ArrayList<ErrorField> errors) {
		this.errors = errors;
	}
	
}
