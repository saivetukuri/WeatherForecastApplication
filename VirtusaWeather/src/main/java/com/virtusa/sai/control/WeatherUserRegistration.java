package com.virtusa.sai.control;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.virtusa.sai.dao.UserRegistration;
import com.virtusa.sai.jdbc.UserRegistrationJDBC;

@Controller
public class WeatherUserRegistration {
	private static final Logger LOGGER = LoggerFactory.getLogger(WeatherUserRegistration.class);
	@Autowired
	private DataSource datasource;
	@Autowired
	JdbcTemplate jdbctemplate;
	
	@GetMapping("/weatherreg")
	public String GetRegister(Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method GetRegister");
		LOGGER.debug("Enter your Details to create an account");
		UserRegistration user =new UserRegistration();
		model.addAttribute("user", user);
		session.setAttribute("user", user);
		return "WeatherRegister";
	}
	@PostMapping("/weatherreg")
	public String PostRegister(@ModelAttribute("user") UserRegistration user,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method PostRegister");
		LOGGER.debug("Register as new user");
		try {
		SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

				.withProcedureName("UserReg");

				Map<String, Object> inParamMap = new HashMap<String, Object>();
				inParamMap.put("emailid", user.getEmail());
				inParamMap.put("fname", user.getFirstname());
				inParamMap.put("lname", user.getLastname());
				inParamMap.put("phone", user.getMobile());
				inParamMap.put("pass", user.getPassword());
				inParamMap.put("country", user.getCountry());
				inParamMap.put("response", "@response");
				System.out.println(user.getPassword());
				SqlParameterSource in = new MapSqlParameterSource(inParamMap);


				Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
				System.out.println(simpleJdbcCallResult.get("response"));
				model.addAttribute("response",simpleJdbcCallResult.get("response"));
				session.setAttribute("response",simpleJdbcCallResult.get("response"));
		System.out.println("DataSource:"+datasource);
		LOGGER.info("Response Created for Registration");
		}
		catch(Exception e) {
			LOGGER.error("Registration Failed");
			model.addAttribute("response","Failed");
			session.setAttribute("response","Failed");
			return "WeatherRegister";
		}
		return "WeatherRegister";
	}
		

}
