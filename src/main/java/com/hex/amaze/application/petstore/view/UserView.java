/*
 * Created on 19.11.2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.hex.amaze.application.petstore.view;

import com.hex.amaze.application.petstore.entity.interfaces.UserValue;

/**
 * @author WinXP
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class UserView {
	
	private UserValue userValue = new UserValue();
	
	
	public UserValue getUserValue() {
		return userValue;
	}
	public void setUserValue(UserValue userValue) {
		this.userValue = userValue;
	}
	public boolean ageHasBeenSet() {
		return userValue.ageHasBeenSet();
	}
	public boolean equals(Object arg0) {
		return userValue.equals(arg0);
	}
	public Integer getAge() {
		return userValue.getAge();
	}
	public Integer getId() {
		return userValue.getId();
	}
	public String getLastName() {
		return userValue.getLastName();
	}
	public String getName() {
		return userValue.getName();
	}
	public Integer getPrimaryKey() {
		return userValue.getPrimaryKey();
	}
	public int hashCode() {
		return userValue.hashCode();
	}
	public boolean idHasBeenSet() {
		return userValue.idHasBeenSet();
	}
	public boolean isIdentical(Object other) {
		return userValue.isIdentical(other);
	}
	public boolean lastNameHasBeenSet() {
		return userValue.lastNameHasBeenSet();
	}
	public boolean nameHasBeenSet() {
		return userValue.nameHasBeenSet();
	}
	public void setAge(Integer age) {
		userValue.setAge(age);
	}
	public void setId(Integer id) {
		userValue.setId(id);
	}
	public void setLastName(String lastName) {
		userValue.setLastName(lastName);
	}
	public void setName(String name) {
		userValue.setName(name);
	}
	public void setPrimaryKey(Integer pk) {
		userValue.setPrimaryKey(pk);
	}
	public String toString() {
		return userValue.toString();
	}
}
