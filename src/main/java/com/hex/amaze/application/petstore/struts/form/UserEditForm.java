//Created by MyEclipse Struts
// XSL source (default): platform:/plugin/com.genuitec.eclipse.cross.easystruts.eclipse_3.8.0/xslt/JavaClass.xsl

package com.hex.amaze.application.petstore.struts.form;

import org.apache.struts.action.ActionForm;

import com.hex.amaze.application.petstore.entity.interfaces.UserValue;
import com.hex.amaze.application.petstore.view.UserView;

/** 
 * MyEclipse Struts
 * Creation date: 11-16-2004
 * 
 * XDoclet definition:
 * @struts:form name="userEditForm"
 */
public class UserEditForm extends ActionForm {

	private UserView userView = new UserView();
	
	public UserView getUserView() {
		return userView;
	}
	public void setUserView(UserView userView) {
		this.userView = userView;
	}
	public boolean ageHasBeenSet() {
		return userView.ageHasBeenSet();
	}
	public boolean equals(Object arg0) {
		return userView.equals(arg0);
	}
	public Integer getAge() {
		return userView.getAge();
	}
	public Integer getId() {
		return userView.getId();
	}
	public String getLastName() {
		return userView.getLastName();
	}
	public String getName() {
		return userView.getName();
	}
	public Integer getPrimaryKey() {
		return userView.getPrimaryKey();
	}
	public UserValue getUserValue() {
		return userView.getUserValue();
	}
	public int hashCode() {
		return userView.hashCode();
	}
	public boolean idHasBeenSet() {
		return userView.idHasBeenSet();
	}
	public boolean isIdentical(Object other) {
		return userView.isIdentical(other);
	}
	public boolean lastNameHasBeenSet() {
		return userView.lastNameHasBeenSet();
	}
	public boolean nameHasBeenSet() {
		return userView.nameHasBeenSet();
	}
	public void setAge(Integer age) {
		userView.setAge(age);
	}
	public void setId(Integer id) {
		userView.setId(id);
	}
	public void setLastName(String lastName) {
		userView.setLastName(lastName);
	}
	public void setName(String name) {
		userView.setName(name);
	}
	public void setPrimaryKey(Integer pk) {
		userView.setPrimaryKey(pk);
	}
	public void setUserValue(UserValue userValue) {
		userView.setUserValue(userValue);
	}
	public String toString() {
		return userView.toString();
	}
}