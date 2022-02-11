package com.hex.amaze.application.petstore.rest;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.hibernate.Query;
import org.hibernate.Session;

import com.hex.amaze.application.petstore.dao.CustomerDAO;
import com.hex.amaze.application.petstore.dao.ProductDAO;
import com.hex.amaze.application.petstore.model.Customer;
import com.hex.amaze.application.petstore.model.Person;
import com.hex.amaze.application.petstore.model.Product;
import com.hex.amaze.application.petstore.util.HibernateUtil;
import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import io.swagger.annotations.ApiOperation;

/**
 * @author Antonio Goncalves http://www.antoniogoncalves.org --
 */

@ApplicationPath("/rest")
public class RestApplication extends Application {

	ProductDAO productDao = new ProductDAO();
	CustomerDAO customerDAO = new CustomerDAO();

	@DELETE
	@Path("/product/{id}")
	@ApiOperation("Deletes a product by id")
	public Response deleteProductById(@PathParam("id") Long id) {//Create the SQLMapClient
        Reader reader;
		try {
			reader = Resources.getResourceAsReader("SqlMapConfig.xml.xml");
			SqlMapClient sqlmapClient = SqlMapClientBuilder.buildSqlMapClient (reader);
			productDao.deleteUserById(id, sqlmapClient);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return Response.noContent().build();
	}

	@DELETE
	@Path("/customer/{id}")
	@ApiOperation("Deletes a customer by id")
	public Response deleteCustomerById(@PathParam("id") Long id) {//Create the SQLMapClient
        Reader reader;
		try {
			reader = Resources.getResourceAsReader("SqlMapConfig.xml.xml");
			SqlMapClient sqlmapClient = SqlMapClientBuilder.buildSqlMapClient (reader);
			customerDAO.deleteUserById(id, sqlmapClient);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return Response.noContent().build();
	}

	@GET
	@Path("/product/{id}")
	@Produces({ "application/xml", "application/json" })
	@ApiOperation("Finds a product by id")
	public Response findProductById(@PathParam("id") Long id) {
		Reader reader;
		Product product = null;
		try {
			reader = Resources.getResourceAsReader("SqlMapConfig.xml.xml");
			SqlMapClient sqlmapClient = SqlMapClientBuilder.buildSqlMapClient (reader);
			product = productDao.getUserById(1L, sqlmapClient);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (product == null) {
			return Response.status(Status.NOT_FOUND).build();
		}
		return Response.ok(product).build();
	}

	@GET
	@Path("/customer/{id}")
	@Produces({ "application/xml", "application/json" })
	@ApiOperation("Finds a customer by id")
	public Response findCustomerById(@PathParam("id") Long id) {
		Reader reader;
		Customer customer = null;
		try {
			reader = Resources.getResourceAsReader("SqlMapConfig.xml.xml");
			SqlMapClient sqlmapClient = SqlMapClientBuilder.buildSqlMapClient (reader);
			customer = customerDAO.getUserById(1L, sqlmapClient);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (customer == null) {
			return Response.status(Status.NOT_FOUND).build();
		}
		return Response.ok(customer).build();
	}

	@GET
	@Path("/persons")
	@Produces({ "application/xml", "application/json" })
	@ApiOperation("Finds a product by id")
	public Response findAllPerson() {
		Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        
        //Add new Employee object
        Person emp = new Person();
         
        Query q = session.createQuery("FROM Person");
        List<Person> personList = q.list();
         
        session.getTransaction().commit();
        HibernateUtil.shutdown();
		return Response.ok(personList).build();
	}
}