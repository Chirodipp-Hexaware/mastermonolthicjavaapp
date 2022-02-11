package com.hex.amaze.application.petstore.dao;

public class BasicInfo {

	private String ern;
	private String first_name;
	private String sur_name;
	private String badge_name;
	private String category;
	private String mail_box;
	private String email;
	private String base_port;
	private String crew_id;
	
	public BasicInfo (){
		super();
	}

	public BasicInfo (	String ern, String first_name,
						String sur_name, String badge_name,
						String category, String mail_box,
						String email, String base_port, String crew_id)
	{
		this.ern = ern;
		this.first_name = first_name;
		this.sur_name = sur_name;
		this.badge_name = badge_name;
		this.category = category;
		this.mail_box = mail_box;
		this.email = email;
		this.base_port = base_port;
		this.crew_id = crew_id;
	}
	
	public void setERN(String ern)
	{
		this.ern = ern;
	}
	
	public void setFirst_name (String first_name)
	{
		this.first_name = first_name;
	}
	
	public void setSur_name (String sur_name)
	{
		this.sur_name = sur_name;
	}
	
	public void setBadge_name (String badge_name)
	{
		this.badge_name = badge_name;
	}
	
	public void setCategory (String category)
	{
		this.category = category;
	}
	
	public void setMail_box (String mail_box)
	{
		this.mail_box = mail_box;
	}
	
	public void setEmail (String email)
	{
		this.email = email;
	}
	
	public void setBase_port (String base_port)
	{
		this.base_port = base_port;
	}	

	public void setCrew_id(String crew_id) {
		this.crew_id = crew_id;
	}
	
	public String getERN()
	{
		return ern;
	}
	
	public String getFirst_name()
	{
		return first_name;
	}
	
	public String getSur_name()
	{
		return sur_name;
	}
	
	public String getBadge_name()
	{
		return badge_name;
	}
	
	public String getCategory()
	{
		return category;
	}
	
	public String getMail_box()
	{
		return mail_box;
	}
	
	public String getEmail()
	{
		return email;
	}
	
	public String getBase_port()
	{
		return base_port;
	}

	public String getCrew_id() {
		return crew_id;
	}
	
	public BasicInfo (String ern,String crew_id,String category){
		this.ern =ern;
		this.crew_id = crew_id;	
		this.category = category;
	}
}
