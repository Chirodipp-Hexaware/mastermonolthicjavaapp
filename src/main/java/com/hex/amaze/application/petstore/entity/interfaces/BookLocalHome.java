/*
 * Generated by XDoclet - Do not edit!
 */
package com.hex.amaze.application.petstore.entity.interfaces;

/**
 * Local home interface for Book.
 * @xdoclet-generated at ${TODAY}
 * @copyright The XDoclet Team
 * @author XDoclet
 * @version ${version}
 */
public interface BookLocalHome
   extends javax.ejb.EJBLocalHome
{
   public static final String COMP_NAME="java:comp/env/ejb/BookLocal";
   public static final String JNDI_NAME="ejb/BookLocalHome";

   public BookLocal create()
      throws javax.ejb.CreateException;

   public java.util.Collection findAll()
      throws javax.ejb.FinderException;

   public BookLocal findByPrimaryKey(java.lang.Integer pk)
      throws javax.ejb.FinderException;

}
