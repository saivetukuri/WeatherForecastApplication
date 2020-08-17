package com.virtusa.sai.control;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//WeatherMain is a Controller
@Controller
public class WeatherMain {
	private static final Logger LOGGER = LoggerFactory.getLogger(WeatherMain.class);
	@RequestMapping("/weatherhome")// URL Pattern for going to opening page of the project .
	public String welcome() {
		LOGGER.trace("Entering Method welcome");
		LOGGER.debug("Enter into the Home Page");
		LOGGER.info("Welcome to Home Page");
		return "WeatherHome";
		
	}
	
		@RequestMapping("/weatherreg") // URL Pattern for going to the Registration page .
		public String Register() {
			LOGGER.trace("Entering Method Register");
			LOGGER.debug("Enter into the Registration Page");
			LOGGER.info("Welcome to Registration Page");
			return "WeatherRegister";
		}
		
	@RequestMapping("/weatherlog") // URL Pattern for going to Login page .
	public String Login() {
		
		LOGGER.trace("Entering Method Login");
		LOGGER.debug("Enter into the Login Page");
		LOGGER.info("Welcome to Login Page");
		return "WeatherLogin";
	}
	
@RequestMapping("/cities")
public String CitySearch()
{

	return "CitiesSearch";
}
@RequestMapping("/cities1")
public String CitySearch1() {
	return "Cities1";
}



	}

