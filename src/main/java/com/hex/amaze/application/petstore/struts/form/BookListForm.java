//Created by MyEclipse Struts
// XSL source (default): platform:/plugin/com.genuitec.eclipse.cross.easystruts.eclipse_3.8.1/xslt/JavaClass.xsl

package com.hex.amaze.application.petstore.struts.form;

import org.apache.struts.action.ActionForm;

import com.hex.amaze.application.petstore.view.BookView;

/** 
 * MyEclipse Struts
 * Creation date: 10-05-2004
 * 
 * XDoclet definition:
 * @struts:form name="bookListForm"
 */
public class BookListForm extends ActionForm {
    
	private BookView[] bookViews = new BookView[0];
	
	public BookView[] getBookViews() {
		return bookViews;
	}
	public void setBookViews(BookView[] bookViews) {
		this.bookViews = bookViews;
	}
}