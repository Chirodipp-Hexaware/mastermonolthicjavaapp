package com.hex.amaze.application.petstore.service;

import javax.decorator.Decorator;
import javax.inject.Inject;

import com.hex.amaze.application.petstore.service.ComputablePurchaseOrder;

import javax.decorator.Delegate;

@Decorator
public abstract class PurchaseOrderDecorator implements ComputablePurchaseOrder
{

   @Inject
   @Delegate
   private ComputablePurchaseOrder delegate;
}