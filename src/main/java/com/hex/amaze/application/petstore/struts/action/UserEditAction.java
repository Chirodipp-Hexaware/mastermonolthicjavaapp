//Created by MyEclipse Struts
// XSL source (default): platform:/plugin/com.genuitec.eclipse.cross.easystruts.eclipse_3.8.0/xslt/JavaClass.xsl

package com.hex.amaze.application.petstore.struts.action;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.hex.amaze.application.petstore.session.interfaces.UserSession;
import com.hex.amaze.application.petstore.session.interfaces.UserSessionHome;
import com.hex.amaze.application.petstore.struts.form.UserEditForm;

/** 
 * MyEclipse Struts
 * Creation date: 11-16-2004
 * 
 * XDoclet definition:
 * @struts:action path="/userEdit" name="userEditForm" parameter="do" scope="request" validate="true"
 * @struts:action-forward name="/userList.do" path="/userList.do" redirect="true"
 * @struts:action-forward name="/jsp/userEdit.jsp" path="/jsp/userEdit.jsp"
 * @struts:action-forward name="/jsp/userAdd.jsp" path="/jsp/userAdd.jsp"
 */
public class UserEditAction extends DispatchAction {

	// --------------------------------------------------------- Instance Variables

	// --------------------------------------------------------- Methods

	/** 
	 * Method editBook
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward editUser(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response) {
		UserEditForm userEditForm = (UserEditForm) form;
		
		/* lalinuna.de 04.11.2004
		 * get id of the book from request
		 */
		Integer id = Integer.valueOf(request.getParameter("id"));
		
		/* lalinuna.de 16.11.2004
		 * load the session facade and get the book by primary key
		 */
		try {
			InitialContext context = new InitialContext();
			//get the home interface for UserSession with JNDI from the application server
			//holen des Home Interfaces f�r UserSession mit JNDI vom Appplication Server
			UserSessionHome userSessionHome = (UserSessionHome)context.lookup(UserSessionHome.JNDI_NAME);
			UserSession userSession = userSessionHome.create();
			
			//get a user by primary key and set them in the form bean
			//bestimmen eines Benutzers anhand seines Prim�rschl�ssels und setzen im Form Bean
			userEditForm.setUserValue(userSession.getUserByPrimaryKey(id));
			
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (CreateException e) {
			e.printStackTrace();
		}
				
		return mapping.findForward("showEdit");
	}
	
	/** 
	 * Method deleteBook
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward deleteUser(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response) {
		UserEditForm userEditForm = (UserEditForm) form;
		
		/* lalinuna.de 04.11.2004
		 * get id of the book from request
		 */
		Integer id = Integer.valueOf(request.getParameter("id"));
		
		/* lalinuna.de 16.11.2004
		 * load the session facade and delete the user by primary key
		 */
		try {
			InitialContext context = new InitialContext();
			//get the home interface for UserSession with JNDI from the application server
			//holen des Home Interfaces f�r UserSession mit JNDI vom Appplication Server
			UserSessionHome userSessionHome = (UserSessionHome)context.lookup(UserSessionHome.JNDI_NAME);
			UserSession userSession = userSessionHome.create();
			
			//remove a user by primary key
			//l�schen eine Benutzer anhand seines Prim�rschl�ssels
			userSession.removeUserByPrimaryKey(id);
			
			
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (CreateException e) {
			e.printStackTrace();
		}
		
		return mapping.findForward("showUserList");
	}
	
	/** 
	 * Method addBook
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward addUser(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response) {
		UserEditForm userEditForm = (UserEditForm) form;
		
		return mapping.findForward("showAdd");
		
	}

	/** 
	 * Method saveBook
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward saveUser(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response) {
		UserEditForm userEditForm = (UserEditForm) form;
		
		/* lalinuna.de 16.11.2004
		 * load the session facade and save the book by primary key
		 */
		try {
			InitialContext context = new InitialContext();
			//get the home interface for UserSession with JNDI from the application server
			//holen des Home Interfaces f�r UserSession mit JNDI vom Appplication Server
			UserSessionHome userSessionHome = (UserSessionHome)context.lookup(UserSessionHome.JNDI_NAME);
			UserSession userSession = userSessionHome.create();
			
			//update or add a new book
			//aktualisiert oder legt eine neues Buch an
			userSession.saveUser(userEditForm.getUserValue());
			
			
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