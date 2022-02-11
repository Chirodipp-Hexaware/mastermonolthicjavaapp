/*
 * Created on 16.11.2004
 */
package com.hex.amaze.application.petstore.entity.ejb;


import java.util.Collection;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import javax.ejb.RemoveException;

import com.hex.amaze.application.petstore.entity.interfaces.UserValue;

/**
 * @author laliluna.de
 * 
 * @ejb.bean name = "User"
 *           type = "CMP"
 *           cmp-version = "2.x"
 *           display-name = "User"
 *           description = "User EJB"
 *           view-type = "both"
 *           jndi-name = "ejb/UserHome"
 *           local-jndi-name = "ejb/UserLocalHome"
 * 			 primkey-field = "id"
 * 
 * @ejb.util generate="physical"
 * @ejb.persistence table-name = "tusers"   
 * @ejb.value-object match = "*" name="User"
 * 
 * @ejb.finder signature = "java.util.Collection findAll()" 
 * 			   query = "select object(c) from User as c"
 * 
 * @jboss.persistence create-table = "true" 
 * 					  remove-table = "true" 
 * @jboss.entity-command name="postgresql-fetch-seq"
 */
public abstract class User implements EntityBean {
	
	// ---------------------------------------------------------------
	// Fields
	// ---------------------------------------------------------------
	/**
	 * @ejb.interface-method view-type = "both"
	 * @ejb.persistence column-name = "fid" 
	 * 					sql-type = "SERIAL" 
	 * 					jdbc-type = "INTEGER"
	 * @ejb.pk-field 
	 * 
	 * @return
	 */
	public abstract Integer getId();

	/**
	 * @ejb.interface-method view-type = "both"
	 * @param id
	 */
	public abstract void setId(Integer id);
	
	/**
	 * @ejb.interface-method view-type = "both"
	 * @ejb.persistence column-name = "fname"
	 * @return
	 */
	public abstract String getName();

	/**
	 * @ejb.interface-method view-type = "both"
	 * @param name
	 */
	public abstract void setName(String name);
	
	/**
	 * @ejb.interface-method view-type = "both"
	 * @ejb.persistence column-name = "flastname"
	 * @return
	 */
	public abstract String getLastName();

	/**
	 * @ejb.interface-method view-type = "both"
	 * @param lastname
	 */
	public abstract void setLastName(String lastname);
	
	/**
	 * @ejb.interface-method view-type = "both"
	 * @ejb.persistence column-name = "fage"
	 * @return
	 */
	public abstract Integer getAge();

	/**
	 * @ejb.interface-method view-type = "both"
	 * @param age
	 */
	public abstract void setAge(Integer age);
	
	// --------------------------------------------------------------
	// Relations
	// --------------------------------------------------------------
	/**
	 * @ejb.interface-method view-type = "local"
	 * @ejb.relation name = "user_book" 
	 * 				 role-name = "user_book" 
	 *  
	 * @return Collection
	 */
	public abstract Collection getBooks();

	/**
	 * @ejb.interface-method view-type = "local"
	 * @param books
	 */
	public abstract void setBooks(Collection books);
	
	// --------------------------------------------------------------
	// Value object
	// --------------------------------------------------------------
	/**
	 * @ejb.interface-method view-type = "both"
	 * @return
	 */
	public abstract UserValue getUserValue();

	/**
	 * @ejb.interface-method view-type = "both"
	 * @param userValue
	 */
	public abstract void setUserValue(UserValue userValue);
	

	/** The EntityContext */
	private EntityContext context;

	/**
	 * There are zero or more ejbCreate<METHOD>(...) methods, whose signatures match
	 * the signatures of the create<METHOD>(...) methods of the entity bean�s home interface.
	 * The container invokes an ejbCreate<METHOD>(...) method on an entity bean instance
	 * when a client invokes a matching create<METHOD>(...) method on the entity bean�s
	 * home interface.<br>
	 * 
	 * The entity bean provider�s responsibility is to initialize the instance in the ejbCreate<
	 * METHOD>(...) methods from the input arguments, using the get and set accessor
	 * methods, such that when the ejbCreate<METHOD>(...) method returns, the persistent
	 * representation of the instance can be created. <br>
	 * 
	 * The entity bean provider must not attempt to modify the values of cmr-fields in an ejbCreate<
	 * METHOD(...) method; this should be done in the ejbPostCreate<METHOD(...) method instead.<br>
	 * 
	 * The entity object created by the ejbCreate<METHOD> method must have a unique primary
	 * key. This means that the primary key must be different from the primary keys of all the existing
	 * entity objects within the same home. However, it is legal to reuse the primary key of a previously
	 * removed entity object. The implementation of the bean provider�s ejbCreate<
	 * METHOD>(...) methods should be coded to return a null.<br>
	 * 
	 * An ejbCreate<METHOD>(...) method executes in the transaction context determined by
	 * the transaction attribute of the matching create<METHOD>(...) method. 
	 * The database insert operations are performed by the container within the same
	 * transaction context after the Bean Provider�s ejbCreate<METHOD>(...) method completes.    
	 *
	 * @throws CreateException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 * 
	 * @ejb.create-method
	 */
	public Integer ejbCreate() throws CreateException {
		return null;
	}

	/**
	 * For each ejbCreate<METHOD>(...) method, there is a matching ejbPostCreate<
	 * METHOD>(...) method that has the same input parameters but whose return type is
	 * void. The container invokes the matching ejbPostCreate<METHOD>(...) method on
	 * an instance after it invokes the ejbCreate<METHOD>(...) method with the same arguments.
	 * The instance can discover the primary key by calling getPrimaryKey() on its
	 * entity context object. <br>
	 * 
	 * The entity object identity is available during the ejbPostCreate<METHOD>(...)
	 * method. The instance may, for example, obtain the component interface of the associated entity
	 * object and pass it to another enterprise bean as a method argument.<br>
	 * 
	 * The entity Bean Provider may use the ejbPostCreate<METHOD>(...) to set the values
	 * of cmr-fields to complete the initialization of the entity bean instance.
	 * An ejbPostCreate<METHOD>(...) method executes in the same transaction context as
	 * the previous ejbCreate<METHOD>(...) method.
	 *
	 * @throws CreateException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void ejbPostCreate() throws CreateException {
	}

	/**
	 * The container invokes this method on the instance when the container picks the instance from
	 * the pool and assigns it to a specific entity object identity. The ejbActivate() method gives
	 * the entity bean instance the chance to acquire additional resources that it needs while it is in the
	 * ready state.<br>
	 * 
	 * This method executes with an unspecified transaction context. The entity bean must not
	 * attempt to access its persistent state or relationships using the accessor methods during this
	 * method.<br>
	 * 
	 * The instance can obtain the identity of the entity object via the getPrimaryKey(), getEJBLocalObject(),
	 * or getEJBObject() method on the entity context. The instance
	 * can rely on the fact that the primary key and entity object identity will remain associated with
	 * the instance until the completion of ejbPassivate() or ejbRemove().
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void ejbActivate() throws EJBException {
	}

	/**
	 * The container invokes this method on an instance when the container decides to disassociate
	 * the instance from an entity object identity, and to put the instance back into the pool of available
	 * instances. The ejbPassivate() method gives the instance the chance to release any
	 * resources that should not be held while the instance is in the pool. (These resources typically
	 * had been allocated during the ejbActivate() method.) <br>
	 * 
	 * This method executes with an unspecified transaction context. The entity bean must not
	 * attempt to access its persistent state or relationships using the accessor methods during this
	 * method.<br>
	 * 
	 * The instance can still obtain the identity of the entity object via the getPrimaryKey(),
	 * getEJBLocalObject(), or getEJBObject() method of the EntityContext interface.
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void ejbPassivate() throws EJBException {
	}

	/**
	 * When the container needs to synchronize the state of an enterprise bean instance with the
	 * entity object�s persistent state, the container calls the ejbLoad() method.<br>
	 * 
	 * The entity Bean Provider can assume that the instance�s persistent state has been loaded just
	 * before the ejbLoad() method is invoked. It is the responsibility of the Bean Provider to use
	 * the ejbLoad() method to recompute or initialize the values of any instance variables that
	 * depend on the entity bean�s persistent state. In general, any transient state that depends on the
	 * persistent state of an entity bean should be recalculated using the ejbLoad() method. The
	 * entity bean can use the ejbLoad() method, for instance, to perform some computation on
	 * the values returned by the accessor methods (for example, uncompressing text fields).<br>
	 * 
	 * This method executes in the transaction context determined by the transaction attribute of the
	 * business method that triggered the ejbLoad method. <br>
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void ejbLoad() throws EJBException {
	}

	/**
	 * When the container needs to synchronize the state of the entity object�s persistent state with the
	 * state of the enterprise bean instance, the container first calls the ejbStore() method on the
	 * instance.<br>
	 * 
	 * The entity Bean Provider should use the ejbStore() method to update the instance using
	 * the accessor methods before its persistent state is synchronized. For example, the ejb-
	 * Store() method may perform compression of text before the text is stored in the database.
	 * The Bean Provider can assume that after the ejbStore() method returns, the persistent state
	 * of the instance is synchronized.<br>
	 * 
	 * This method executes in the same transaction context as the previous ejbLoad or ejbCreate
	 * method invoked on the instance. All business methods invoked between the previous
	 * ejbLoad or ejbCreate<METHOD> method and this ejbStore method are also invoked
	 * in the same transaction context.    
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void ejbStore() throws EJBException {
	}

	/**
	 * The container invokes the ejbRemove() method on an entity bean instance in response to a
	 * client-invoked remove operation on the entity bean�s home or component interface or as the
	 * result of a cascade-delete operation. The instance is in the ready state when ejbRemove() is
	 * invoked and it will be entered into the pool when the method completes.<br>
	 * 
	 * The entity bean provider can use the ejbRemove method to implement any actions that must
	 * be done before the entity object�s persistent representation is removed.
	 * The container synchronizes the instance�s state before it invokes the ejbRemove method.
	 * This means that the state of the instance at the beginning of the ejbRemove method is the
	 * same as it would be at the beginning of a business method.
	 * This method and the database delete operation(s) execute in the transaction context determined
	 * by the transaction attribute of the remove method that triggered the ejbRemove method.
	 * The instance can still obtain the identity of the entity object via the getPrimaryKey(),
	 * getEJBLocalObject(), or getEJBObject() method of the EntityContext interface.<br>
	 * 
	 * After the entity Bean Provider�s ejbRemove returns, and in the same transaction context, the
	 * Container removes the entity bean from all relationships in which it participates before removing
	 * the entity object�s persistent representation. <br>
	 * Since the instance will be entered into the pool, the state of the instance at the end of this
	 * method must be equivalent to the state of a passivated instance. This means that the instance
	 * must release any resource that it would normally release in the ejbPassivate() method.
	 *  
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 * 
	 * @throws RemoveException Thrown if the enterprise bean does not allow destruction of the object.
	 */
	public void ejbRemove() throws EJBException, RemoveException {
	}

	/**
	 * Set the associated entity context. The container calls this method 
	 * after the instance creation. The entity bean must not attempt to 
	 * access its persistent state and relationships using the accessor 
	 * methods during this method. <br>
	 * 
	 * The enterprise bean instance should store the reference to the context 
	 * object in an instance variable. <br>
	 * 
	 * This method is called with no transaction context. 
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void setEntityContext(EntityContext newContext) throws EJBException {
		context = newContext;
	}

	/**
	 * Unset the associated entity context. A container invokes this method 
	 * before terminating the life of the instance. The entity bean must not 
	 * attempt to access its persistent state and relationships using the 
	 * accessor methods during this method. <br>
	 * 
	 * This method is called with no transaction context. 
	 * 
	 * @throws EJBException Thrown if the instance could not perform 
	 * the function requested by the container because of an system-level error.
	 */
	public void unsetEntityContext() throws EJBException {
		context = null;
	}
}
