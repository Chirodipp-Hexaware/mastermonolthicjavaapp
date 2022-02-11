package com.hex.amaze.application.petstore.dao;

import com.hex.amaze.application.petstore.model.Customer;
import com.ibatis.sqlmap.client.SqlMapClient;

public class CustomerDAO {

	public Customer addUser(Customer customer, SqlMapClient sqlmapClient) {
		try {
			Long id = (Long) sqlmapClient.queryForObject("product.getMaxId");
			id = id == null ? 1 : id + 1;
			customer.setId(id);
			customer.setFirstName("");
			sqlmapClient.insert("product.addUser", customer);
			customer = getUserById(id, sqlmapClient);
			return customer;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public Customer getUserById(Long id, SqlMapClient sqlmapClient) {
		try {
			Customer customer = (Customer) sqlmapClient.queryForObject("product.getUserById", id);
			return customer;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void deleteUserById(Long id, SqlMapClient sqlmapClient) {
		try {
			sqlmapClient.delete("customer.deleteUserById", id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
