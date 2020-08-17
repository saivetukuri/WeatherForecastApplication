package com.virtusa.sai.dao;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

public class UserRegistration {

	private SimpleJdbcCall simpleJdbcCall;
	private String firstname;
	private String lastname;
	private String email;
	private Long mobile;
	private String password;
	private String country;
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	
	@Override
	public String toString() {
		return "firstname=" + firstname + ", lastname=" + lastname + ", email=" + email + ", mobile="
				+ mobile + ", password=" + password + ",country=" + country;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Long getMobile() {
		return mobile;
	}
	public void setMobile(Long mobile) {
		this.mobile = mobile;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password1) {
		this.password = password1;
	}


}
