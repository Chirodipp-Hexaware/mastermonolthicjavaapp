/*
 * Generated by XDoclet - Do not edit!
 */
package com.hex.amaze.application.petstore.session.interfaces;

/**
 * Home interface for UserSession.
 * @xdoclet-generated at ${TODAY}
 * @copyright The XDoclet Team
 * @author XDoclet
 * @version ${version}
 */
public interface UserSessionHome
   extends javax.ejb.EJBHome
{
   public static final String COMP_NAME="java:comp/env/ejb/UserSession";
   public static final String JNDI_NAME="ejb/UserSessionHome";

   public UserSession create()
      throws javax.ejb.CreateException,java.rmi.RemoteException;

}
