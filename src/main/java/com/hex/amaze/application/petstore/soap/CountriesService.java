package com.hex.amaze.application.petstore.soap;

import org.apache.axiom.om.OMElement;

public class CountriesService {
	
//	private CountryRepository countryRepository;
//	private CountryValidator validator;
	
	public OMElement processCountriesService(OMElement input) {
//		GetCountryRequest request = validator.parse(input);
//		ThreadLocalStorage.fetch.setTraceId(request.getTraceId());
//		GetCountryResponse response = new GetCountryResponse();
//        	response.setCountry(countryRepository.findCountry(request.getName()));
//		OMElement responseEle = validator.marshall(response);
		return input;
	}
}