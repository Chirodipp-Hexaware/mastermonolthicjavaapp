/*
 * Created on 16.11.2004
 */
package com.hex.amaze.application.petstore.session.ejb;

import java.util.Collection;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.RemoveException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import com.hex.amaze.application.petstore.entity.interfaces.UserLocal;
import com.hex.amaze.application.petstore.entity.interfaces.UserLocalHome;
import com.hex.amaze.application.petstore.entity.interfaces.UserValue;

/**
 * @author laliluna.de
 * 
 * @ejb.bean name = "UserSession"
 *           type = "Stateless"
 *           display-name = "UserSession"
 *           description = "UserSession EJB"
 *           view-type = "remote"
 *           jndi-name = "ejb/UserSessionHome"
 */
public class UserSession implements SessionBean {
	
	/**
	 * This method return all users as a collection
	 * 
	 * Diese Methode liest alle Benutzer aus und 
	 * gibt diese als Collection zur�ck
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public Collection getAllUsers() throws EJBException {
		try {
			InitialContext context = new InitialContext();
			
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			UserLocalHome userLocalHome = (UserLocalHome)context.lookup(UserLocalHome.JNDI_NAME);
			
			//find all users and return them as collection
			//suche alle Benutzer und gibt diese als Collection zur�ck
			return userLocalHome.findAll();
			
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (FinderException e) {
			throw new EJBException(e.getMessage());
		}
	}
	
	/**
	 * This methode get a user by primary key
	 * 
	 * Diese Methode liest einen Benutzer anhand seines Prim�rschl�ssels aus
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public UserValue getUserByPrimaryKey(Integer primaryKey) throws EJBException {
		try {
			InitialContext context = new InitialContext();
			
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			UserLocalHome userLocalHome = (UserLocalHome)context.lookup(UserLocalHome.JNDI_NAME);
			
			//find a user by primary key
			//suche ein Buch anhand seines Prim�rschl�ssels
			UserLocal userLocal = userLocalHome.findByPrimaryKey(primaryKey);
			
			//return the book value object
			//das book value Objekt zur�ckgeben
			return userLocal.getUserValue();
			
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (FinderException e) {
			throw new EJBException(e.getMessage());
		} 
	}
	
	/**
	 * This method remove a user by primary key
	 * 
	 * Diese Methode l�scht einen Benutzer
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public void removeUserByPrimaryKey(Integer primaryKey) throws EJBException {
		
		try {
			InitialContext context = new InitialContext();
			
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			UserLocalHome userLocalHome = (UserLocalHome)context.lookup(UserLocalHome.JNDI_NAME);
			
			//find the user by primary key
			//suche den Benutzer anhand seines Prim�rschl�ssels
			UserLocal userLocal = userLocalHome.findByPrimaryKey(primaryKey);
			
			//remove the user
			//l�schen des Benutzer
			userLocal.remove();
			
		} catch (RemoveException e) {
			throw new EJBException(e.getMessage());
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (FinderException e) {
			throw new EJBException(e.getMessage());
		}
	}
	
	/**
	 * This methode update or add a user.
	 * 
	 * Diese Methode aktualisiert oder legt einen neuen Benutzer an.
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public void saveUser(UserValue userValue) throws EJBException {
		try {
			InitialContext context = new InitialContext();
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			UserLocalHome userLocalHome = (UserLocalHome)context.lookup(UserLocalHome.JNDI_NAME);
			
			//check if the user can be found for update, otherwise insert it as a new user
			//�berpr�fen ob der Benutzer f�r die Aktualisierung gefunden wird, ansonsten erstelle einen Neuen
			UserLocal userLocal = null;
			try {
				if(userValue.getId()==null)userValue.setId(new Integer(0));
				userLocal = userLocalHome.findByPrimaryKey(userValue.getId());
			} catch (FinderException e1) {
				userLocal = userLocalHome.create();
			}
			
			//set the value object of the local interface
			userLocal.setUserValue(userValue);
			
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (CreateException e) {
			throw new EJBException(e.getMessage());
		}
	}
	

	/** The SessionContext */
	private SessionContext context;

	/**
	 * An <code>ejbCreate</code> method as required by the EJB specification. <br>
	 * 
	 * The container calls the instance�s <code>ejbCreate</code> method whose 
	 * signature matches the signature of the <code>create</code> method invoked 
	 * by the client. The input parameters sent from the client are passed to
	 * the <code>ejbCreate</code> method. Each session bean class must have at
	 * least one <code>ejbCreate</code> method. The number and signatures
	 * of a session bean�s <code>create</code> methods are specific to each 
	 * session bean class.
	 * 
	 * @throws CreateException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 * 
	 * @ejb.create-method
	 */
	public void ejbCreate() throws CreateException {
	}

	/**
	 * The <code>ejbActivate()</code> method as required by the EJB specification.<br>
	 *
	 * The activate method is called when the instance is activated from its 
	 * passive" state. The instance should acquire any resource that it has 
	 * released earlier in the <code>ejbPassivate()</code> method. <br>
	 * 
	 * This method is called with no transaction context. 
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void ejbActivate() throws EJBException {
	}

	/**
	 * The <code>ejbPassivate()</code> method as required by the EJB specification.<br>
	 *
	 * The activate method is called when the instance is activated from 
	 * its "passive" state. The instance should acquire any resource that 
	 * it has released earlier in the <code>ejbActivate()</code> method.  <br>
	 * 
	 * This method is called with no transaction context. 
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void ejbPassivate() throws EJBException {
	}

	/**
	 * The <code>ejbRemove()</code> method as required by the EJB specification.<br>
	 *
	 * A container invokes this method before it ends the life of the 
	 * session object. This happens as a result of a client's invoking 
	 * a remove operation, or when a container decides to terminate the 
	 * session object after a timeout.   <br>
	 * 
	 * This method is called with no transaction context. 
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void ejbRemove() throws EJBException {
	}

	/**
	 * Set the associated session context. The container calls this method 
	 * after the instance creation.  <br>
	 * 
	 * The enterprise bean instance should store the reference to the context 
	 * object in an instance variable. <br>
	 * 
	 * This method is called with no transaction context. 
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void setSessionContext(SessionContext newContext)
			throws EJBException {
		context = newContext;
	}

}
