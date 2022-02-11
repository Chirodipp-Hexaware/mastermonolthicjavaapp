package com.hex.amaze.application.petstore.view.shopping;

import com.hex.amaze.application.petstore.model.*;
import com.hex.amaze.application.petstore.service.CatalogService;
import com.hex.amaze.application.petstore.service.PurchaseOrderService;
import com.hex.amaze.application.petstore.util.Loggable;
import com.hex.amaze.application.petstore.view.AbstractBean;
import com.hex.amaze.application.petstore.view.CatchException;
import com.hex.amaze.application.petstore.view.LoggedIn;

import javax.enterprise.context.Conversation;
import javax.enterprise.context.ConversationScoped;
import javax.enterprise.inject.Instance;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Antonio Goncalves
 *         http://www.antoniogoncalves.org
 *         --
 */

@Named
@ConversationScoped
@Loggable
@CatchException
public class ShoppingCartBean extends AbstractBean implements Serializable {

    // ======================================
    // =             Attributes             =
    // ======================================

    @Inject
    @LoggedIn
    private Instance<Customer> loggedInCustomer;
    @Inject
    private CatalogService catalogBean;
    @Inject
    private PurchaseOrderService orderBean;
    @Inject
    private Conversation conversation;

    private List<ShoppingCartItem> cartItems;
    private CreditCard creditCard = new CreditCard();
    private PurchaseOrder order;

    // ======================================
    // =              Public Methods        =
    // ======================================

    public String addItemToCart() {
        Item item = catalogBean.findItem(getParamId("itemId"));

        // Start conversation
        if (conversation.isTransient()) {
            cartItems = new ArrayList<>();
            conversation.begin();
        }

        boolean itemFound = false;
        for (ShoppingCartItem cartItem : cartItems) {
            // If item already exists in the shopping cart we just change the quantity
            if (cartItem.getItem().equals(item)) {
                cartItem.setQuantity(cartItem.getQuantity() + 1);
                itemFound = true;
            }
        }
        if (!itemFound)
            // Otherwise it's added to the shopping cart
            cartItems.add(new ShoppingCartItem(item, 1));

        return "showcart.faces";
    }

    public String removeItemFromCart() {
        Item item = catalogBean.findItem(getParamId("itemId"));

        for (ShoppingCartItem cartItem : cartItems) {
            if (cartItem.getItem().equals(item)) {
                cartItems.remove(cartItem);
                return null;
            }
        }

        return null;
    }

    public String updateQuantity() {
        return null;
    }

    public String checkout() {
        return "confirmorder.faces";
    }

    public String confirmOrder() {
        order = orderBean.createOrder(getCustomer(), creditCard, getCartItems());
        cartItems.clear();

        // Stop conversation
        if (!conversation.isTransient()) {
            conversation.end();
        }

        return "orderconfirmed.faces";
    }

    public List<ShoppingCartItem> getCartItems() {
        return cartItems;
    }

    public boolean shoppingCartIsEmpty() {
        return getCartItems() == null || getCartItems().size() == 0;
    }


    public Float getTotal() {

        if (cartItems == null || cartItems.isEmpty())
            return 0f;

        Float total = 0f;

        // Sum up the quantities
        for (ShoppingCartItem cartItem : cartItems) {
            total += (cartItem.getSubTotal());
        }
        return total;
    }

    // ======================================
    // =         Getters & setters          =
    // ======================================

    public Customer getCustomer() {
        return loggedInCustomer.get();
    }


    public CreditCard getCreditCard() {
        return creditCard;
    }

    public void setCreditCard(CreditCard creditCard) {
        this.creditCard = creditCard;
    }

    public PurchaseOrder getOrder() {
        return order;
    }

    public void setOrder(PurchaseOrder order) {
        this.order = order;
    }

    public Conversation getConversation() {
        return conversation;
    }

    public CreditCardType[] getCreditCardTypes() {
        return CreditCardType.values();
    }
}