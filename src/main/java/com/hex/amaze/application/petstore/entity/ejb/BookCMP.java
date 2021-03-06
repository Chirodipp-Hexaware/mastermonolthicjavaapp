/*
 * Generated by XDoclet - Do not edit!
 */
package com.hex.amaze.application.petstore.entity.ejb;

import com.hex.amaze.application.petstore.entity.interfaces.BookData;
import com.hex.amaze.application.petstore.entity.interfaces.BookValue;

/**
 * CMP layer for Book.
 * @xdoclet-generated at ${TODAY}
 * @copyright The XDoclet Team
 * @author XDoclet
 * @version ${version}
 */
public abstract class BookCMP
   extends Book
   implements javax.ejb.EntityBean
{

   public BookData getData()
   {
      BookData dataHolder = null;
      try
      {
         dataHolder = new BookData();

         dataHolder.setId( getId() );
         dataHolder.setTitle( getTitle() );
         dataHolder.setAuthor( getAuthor() );
         dataHolder.setAvailable( getAvailable() );
         dataHolder.setUserId( getUserId() );

      }
      catch (RuntimeException e)
      {
         throw new javax.ejb.EJBException(e);
      }

      return dataHolder;
   }

   public void ejbLoad() throws javax.ejb.EJBException
   {
      super.ejbLoad();
   }

   public void ejbStore() throws javax.ejb.EJBException
   {
         super.ejbStore();
   }

   public void ejbActivate() throws javax.ejb.EJBException
   {
      super.ejbActivate();
   }

   public void ejbPassivate() throws javax.ejb.EJBException
   {
      super.ejbPassivate();

      BookValue = null;
   }

   public void setEntityContext(javax.ejb.EntityContext ctx) throws javax.ejb.EJBException
   {
      super.setEntityContext(ctx);
   }

   public void unsetEntityContext() throws javax.ejb.EJBException
   {
      super.unsetEntityContext();
   }

   public void ejbRemove() throws javax.ejb.EJBException, javax.ejb.RemoveException
   {
      super.ejbRemove();

   }

 /* Value Objects BEGIN */

   private BookValue BookValue = null;

   public BookValue getBookValue()
   {
      BookValue = new BookValue();
      try
         {
            BookValue.setId( getId() );
            BookValue.setTitle( getTitle() );
            BookValue.setAuthor( getAuthor() );
            BookValue.setAvailable( getAvailable() );
            BookValue.setUserId( getUserId() );

         }
         catch (Exception e)
         {
            throw new javax.ejb.EJBException(e);
         }

	  return BookValue;
   }

   public void setBookValue( BookValue valueHolder )
   {

	  try
	  {
		 setTitle( valueHolder.getTitle() );
		 setAuthor( valueHolder.getAuthor() );
		 setAvailable( valueHolder.getAvailable() );
		 setUserId( valueHolder.getUserId() );

	  }
	  catch (Exception e)
	  {
		 throw new javax.ejb.EJBException(e);
	  }
   }

/* Value Objects END */

   public abstract java.lang.Integer getId() ;

   public abstract void setId( java.lang.Integer id ) ;

   public abstract java.lang.String getTitle() ;

   public abstract void setTitle( java.lang.String title ) ;

   public abstract java.lang.String getAuthor() ;

   public abstract void setAuthor( java.lang.String author ) ;

   public abstract java.lang.Boolean getAvailable() ;

   public abstract void setAvailable( java.lang.Boolean available ) ;

   public abstract java.lang.Integer getUserId() ;

   public abstract void setUserId( java.lang.Integer userId ) ;

}
