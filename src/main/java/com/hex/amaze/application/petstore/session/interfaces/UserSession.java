/*
 * Generated by XDoclet - Do not edit!
 */
package com.hex.amaze.application.petstore.session.interfaces;

import com.hex.amaze.application.petstore.entity.interfaces.UserValue;

/**
 * Remote interface for UserSession.
 * @xdoclet-generated at ${TODAY}
 * @copyright The XDoclet Team
 * @author XDoclet
 * @version ${version}
 */
public interface UserSession
   extends javax.ejb.EJBObject
{
   /**
    * This method return all users as a collection Diese Methode liest alle Benutzer aus und gibt diese als Collection zur�ck
    */
   public java.util.Collection getAllUsers(  )
      throws java.rmi.RemoteException;

   /**
    * This methode get a user by primary key Diese Methode liest einen Benutzer anhand seines Prim�rschl�ssels aus
    */
   public UserValue getUserByPrimaryKey( java.lang.Integer primaryKey )
      throws java.rmi.RemoteException;

   /**
    * This method remove a user by primary key Diese Methode l�scht einen Benutzer
    */
   public void removeUserByPrimaryKey( java.lang.Integer primaryKey )
      throws java.rmi.RemoteException;

   /**
    * This methode update or add a user. Diese Methode aktualisiert oder legt einen neuen Benutzer an.
    */
   public void saveUser( UserValue userValue )
      throws java.rmi.RemoteException;

}
