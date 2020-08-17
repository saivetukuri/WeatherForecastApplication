package com.virtusa.sai.jdbc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.virtusa.sai.dao.UserRegistration;

public class UserRegistrationJDBC {
	@Autowired
	JdbcTemplate jdbctemplate;
	public String insert(UserRegistration user) {
		//Long mobileno=Long.valueOf(user.getMobile());
		/*
		 * return jdbctemplate.
		 * update("insert into User(firstname,lastname,email,mobile,password1,password2,country)"
		 * +" values(?,?,?,?,?,?,?)", new Object[]
		 * {user.getFirstname(),user.getLastname(),user.getEmail(),user.getMobile(),user
		 * .getPassword1(),user.getPassword2(), user.getCountry()});
		 */		return user.toString();
					
	}
}
