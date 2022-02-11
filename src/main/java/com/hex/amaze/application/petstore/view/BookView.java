/*
 * Created on 19.11.2004
 */
package com.hex.amaze.application.petstore.view;

import com.hex.amaze.application.petstore.entity.interfaces.BookValue;

/**
 * @author laliluna.de
 */
public class BookView {
	
	private BookValue bookValue = new BookValue();
	private UserView userView = new UserView();
	
	public boolean authorHasBeenSet() {
		return bookValue.authorHasBeenSet();
	}
	public boolean availableHasBeenSet() {
		return bookValue.availableHasBeenSet();
	}
	public boolean equals(Object arg0) {
		return bookValue.equals(arg0);
	}
	public String getAuthor() {
		return bookValue.getAuthor();
	}
	public Boolean getAvailable() {
		return bookValue.getAvailable();
	}
	public Integer getId() {
		return bookValue.getId();
	}
	public Integer getPrimaryKey() {
		return bookValue.getPrimaryKey();
	}
	public String getTitle() {
		return bookValue.getTitle();
	}
	public int hashCode() {
		return bookValue.hashCode();
	}
	public boolean idHasBeenSet() {
		return bookValue.idHasBeenSet();
	}
	public boolean isIdentical(Object other) {
		return bookValue.isIdentical(other);
	}
	public void setAuthor(String author) {
		bookValue.setAuthor(author);
	}
	public void setAvailable(Boolean available) {
		bookValue.setAvailable(available);
	}
	public void setId(Integer id) {
		bookValue.setId(id);
	}
	public void setPrimaryKey(Integer pk) {
		bookValue.setPrimaryKey(pk);
	}
	public void setTitle(String title) {
		bookValue.setTitle(title);
	}
	public boolean titleHasBeenSet() {
		return bookValue.titleHasBeenSet();
	}
	public String toString() {
		return bookValue.toString();
	}
	public BookValue getBookValue() {
		return bookValue;
	}
	public void setBookValue(BookValue bookValue) {
		this.bookValue = bookValue;
	}
	public UserView getUserView() {
		return userView;
	}
	public void setUserView(UserView userView) {
		this.userView = userView;
	}
	public Integer getUserId() {
		return bookValue.getUserId();
	}
	public void setUserId(Integer userId) {
		bookValue.setUserId(userId);
	}
	public boolean userIdHasBeenSet() {
		return bookValue.userIdHasBeenSet();
	}
}
