package com.virtusa.sai.dao;

public class UserUpdateDetails {
	private String firstname;
	private String lastname;
	private String email;
	private Long mobile;
	private String country;
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	@Override
	public String toString() {
		return "UserUpdateDetails [firstname=" + firstname + ", lastname=" + lastname + ", email=" + email + ", mobile="
				+ mobile + ", country=" + country + "]";
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
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
}
