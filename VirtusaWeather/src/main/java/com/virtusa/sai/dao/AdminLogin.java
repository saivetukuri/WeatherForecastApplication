package com.virtusa.sai.dao;

public class AdminLogin {
private String adminname;
public String getAdminname() {
	return adminname;
}
public void setAdminname(String adminname) {
	this.adminname = adminname;
}
public String getPassword() {
	return password;
}
@Override
public String toString() {
	return "AdminLogin [adminname=" + adminname + ", password=" + password + "]";
}
public void setPassword(String password) {
	this.password = password;
}
private String password;
}
