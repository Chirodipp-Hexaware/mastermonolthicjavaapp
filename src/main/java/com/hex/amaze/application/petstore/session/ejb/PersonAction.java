package com.hex.amaze.application.petstore.session.ejb;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.hex.amaze.application.petstore.model.Person;
import com.opensymphony.xwork2.ActionSupport;

public class PersonAction extends ActionSupport implements SessionAware {

	private Person person = new Person();

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	private Map<String, Object> session;

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String execute() { // Create persons
		List<Person> personList = (List<Person>) session.get("personList");
//		for (Person p : personList)
//			getPersonService().save(p); // save to db
		// clear the list
		personList.clear();
		return SUCCESS;
	}

	public String add() { // Add person
		List<Person> personList = (List<Person>) session.get("personList");
		if (personList == null) {
			personList = new ArrayList<Person>();
			session.put("personList", personList);
		}
		personList.add(person);
		return SUCCESS;
	}

}