/*
 * Created on 16.11.2004
 */
package com.hex.amaze.application.petstore.session.ejb;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.RemoveException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import com.hex.amaze.application.petstore.entity.interfaces.BookLocal;
import com.hex.amaze.application.petstore.entity.interfaces.BookLocalHome;
import com.hex.amaze.application.petstore.entity.interfaces.BookValue;
import com.hex.amaze.application.petstore.entity.interfaces.UserLocal;
import com.hex.amaze.application.petstore.entity.interfaces.UserLocalHome;
import com.hex.amaze.application.petstore.view.BookView;

/**
 * @author laliluna.de
 * 
 * @ejb.bean name i= "BookSession"
 *           type = "Stateless"
 *           display-name = "BookSession"
 *           description = "BookSession EJB"
 *           view-type = "remote"
 *           jndi-name = "ejb/BookSessionHome"
 */
public class BookSession implements SessionBean {
	
	
	/**
	 * This method return all books as a collection
	 * 
	 * Diese Methode liest alle B�cher aus und gibt
	 * diese als Collection zur�ck
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public BookView[] getAllBooks() throws EJBException {
		try {
			InitialContext context = new InitialContext();
			
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			BookLocalHome bookLocalHome = (BookLocalHome)context.lookup(BookLocalHome.JNDI_NAME);

			//get all books with the local home interface
			//bestimme alle B�cher mit dem Local Home Interface
			Collection collection = bookLocalHome.findAll();
			
			//define an ArrayList
			//definieren einer ArrayList
			ArrayList arrayList = new ArrayList();
			
			//loop over the collection 
			//schleife �ber die collection
			for (Iterator iter = collection.iterator(); iter.hasNext();) {
				BookLocal element = (BookLocal) iter.next();
				
				//define a new BookView object
				//definiere ein neues BookView object
				BookView bookView = new BookView();
				//set the BookValue in bookView
				//setze das BookValue in bookView
				bookView.setBookValue(element.getBookValue());
				//set the UserValue in bookView
				//setze das UserValue in bookView
				if(element.getUser() != null)
					bookView.getUserView().setUserValue(element.getUser().getUserValue());
				
				//add the bookView object to the ArrayList
				//f�ge das bookView zur ArrayList hinzu
				arrayList.add(bookView);
			}
			
			//return the array of BookView
			//gibt das Array von BookView zur�ck
			return (BookView[])arrayList.toArray(new BookView[0]);
			
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (FinderException e) {
			throw new EJBException(e.getMessage());
		}
	}
	
	/**
	 * This methode get a book by primary key
	 * 
	 * Diese Methode liest ein Buch anhand seines Prim�rschl�ssels aus.
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public BookView getBookByPrimaryKey(Integer primaryKey) throws EJBException {
		try {
			InitialContext context = new InitialContext();
			BookView bookView = new BookView();
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			BookLocalHome bookLocalHome = (BookLocalHome)context.lookup(BookLocalHome.JNDI_NAME);
			
			//search for a book with the primary key
			//suche ein Buch anhand des Prim�rschl�ssels
			BookLocal bookLocal = bookLocalHome.findByPrimaryKey(primaryKey);
			
			//set the BookValue object in BookView
			//setze das BookValue Objekt in BookView
			bookView.setBookValue(bookLocal.getBookValue());
			//set the UserValue in BookView
			//setze das UserValue in BookView
			if(bookLocal.getUser() != null)
				bookView.getUserView().setUserValue(bookLocal.getUser().getUserValue());
			//return the book value object
			//das Book Value Objekt zur�ckgeben
			return bookView;
			
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (FinderException e) {
			throw new EJBException(e.getMessage());
		} 
	}
	
	/**
	 * This methode return a book from a user by primary key
	 * 
	 * Diese Methode gibt ein ausgeliehenes Buch eines
	 * Benutzers zur�ck.
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public void returnBook(Integer primaryKey) throws EJBException {
		try {
			InitialContext context = new InitialContext();
			
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			BookLocalHome bookLocalHome = (BookLocalHome)context.lookup(BookLocalHome.JNDI_NAME);
			
			//find a book by primary key
			//suche das Buch anhand seines Prim�rschl�ssels
			BookLocal bookLocal = bookLocalHome.findByPrimaryKey(primaryKey);
			
			//remove the relation between the user
			//entferne die Beziehung zwischen dem Benutzer
			bookLocal.setUser(null);
			
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (FinderException e) {
			throw new EJBException(e.getMessage());
		} 
	}
	
	/**
	 * This methode borrow a book for a user
	 * 
	 * Diese Methode verleiht ein Buch an einen Benutzer
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public void borrowBook(Integer primaryKey, Integer userPrimaryKey) throws EJBException {
		try {
			InitialContext context = new InitialContext();
			
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			BookLocalHome bookLocalHome = (BookLocalHome)context.lookup(BookLocalHome.JNDI_NAME);
			UserLocalHome userLocalHome = (UserLocalHome)context.lookup(UserLocalHome.JNDI_NAME);
			
			//find the book by primary key
			//suche das Buch anhand seines Prim�rschl�ssels
			BookLocal bookLocal = bookLocalHome.findByPrimaryKey(primaryKey);
			//find the user by primary key
			//suche den Benutzer anhand seines Prim�rschl�ssels
			UserLocal userLocal = userLocalHome.findByPrimaryKey(userPrimaryKey);
			
			//set the local inferface of user to assign him to a book 
			//setze das Local Interface des Benutzers um den Benutzer dem Buch zuzuweisen
			bookLocal.setUser(userLocal);
			
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (FinderException e) {
			throw new EJBException(e.getMessage());
		} 
	}
	
	/**
	 * This method removes a book from the database
	 * 
	 * Diese Methode entfernt ein Buch aus der Datenbank
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public void removeBookByPrimaryKey(Integer primaryKey) throws EJBException {
		
		try {
			InitialContext context = new InitialContext();
			
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			BookLocalHome bookLocalHome = (BookLocalHome)context.lookup(BookLocalHome.JNDI_NAME);
			
			//find the book by primary key
			//suche das Buch anhand seines Prim�rschl�ssels
			BookLocal bookLocal = bookLocalHome.findByPrimaryKey(primaryKey);
			
			//remove the book
			//entferne das buch
			bookLocal.remove();
			
		} catch (RemoveException e) {
			throw new EJBException(e.getMessage());
		} catch (NamingException e) {
			throw new EJBException(e.getMessage());
		} catch (FinderException e) {
			throw new EJBException(e.getMessage());
		}
	}
	
	/**
	 * This method save the value object of the book
	 * 
	 * Diese Methode speichert das Value Objekt des Buches
	 * 
	 * @ejb.interface-method view-type = "both"
	 */
	public void saveBook(BookValue bookValue) throws EJBException {
		
		try {
			InitialContext context = new InitialContext();
			
			//Get the home interface with JNDI from the application server
			//Home Interface �ber JNDI beim Appliacation Server holen
			BookLocalHome bookLocalHome = (BookLocalHome)context.lookup(BookLocalHome.JNDI_NAME);
			
			//check if the book can be found for update, otherwise insert it as a new book
			//�berpr�fen ob das Buch f�r die Aktualisierung gefunden wird, ansonsten erstelle eine Neues
			BookLocal bookLocal = null;
			try {
				if(bookValue.getId()==null)bookValue.setId(new Integer(0));
				bookLocal = bookLocalHome.findByPrimaryKey(bookValue.getId());
			} catch (FinderException e1) {
				bookLocal = bookLocalHome.create();
			}
			
			//update the values of the book
			//aktualsiere die Werte des Buches
			bookLocal.setBookValue(bookValue);
			
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
