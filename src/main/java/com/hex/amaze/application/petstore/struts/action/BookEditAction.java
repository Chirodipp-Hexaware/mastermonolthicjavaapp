//Created by MyEclipse Struts
// XSL source (default): platform:/plugin/com.genuitec.eclipse.cross.easystruts.eclipse_3.8.0/xslt/JavaClass.xsl

package com.hex.amaze.application.petstore.struts.action;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts2.ServletActionContext;

import com.hex.amaze.application.petstore.session.interfaces.BookSession;
import com.hex.amaze.application.petstore.session.interfaces.BookSessionHome;
import com.hex.amaze.application.petstore.session.interfaces.UserSession;
import com.hex.amaze.application.petstore.session.interfaces.UserSessionHome;
import com.hex.amaze.application.petstore.struts.form.BookEditForm;

/**
 * MyEclipse Struts Creation date: 11-04-2004
 * 
 * XDoclet definition:
 * 
 * @struts:action path="/bookEdit" name="bookEditForm" parameter="do"
 *                scope="request" validate="true"
 * @struts:action-forward name="/jsp/bookEdit.jsp" path="/jsp/bookEdit.jsp"
 */
public class BookEditAction extends DispatchAction {

	/**
	 * Method editBook
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward editBook(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		BookEditForm bookEditForm = (BookEditForm) form;

		/*
		 * lalinuna.de 04.11.2004 get id of the book from request
		 */
		Integer id = Integer.valueOf(request.getParameter("id"));

		/*
		 * lalinuna.de 16.11.2004 load the session facade and get the book by primary
		 * key
		 */
		try {
			HttpSession session = ServletActionContext.getRequest().getSession(false);
			if (session == null || session.getAttribute("login") == null) {
				System.out.println("login");
				session.setAttribute("validUser", false);
			} else {
				System.out.println("success");
				session.setAttribute("validUser", true);
			}
			InitialContext context = new InitialContext();
			// get the home interface for BookSession with JNDI from the application server
			// holen des Home Interfaces f�r BookSession mit JNDI vom Appplication Server
			BookSessionHome bookSessionHome = (BookSessionHome) context.lookup(BookSessionHome.JNDI_NAME);
			BookSession bookSession = bookSessionHome.create();
			// get book by primary key and set it in the form bean
			// bestimme das Buch anhand seines Prim�rschl�ssels und setzte es im Form Bean
			bookEditForm.setBookView(bookSession.getBookByPrimaryKey(id));

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
	 * Method borrowBook
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward borrowBook(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		BookEditForm bookEditForm = (BookEditForm) form;

		/*
		 * lalinuna.de 04.11.2004 get id of the book from request
		 */
		Integer id = Integer.valueOf(request.getParameter("id"));

		/*
		 * lalinuna.de 16.11.2004 load the session facade for book and user get the book
		 * information and get all users
		 */
		try {
			InitialContext context = new InitialContext();
			// get the home interface for BookSession with JNDI from the application server
			// holen des Home Interfaces f�r BookSession mit JNDI vom Appplication Server
			BookSessionHome bookSessionHome = (BookSessionHome) context.lookup(BookSessionHome.JNDI_NAME);
			BookSession bookSession = bookSessionHome.create();
			;

			// get the home interface for UserSession with JNDI from the application server
			// holen des Home Interfaces f�r UserSession mit JNDI vom Appplication Server
			UserSessionHome userSessionHome = (UserSessionHome) context.lookup(UserSessionHome.JNDI_NAME);
			UserSession userSession = userSessionHome.create();

			// get book by primary key and set it in the form bean
			// lies das Buch anhand seines Prim�rschl�ssels und setzte es im Form Bean
			bookEditForm.setBookView(bookSession.getBookByPrimaryKey(id));

			// get all users and set them in the request
			// bestimme alle Benutzer und setzte diese im Request
			request.setAttribute("users", userSession.getAllUsers());

		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (CreateException e) {
			e.printStackTrace();
		}

		return mapping.findForward("showBorrowUser");
	}

	/**
	 * Method returnBook
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward returnBook(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		BookEditForm bookEditForm = (BookEditForm) form;

		/*
		 * lalinuna.de 04.11.2004 get id of the book from request
		 */
		Integer id = Integer.valueOf(request.getParameter("id"));

		/*
		 * lalinuna.de 16.11.2004 load the session facade and delete the book by primary
		 * key
		 */
		try {
			InitialContext context = new InitialContext();
			// get the home interface for BookSession with JNDI from the application server
			// holen des Home Interfaces f�r BookSession mit JNDI vom Appplication Server
			BookSessionHome bookSessionHome = (BookSessionHome) context.lookup(BookSessionHome.JNDI_NAME);
			BookSession bookSession = bookSessionHome.create();

			// delete the relation between user and book
			// l�scht die Beziehung zwischen Benutzer und Buch
			bookSession.returnBook(id);

		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (CreateException e) {
			e.printStackTrace();
		}

		return mapping.findForward("showList");
	}

	/**
	 * Method deleteBook
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward deleteBook(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		BookEditForm bookEditForm = (BookEditForm) form;

		/*
		 * lalinuna.de 04.11.2004 get id of the book from request
		 */
		Integer id = Integer.valueOf(request.getParameter("id"));

		/*
		 * lalinuna.de 16.11.2004 load the session facade and delete the book by primary
		 * key
		 */
		try {
			InitialContext context = new InitialContext();
			// get the home interface for BookSession with JNDI from the application server
			// holen des Home Interfaces f�r BookSession mit JNDI vom Appplication Server
			BookSessionHome bookSessionHome = (BookSessionHome) context.lookup(BookSessionHome.JNDI_NAME);
			BookSession bookSession = bookSessionHome.create();

			// remove the book by primary key
			// l�scht eine Buch anhand des Prim�rschl�ssels
			bookSession.removeBookByPrimaryKey(id);

		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (CreateException e) {
			e.printStackTrace();
		}

		return mapping.findForward("showList");
	}

	/**
	 * Method addBook
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward addBook(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		BookEditForm bookEditForm = (BookEditForm) form;

		return mapping.findForward("showAdd");

	}

	/**
	 * Method saveBook
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward saveBorrow(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		BookEditForm bookEditForm = (BookEditForm) form;

		/*
		 * lalinuna.de 16.11.2004 load the session facade and save the book by primary
		 * key
		 */
		try {
			InitialContext context = new InitialContext();
			// get the home interface for BookSession with JNDI from the application server
			// holen des Home Interfaces f�r BookSession mit JNDI vom Appplication Server
			BookSessionHome bookSessionHome = (BookSessionHome) context.lookup(BookSessionHome.JNDI_NAME);
			BookSession bookSession = bookSessionHome.create();

			// borrow a book to a user
			// ein Buch an einen Benutzer verleihen
			bookSession.borrowBook(bookEditForm.getId(), bookEditForm.getUserId());

		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (CreateException e) {
			e.printStackTrace();
		}

		return mapping.findForward("showList");
	}

	/**
	 * Method saveBook
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward saveBook(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		BookEditForm bookEditForm = (BookEditForm) form;

		/*
		 * lalinuna.de 16.11.2004 load the session facade and save the book by primary
		 * key
		 */
		try {
			InitialContext context = new InitialContext();
			// get the home interface for BookSession with JNDI from the application server
			// holen des Home Interfaces f�r BookSession mit JNDI vom Appplication Server
			BookSessionHome bookSessionHome = (BookSessionHome) context.lookup(BookSessionHome.JNDI_NAME);
			BookSession bookSession = bookSessionHome.create();

			// save the book value objekt
			// speichern des Book Value Ojekts
			bookSession.saveBook(bookEditForm.getBookValue());

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