package com.hex.amaze.application.petstore.soap;

import org.apache.axiom.om.OMElement;

public class CountriesPortService {
	
	private CountriesService service;
	
	public OMElement getCountry(OMElement input) {
		String guid = "adjfuou12678dasdm";	//GUIDGenerator.getBase16Guid().toUpperCase();
		OMElement responseEle = service.processCountriesService(input);
		return responseEle;
	}

	public String print(Object obj) {
		System.out.println(obj.toString());
		return obj.toString();
	}
}