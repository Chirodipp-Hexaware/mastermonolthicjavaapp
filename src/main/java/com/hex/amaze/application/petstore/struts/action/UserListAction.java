//Created by MyEclipse Struts
// XSL source (default): platform:/plugin/com.genuitec.eclipse.cross.easystruts.eclipse_3.8.0/xslt/JavaClass.xsl

package com.hex.amaze.application.petstore.struts.action;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hex.amaze.application.petstore.session.interfaces.UserSession;
import com.hex.amaze.application.petstore.session.interfaces.UserSessionHome;
import com.hex.amaze.application.petstore.struts.form.UserListForm;

/** 
 * MyEclipse Struts
 * Creation date: 11-16-2004
 * 
 * XDoclet definition:
 * @struts:action path="/userList" name="userListForm" scope="request" validate="true"
 * @struts:action-forward name="/jsp/userList.jsp" path="/jsp/userList.jsp"
 */
public class UserListAction extends Action {

	// --------------------------------------------------------- Instance Variables

	// --------------------------------------------------------- Methods

	/** 
	 * Method execute
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward execute(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response) {
		UserListForm userListForm = (UserListForm) form;
		
		
		/* lalinuna.de 16.11.2004
		 * load the session facade and get all users
		 */
		try {
			InitialContext context = new InitialContext();
			//get the home interface for BookSession with JNDI from the application server
			//holen des Home Interfaces f�r BookSession mit JNDI vom Appplication Server
			UserSessionHome userSessionHome = (UserSessionHome)context.lookup(UserSessionHome.JNDI_NAME);
			UserSession userSession = userSessionHome.create();
			
			//get all users and set them to the form bean
			//lies alle Benutzer aus und setze diese im form bean
			userListForm.setUsers(userSession.getAllUsers());
			
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (CreateException e) {
			e.printStackTrace();
		}

	    return mapping.findForward("showUserList");
	}

}