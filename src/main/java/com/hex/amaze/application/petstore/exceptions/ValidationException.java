package com.hex.amaze.application.petstore.exceptions;

/**
 * @author Antonio Goncalves
 *         http://www.antoniogoncalves.org
 *         --
 *         Thrown when data is not valid
 */

public class ValidationException extends RuntimeException
{
   // ======================================
   // =            Constructors            =
   // ======================================

   public ValidationException()
   {
      super();
   }

   public ValidationException(String message)
   {
      super(message);
   }
}