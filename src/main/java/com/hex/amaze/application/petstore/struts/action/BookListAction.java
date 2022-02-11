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

import com.hex.amaze.application.petstore.session.interfaces.BookSession;
import com.hex.amaze.application.petstore.session.interfaces.BookSessionHome;
import com.hex.amaze.application.petstore.struts.form.BookListForm;

/** 
 * MyEclipse Struts
 * Creation date: 11-03-2004
 * 
 * XDoclet definition:
 * @struts:action path="/bookList" name="bookListForm" input="/jsp/bookList.jsp" scope="request"
 * @struts:action-forward name="/jsp/bookList.jsp" path="/jsp/bookList.jsp"
 */
public class BookListAction extends Action {

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
		BookListForm bookListForm = (BookListForm) form;
		
		try {
			InitialContext context = new InitialContext();
			//get the home interface for BookSession with JNDI from the application server
			//holen des Home Interfaces f�r BookSession mit JNDI vom Appplication Server 
			BookSessionHome bookSessionHome = (BookSessionHome)context.lookup(BookSessionHome.JNDI_NAME);
			BookSession bookSession = bookSessionHome.create();
			
			//get all books and set them in the form bean
			//lies alle B�cher aus und setze diese im Form Bean
			bookListForm.setBookViews(bookSession.getAllBooks());
			
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (CreateException e) {
			e.printStackTrace();
		}

	    
	    return mapping.findForward("showList");
	}
	
}