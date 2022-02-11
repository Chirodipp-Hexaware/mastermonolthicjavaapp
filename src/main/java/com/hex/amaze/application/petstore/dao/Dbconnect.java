package com.hex.amaze.application.petstore.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class Dbconnect
{
  private InitialContext ctx;
  private Connection conn;
  private Connection cx_con;

  public Dbconnect() throws SQLException
  {
	//KA Security connect the DB begin
    System.out.println("KACCD_LOG: conn pool start");
    ServerInfoProperties iServerinfoProperties = new ServerInfoProperties();
    Map map=iServerinfoProperties.getServerInfo();
    String ServerUrl= (String) map.get("crewdir_url");            
    String UserName =   (String) map.get("crewdir_username");
    String Password = (String) map.get("crewdir_password");
    System.out.println("KACCD_LOG conn pool end");
    //KA Security connnect the DB end
    try {
//		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	conn = DriverManager.getConnection(ServerUrl, UserName,Password);
  }
  
  public Dbconnect(String cx)
  {
    try
    {
//      OracleDataSource ds = new OracleDataSource();
DataSource ds = null;
      String db_connect = new String("");

      db_connect = "jdbc:oracle:thin:@CORPDBSTG01:4600:KACCD";
      System.out.println("CCD DB Staging");

//      ds.setURL(db_connect);
      this.conn = ds.getConnection("crewdir", "crewdir");
    }
    catch (SQLException ex) {
      ex.printStackTrace();
      if (this.conn != null)
        try {
          this.conn.close();
        } catch (SQLException e) {
          e.printStackTrace();
        }
    }
  }
  
  public Connection getConn()
  {
    return this.conn;
  }

  public void setConn(Connection connection)
  {
    this.conn = connection;
  }
}