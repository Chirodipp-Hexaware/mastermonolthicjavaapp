//Created by MyEclipse Struts
// XSL source (default): platform:/plugin/com.genuitec.eclipse.cross.easystruts.eclipse_3.8.0/xslt/JavaClass.xsl

package com.hex.amaze.application.petstore.struts.form;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/** 
 * MyEclipse Struts
 * Creation date: 11-16-2004
 * 
 * XDoclet definition:
 * @struts:form name="userListForm"
 */
public class UserListForm extends ActionForm {

	private Collection users;
	  
	/* lalinuna.de 02.11.2004
	 * get the collection books
	 */
    public Collection getUsers() {
        return users;
    }
    /* lalinuna.de 02.11.2004
	 * set the collection books
	 */
    public void setUsers(Collection users) {
        this.users = users;
    }

    /* lalinuna.de 02.11.2004
	 * reset the collection books
	 */
    public void reset(ActionMapping arg0, HttpServletRequest arg1) {
    	users = new ArrayList();
    }

}