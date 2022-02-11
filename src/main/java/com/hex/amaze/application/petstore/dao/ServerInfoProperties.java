package com.hex.amaze.application.petstore.dao;

import java.io.FileInputStream;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

public class ServerInfoProperties {
	private static ServerInfoProperties myinstance = new ServerInfoProperties();
	
	private String DEFAULT_FILENAME = "/repos/dbProp/kacrewdir_db.prop";
	//private String DEFAULT_FILENAME = "C:/properties/kapoints_db.prop";
	
	private ResourceBundle resource = getResourceBundle();
	//final static Logger logger = Logger.getLogger(ServerInfoProperties.class);

	public static ServerInfoProperties getInstance() {
		return myinstance;
	} // end getInstance method

	private ResourceBundle getResourceBundle() {
		try {
			FileInputStream fis = new FileInputStream(DEFAULT_FILENAME);
			PropertyResourceBundle bundle = new PropertyResourceBundle(fis);
			fis.close();
			return bundle;

		} catch (Exception e) {
		} // end try
		return null;
	} // end getResourceBundle method	

	public Map getServerInfo(){
//		 DefaultEncryptedProperties encryptUtil = new DefaultEncryptedProperties();
		 Map map = new LinkedHashMap();
		 Enumeration  keySet= resource.getKeys();
		// logger.error("Test");
		 while(keySet.hasMoreElements()){
			 String key = (String)keySet.nextElement();
		//	 logger.debug("Key: "+key);
			 try {
		//	    logger.debug("Value before decrypt: "+resource.getString(key));
//				map.put(key, encryptUtil.decrypt(resource.getString(key)));
				map.put(key, resource.getString(key));
		//		logger.debug("Value after decrypt: "+encryptUtil.getProperty(resource.getString(key)));
			} catch (Exception e) {
		//		logger.error("e: "+e);
			}
		 }
		 return map;
	}
	
	
} // end class

