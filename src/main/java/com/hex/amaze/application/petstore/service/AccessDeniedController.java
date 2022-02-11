package com.hex.amaze.application.petstore.service;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.hex.amaze.application.petstore.model.ErrorDisplay;

/**
 * A Controller class to handle authentication exceptions
 *
 */
@Controller
public class AccessDeniedController extends AbstractBaseServiceController {

	@RequestMapping(value = "forbidden", method=RequestMethod.GET, produces = { JSON })
	@ResponseStatus(value = HttpStatus.FORBIDDEN)
	@ResponseBody
	public ErrorDisplay forbidden() {

		return handleException(HttpStatus.FORBIDDEN.value(),
				HttpStatus.FORBIDDEN.getReasonPhrase(), null,
				"access denied");
	}
	
	
	/*  Gateway api  */ 
	@RequestMapping(value = "gateway/forbidden", method=RequestMethod.GET, produces = { JSON })
	@ResponseStatus(value = HttpStatus.FORBIDDEN)
	@ResponseBody
	
	
	public ErrorDisplay forbiddenGW() {

		return handleException(HttpStatus.FORBIDDEN.value(),
				HttpStatus.FORBIDDEN.getReasonPhrase(), null,
				"access denied");
	}

	@RequestMapping(value = "unauthorized", method=RequestMethod.GET, produces = { JSON })
	@ResponseStatus(value = HttpStatus.UNAUTHORIZED)
	@ResponseBody
	public ErrorDisplay unauthorized() {

		return handleException(
				HttpStatus.UNAUTHORIZED.value(),
				HttpStatus.UNAUTHORIZED.getReasonPhrase(), null,
				"access denied");
	}
	
	/*  Gateway api  */
	
	@RequestMapping(value = "gateway/unauthorized", method=RequestMethod.GET, produces = { JSON })
	@ResponseStatus(value = HttpStatus.UNAUTHORIZED)
	@ResponseBody
	public ErrorDisplay unauthorizedGW() {

		return handleException(
				HttpStatus.UNAUTHORIZED.value(),
				HttpStatus.UNAUTHORIZED.getReasonPhrase(), null,
				"access denied");
	}
}
