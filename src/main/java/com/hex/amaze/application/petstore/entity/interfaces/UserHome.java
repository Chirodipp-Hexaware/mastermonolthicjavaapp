/*
 * Generated by XDoclet - Do not edit!
 */
package com.hex.amaze.application.petstore.entity.interfaces;

/**
 * Home interface for User.
 * @xdoclet-generated at ${TODAY}
 * @copyright The XDoclet Team
 * @author XDoclet
 * @version ${version}
 */
public interface UserHome
   extends javax.ejb.EJBHome
{
   public static final String COMP_NAME="java:comp/env/ejb/User";
   public static final String JNDI_NAME="ejb/UserHome";

   public User create()
      throws javax.ejb.CreateException,java.rmi.RemoteException;

   public java.util.Collection findAll()
      throws javax.ejb.FinderException,java.rmi.RemoteException;

   public User findByPrimaryKey(java.lang.Integer pk)
      throws javax.ejb.FinderException,java.rmi.RemoteException;

}
