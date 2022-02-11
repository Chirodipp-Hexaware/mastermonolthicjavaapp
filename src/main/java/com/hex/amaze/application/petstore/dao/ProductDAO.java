package com.hex.amaze.application.petstore.dao;

import com.hex.amaze.application.petstore.model.Product;
import com.ibatis.sqlmap.client.SqlMapClient;

public class ProductDAO {

	public Product addUser(Product product, SqlMapClient sqlmapClient) {
		try {
			Long id = (Long) sqlmapClient.queryForObject("product.getMaxId");
			id = id == null ? 1 : id + 1;
			product.setId(id);
			product.setDescription("");
			sqlmapClient.insert("product.addUser", product);
			product = getUserById(id, sqlmapClient);
			return product;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public Product getUserById(Long id, SqlMapClient sqlmapClient) {
		try {
			Product product = (Product) sqlmapClient.queryForObject("product.getUserById", id);
			return product;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void deleteUserById(Long id, SqlMapClient sqlmapClient) {
		try {
			sqlmapClient.delete("product.deleteUserById", id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
