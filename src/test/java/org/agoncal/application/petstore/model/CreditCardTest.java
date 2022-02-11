package org.agoncal.application.petstore.model;

import nl.jqno.equalsverifier.EqualsVerifier;
import nl.jqno.equalsverifier.Warning;
import org.junit.Test;

import com.hex.amaze.application.petstore.model.CreditCard;

/**
 * @author Antonio Goncalves
 */
public class CreditCardTest {

    // ======================================
    // =              Methods               =
    // ======================================

    @Test
    public void shouldCheckEqualsAndHashCode() {

        // Checks equals and hashCode is valid
        EqualsVerifier.forClass(CreditCard.class).suppress(Warning.NONFINAL_FIELDS).verify();
    }
}