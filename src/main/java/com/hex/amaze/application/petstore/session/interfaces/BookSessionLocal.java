/*
 * Generated by XDoclet - Do not edit!
 */
package com.hex.amaze.application.petstore.session.interfaces;

import com.hex.amaze.application.petstore.entity.interfaces.BookValue;
import com.hex.amaze.application.petstore.view.BookView;

/**
 * Local interface for BookSession.
 * @xdoclet-generated at ${TODAY}
 * @copyright The XDoclet Team
 * @author XDoclet
 * @version ${version}
 */
public interface BookSessionLocal
   extends javax.ejb.EJBLocalObject
{
   /**
    * This method return all books as a collection Diese Methode liest alle B�cher aus und gibt diese als Collection zur�ck
    */
   public BookView[] getAllBooks(  ) throws javax.ejb.EJBException;

   /**
    * This methode get a book by primary key Diese Methode liest ein Buch anhand seines Prim�rschl�ssels aus.
    */
   public BookView getBookByPrimaryKey( java.lang.Integer primaryKey ) throws javax.ejb.EJBException;

   /**
    * This methode return a book from a user by primary key Diese Methode gibt ein ausgeliehenes Buch eines Benutzers zur�ck.
    */
   public void returnBook( java.lang.Integer primaryKey ) throws javax.ejb.EJBException;

   /**
    * This methode borrow a book for a user Diese Methode verleiht ein Buch an einen Benutzer
    */
   public void borrowBook( java.lang.Integer primaryKey,java.lang.Integer userPrimaryKey ) throws javax.ejb.EJBException;

   /**
    * This method removes a book from the database Diese Methode entfernt ein Buch aus der Datenbank
    */
   public void removeBookByPrimaryKey( java.lang.Integer primaryKey ) throws javax.ejb.EJBException;

   /**
    * This method save the value object of the book Diese Methode speichert das Value Objekt des Buches
    */
   public void saveBook( BookValue bookValue ) throws javax.ejb.EJBException;

}
