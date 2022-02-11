
package com.hex.amaze.application.petstore.struts.form;


import org.apache.struts.action.ActionForm;

import com.hex.amaze.application.petstore.entity.interfaces.BookValue;
import com.hex.amaze.application.petstore.view.BookView;
import com.hex.amaze.application.petstore.view.UserView;



/** 
 * MyEclipse Struts
 * Creation date: 11-04-2004
 * 
 * XDoclet definition:
 * @struts:form name="bookEditForm"
 */
public class BookEditForm extends ActionForm {

	private BookView bookView = new BookView();
	
	public BookView getBookView() {
		return bookView;
	}
	public void setBookView(BookView bookView) {
		this.bookView = bookView;
	}
	public boolean authorHasBeenSet() {
		return bookView.authorHasBeenSet();
	}
	public boolean availableHasBeenSet() {
		return bookView.availableHasBeenSet();
	}
	public boolean equals(Object arg0) {
		return bookView.equals(arg0);
	}
	public String getAuthor() {
		return bookView.getAuthor();
	}
	public Boolean getAvailable() {
		return bookView.getAvailable();
	}
	public BookValue getBookValue() {
		return bookView.getBookValue();
	}
	public Integer getId() {
		return bookView.getId();
	}
	public Integer getPrimaryKey() {
		return bookView.getPrimaryKey();
	}
	public String getTitle() {
		return bookView.getTitle();
	}
	public Integer getUserId() {
		return bookView.getUserId();
	}
	public UserView getUserView() {
		return bookView.getUserView();
	}
	public int hashCode() {
		return bookView.hashCode();
	}
	public boolean idHasBeenSet() {
		return bookView.idHasBeenSet();
	}
	public boolean isIdentical(Object other) {
		return bookView.isIdentical(other);
	}
	public void setAuthor(String author) {
		bookView.setAuthor(author);
	}
	public void setAvailable(Boolean available) {
		bookView.setAvailable(available);
	}
	public void setBookValue(BookValue bookValue) {
		bookView.setBookValue(bookValue);
	}
	public void setId(Integer id) {
		bookView.setId(id);
	}
	public void setPrimaryKey(Integer pk) {
		bookView.setPrimaryKey(pk);
	}
	public void setTitle(String title) {
		bookView.setTitle(title);
	}
	public void setUserId(Integer userId) {
		bookView.setUserId(userId);
	}
	public void setUserView(UserView userView) {
		bookView.setUserView(userView);
	}
	public boolean titleHasBeenSet() {
		return bookView.titleHasBeenSet();
	}
	public String toString() {
		return bookView.toString();
	}
	public boolean userIdHasBeenSet() {
		return bookView.userIdHasBeenSet();
	}
}