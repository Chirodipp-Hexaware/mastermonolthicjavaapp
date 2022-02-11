package com.hex.amaze.application.petstore.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.hex.amaze.application.petstore.model.HomeOwner;

public class HomeOwnerDAO {
	public void StoreHomeOwner(HomeOwner ho) throws SQLException {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;

		String SAVE = "INSERT INTO HOME_OWNER"
				+ "(EMAIL,FIRST_NAME,LAST_NAME,RETIRED,SSN,BIRTH,USER_ID)"
				+ "VALUES(?,?,?,?,?,?,?)";

		MySqlConnection mysql = new MySqlConnection();
		try {
			conn = mysql.getConnection();
			stmt = conn.prepareStatement(SAVE);
			stmt.setString(1, ho.getEmail());
			stmt.setString(2, ho.getFirst_name());
			stmt.setString(3, ho.getLast_name());
			stmt.setString(4, ho.getBirth());
			;
			stmt.setString(5, ho.getSsn());
			stmt.setString(6, ho.getRetired());
			stmt.setInt(7, HomeOwner.getU_id());

			stmt.executeUpdate();

		} catch (ClassNotFoundException | IOException | SQLException e) {
			e.printStackTrace();
		} finally {
			if (result != null) {
				result.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}

	}
	public void getHomeOwnerInfo(Integer user_id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet result = null;
		HomeOwner ho= null;
		String SAVE = "SELECT * FROM HOME_OWNER where USER_ID =?";
       MySqlConnection mysql = new MySqlConnection();
		
		try {
		conn = mysql.getConnection();
		stmt = conn.prepareStatement(SAVE);
		stmt.setInt(1, user_id);
		result = stmt.executeQuery();
		if (result.next()) {
			ho = new HomeOwner(result.getString(2), result.getString(3), result.getString(4), result.getString(5), result.getString(6),
					result.getString(7), result.getInt(1) );
		}
	}catch (ClassNotFoundException | IOException | SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	}
}
