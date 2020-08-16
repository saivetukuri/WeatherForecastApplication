package com.virtusa.sai.dao;

public class UserPassword {
String password;
String newpassword;

public String getPassword() {
	return password;
}
public void setPassword(String password1) {
	this.password = password1;
}
public String getNewpassword() {
	return newpassword;
}
@Override
public String toString() {
	return "UserPassword [password1=" + password + ", newpassword1=" + newpassword + "]";
}
public void setNewpassword(String newpassword) {
	this.newpassword = newpassword;
}

}
