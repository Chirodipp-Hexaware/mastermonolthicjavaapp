package com.hex.amaze.application.petstore.model;

public final class UriConstants {
	
	
	
	private UriConstants( String baseuri, String gwbaseuri ) {
		BASEURI = baseuri;
		GWBASEURI = gwbaseuri;
	}
 
	private static String BASEURI;
	private static String GWBASEURI;
	public static String getBaseUri() { return BASEURI; }
	public static String getGWBaseUri() { return GWBASEURI; }
	
	public static final String CLIENT_ID_HEADER_KEY = "X-Gatekeeper-Client-Id";
	public static final String GATEWAY_CLIENT_ID_HEADER_KEY = "X-CLIENT_ID";
	public static final String GATEWAY_SSO_HEADER_KEY = "X-SSO_ID";
	
	public static final String SM_USER_HEADER_KEY = "SM_USER";
	public static final String API_RESOURCE_CONTEXT = "api";
	public static final String PUBLIC_ORGANIZATIONS_RESOURCE_CONTEXT = "public/organizations";
	public static final String PUBLIC_PEOPLE_RESOURCE_CONTEXT = "public/people";
	public static final String ADMIN_CACHE_RESOURCE_CONTEXT = "admin/cache";
	public static final String RESOURCE_HEADER_CONTEXT = "record";
	public static final String PUBLIC_LOCATIONS_RESOURCE_CONTEXT = "public/locations";
	public static final String PUBLIC_COUNTRIES_RESOURCE_CONTEXT = "public/countries";
	public static final String LOCATIONS = "/locations"; 
	public static final String SEARCH_CONTEXT = "search";
	public static final String HF_SEARCH_CONTEXT = "hf/search";
	public static final String ADVANCED_SEARCH = "advanced-search";
	public static final String TYPEAHEAD_SEARCH_CONTEXT = "typeaheadsearch";
	public static final String SECURED_SEARCH = "secured/search";
	public static final String HF_SECURED_SEARCH = "hf/secured/search";
	public static final String QUERY_EMPLOYEE_RESOURCE_CONTEXT = "query/employee";
	public static final String ADMIN_METRICS_RESOURCE_CONTEXT = "admin/metrics";
	public static final String PRIVATE_PEOPLE_RESOURCE_CONTEXT = "private/people";
	public static final String ADMIN_FIELDS_RESOURCE_CONTEXT = "admin/fields";
	public static final String PRIVATE_HR_REPORTING_RESOURCE_CONTEXT = "private/hrreporting";
	public static final String PRIVATE_LEARNING_RESOURCE_CONTEXT = "private/learning";
	public static final String ROLES_SERVICE = "security/roles";
	public static final String ROLE_DETAILS_SERVICE = "security/roledetails";
	public static final String SECURITY_AUTH_RESOURCE_CONTEXT = "security/auth";
	public static final String PRIVATE_PEOPLE_RESOURCE_CONTEXT_EXEMP = "private/people/ex-employee";
	public static final String PUBLIC_JOBS_RESOURCE_CONTEXT = "cos/jobs";
	public static final String PRIVATE_PAYROLL_RESOURCE_CONTEXT = "private/benefits/payroll";
	public static final String PRIVATE_COMP_RESOURCE_CONTEXT = "private/benefits/compensation";
	public static final String ADMIN_LOG_RESOURCE_CONTEXT = "admin/log";
	public static final String PENDING_ADDS_PEOPLE_RESOURCE_CONTEXT = "private/pendingadds";	
	public static final String PENDING_ADDS_SEARCH_RESOURCE_CONTEXT = "pendingadds/search";
	public static final String PUBLIC_LIST_OF_VALUES = "/public/listofvalues";
	public static final String PUBLIC_GKDISABLED_TEST = "/gkdisabled/public/people";
	public static final String PENDING_ADDS_DOB_VERIFICATION_CONTEXT = "/verification/pendingadds/dateofbirth/";
	public static final String SECURITY_ACCESS = "securityaccess";
	public static final String EMPLOYEE_DOB_VERIFICATION_CONTEXT = "/verification/people/dateofbirth/";
	public static final String PUBLIC_HF_PEOPLE_RESOURCE_CONTEXT = "hf/public/people";
	public static final String INCENTIVE_SEARCH = "incentive/search";
	public static final String PRIVATE_CLIENTLIST = "private/clientlist";
	public static final String MOTG_TRAINING = "motg_training";
	public static final String APPRAISAL_SEARCH = "appraisal/search";
	public static final String PRIVATE_CW_CLIENTLIST = "private/cwclientlist";
	public static final String EMP_PROFILE_INFO="empProfileInfo";
	public static final String PRIVATE_TURBINE_RESOURCE_CONTEXT = "private/turbine";
	public static final String CASE_SEARCH_INFO = "caseinfo";
	public static final String SECURED_EDUCATIONDATA_SEARCH="secured/education";
	public static final String LPBRIDGEDATA_SEARCH="lpbridgedata/search";
	public static final String SECURED_SEARCH_CLIENTLIST = "secured/search/clientlist";
	
	public static final String GATEWAY = "gateway/";
	public static final String SMARTERER = "smarterer";

	public static final String YES_CONTEXT = "Y" ;
	public static final String NO_CONTEXT = "N" ;
	
	public static final String INTERNAL_ERROR_MESSAGE = "There was an Internal Server Error that prevented this request from completing. Please contact the Administrator.";
}
