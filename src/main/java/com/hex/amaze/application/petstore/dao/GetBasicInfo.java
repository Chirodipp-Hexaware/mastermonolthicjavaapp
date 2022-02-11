package com.hex.amaze.application.petstore.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class GetBasicInfo {
	
	private Connection con=null;
	private String iern;
	private BasicInfo myInfo;
	
	public GetBasicInfo() {
		super();		
	}

	public GetBasicInfo(String ern) {
	    this.iern = ern;					
		getData();
	}

	public void getData(){
		String SQL;		
		try{	
			
			String ern = "";
			String first_name = "";
			String sur_name = "";
			String badge_name = "";
			String category = "";
			String mail_box = "";
			String email = "";
			String base_port = "";
			String crew_id = "";
			
			Dbconnect db = new Dbconnect();
			con = db.getConn();				        
			//find last status & associated info
			ResultSet rs=null;			
			Statement stmt=null;			 			 					 			 		
			SQL = "SELECT DISTINCT * FROM ISDCREW.CREW_INFO WHERE STAFFID = '" + iern + "' ";
			
			stmt = con.createStatement();		
			rs= stmt.executeQuery(SQL);		
			while(rs.next()){										
				ern = rs.getString("STAFFID");
				first_name = rs.getString("FIRST_NAME");
				sur_name = rs.getString("SUR_NAME");
				badge_name = rs.getString("BADGE_NAME");
				category = rs.getString("CATEGORY");
				mail_box = rs.getString("MAIL_BOX");
				email = rs.getString("EMAIL");
				base_port = rs.getString("BASE_PORT");
				crew_id = rs.getString("CREW_ID");

				myInfo = new BasicInfo(	iern,first_name,sur_name,badge_name,category,
										mail_box, email, base_port, crew_id);  
			}									        
			rs.close();
			stmt.close(); 
  		
		}catch (SQLException sqlex) {
			  sqlex.printStackTrace();	
			  if (con!=null) {
					try {
					   con.close();
					}catch( SQLException e){
					   e.printStackTrace();
					}		   	  
			  } //if    			
		}catch (Exception ex) {
			ex.printStackTrace();					    			
		} finally{
			if (con!=null) {
			   try {
					 con.close();
			   }catch( SQLException e){
				  e.printStackTrace();
			   }
			} //if  
		}//catch/try						

	}

	/**
	 * @return
	 */
	public BasicInfo getMyInfo() {
		return myInfo;
	}

}
