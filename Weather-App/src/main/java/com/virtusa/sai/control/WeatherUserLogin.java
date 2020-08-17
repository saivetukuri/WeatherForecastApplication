package com.virtusa.sai.control;

import java.util.Enumeration;

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
import org.springframework.web.bind.annotation.RequestMapping;

import com.virtusa.sai.dao.UserLogin;
import com.virtusa.sai.dao.UserPassword;
import com.virtusa.sai.dao.UserRegistration;
//import com.virtusa.sai.dao.UserRegistrationStored;
import com.virtusa.sai.dao.UserUpdateDetails;

//WeatherUserLogin is a Controller
@Controller
public class WeatherUserLogin {
	private static final Logger LOGGER = LoggerFactory.getLogger(WeatherUserLogin.class); // Logging for WeatherUserLogin class.

	@Autowired
	private DataSource datasource; // Datasource used is Hikari Connection Pool.
	@Autowired
	JdbcTemplate jdbctemplate; // Use to perform operations on Database(MySQL).
	@GetMapping("/weatherlog") // URL Pattern for getting the username and password . 
	public String GetRegister(Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method GetRegister");
		LOGGER.debug("Take the login credentials as input");
		LOGGER.info("Checking whether credentials are mathcing or not");
		UserLogin userlogin =new UserLogin();
		model.addAttribute("userlogin", userlogin);
		session.setAttribute("userlogin", userlogin);
		
		return "WeatherLogin";
	}
	
	@PostMapping("/weatherlog") // URL Pattern for Login Authentication .
public String PostRegister(@ModelAttribute("userlogin") UserLogin userlogin,Model model,HttpServletRequest request) {
		UserRegistration userr=new UserRegistration();
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method PostRegister");
		LOGGER.debug("Verify the Login Credentials");
		
		
		System.out.println(userlogin.toString());
		System.out.println(datasource);
		try {
			// Stored Procedure used for User Login Authentication.
		SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

				.withProcedureName("UserLogin");

				Map<String, Object> inParamMap = new HashMap<String, Object>();
				inParamMap.put("pemail", userlogin.getUsername());
			
				inParamMap.put("ppassword", userlogin.getPassword());
				inParamMap.put("response", "@response");
				
				SqlParameterSource in = new MapSqlParameterSource(inParamMap);
				

				Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
				model.addAttribute("response",simpleJdbcCallResult.get("response"));
				session.setAttribute("response",simpleJdbcCallResult.get("response"));
				System.out.println(simpleJdbcCallResult.get("response"));
				session.setAttribute("useremail",userlogin.getUsername());
				
				// Stored Procedure used for getting all details of the user who logged in.
				SimpleJdbcCall simpleJdbcCall1 = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("UserDetails");

						Map<String, Object> inParamMap1 = new HashMap<String, Object>();
						inParamMap1.put("pemail", session.getAttribute("useremail"));
						inParamMap1.put("pfirstname", "@pfirstname");
						inParamMap1.put("plastname", "@plastname");
						inParamMap1.put("pmobile", "@mobile");
						inParamMap1.put("pcountry", "@country");
						inParamMap1.put("response", "@response");
						
						SqlParameterSource in1 = new MapSqlParameterSource(inParamMap1);
						Map<String, Object> simpleJdbcCallResult1 = simpleJdbcCall1.execute(in);
						System.out.println(simpleJdbcCallResult1.get("pfirstname"));
						System.out.println(simpleJdbcCallResult1.get("plastname"));
						System.out.println(simpleJdbcCallResult1.get("pmobile"));
						System.out.println(simpleJdbcCallResult1.get("pcountry"));
						System.out.println(simpleJdbcCallResult1.get("response"));
						LOGGER.info("Checking whether Password is Matching or not");
						
						// Checking whether Login Credentials are correct or not.
				if(simpleJdbcCallResult.get("response").equals("User successfully logged in")) {
					LOGGER.info("Password Matching");
					LOGGER.info("User Login Successful");
					session.setAttribute("userafterlogin", simpleJdbcCallResult1);
					model.addAttribute("userafterlogin", simpleJdbcCallResult1);
					session.setAttribute("firstname",simpleJdbcCallResult1.get("pfirstname"));
					session.setAttribute("lastname", simpleJdbcCallResult1.get("plastname"));
					session.setAttribute("useremail",session.getAttribute("useremail"));
					session.setAttribute("country1",simpleJdbcCallResult1.get("pcountry"));
					session.setAttribute("mobile",simpleJdbcCallResult1.get("pmobile"));
					// If Login credentials are correct then move to the page WeatherAfterLogin.jsp .
				return "WeatherAfterLogin";
				}
				else {
					LOGGER.error("User Login Failed");
					// If Login Credentials are wrong then move to the page WeatherLogin.jsp .
					return "WeatherLogin";
				}
		
		}
		catch(Exception e) {
			e.printStackTrace();
			System.out.println("No User Exists");
			LOGGER.error("No User Exists");
			model.addAttribute("response","Invalid Login");
			session.setAttribute("response","Invalid Login");
			// If no user exists in the database then move to the page WeatherLogin.jsp .
			return "WeatherLogin";
		}
	
	
	}
	@RequestMapping("/weatherlogout") //URL pattern for log out 
	public String LogOut(HttpServletRequest request) {
		LOGGER.trace("Entering Method LogOut");
		LOGGER.debug("Log out from your account");
		HttpSession session=request.getSession();
		// Get all values present the session.
		Enumeration<String> attributes = request.getSession().getAttributeNames();
		LOGGER.info("Deleting all Session Values");
		// Deleting each and every session present Once you Log out from Admin Account.
		while (attributes.hasMoreElements()) {
		    String attribute = (String) attributes.nextElement();
		    System.out.println(attribute+" : "+request.getSession().getAttribute(attribute));
		    session.removeAttribute(attribute);
		    System.out.println(attribute+" : "+request.getSession().getAttribute(attribute));
		}
		LOGGER.info("Back to Home Page");
		// Move to page WeatherHome.jsp.
		return "WeatherHome";
	}
	
	@RequestMapping("/weatherloghome") //URL pattern for going to user home page
	public String WeatherLogHome(HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method WeatherLogHome");
		LOGGER.debug("Back to the User Home Page");
		if(session.getAttribute("useremail")!=null) {
			//If user email present in session then go to WeatherAfterLogin.jsp .
			LOGGER.info("User Id Present");
		return "WeatherAfterLogin";
	}
		else {
			LOGGER.error("User Id expired");
			//If User email not present in session then go to WeatherLogin.jsp .
			return "WeatherLogin";
		}
	}
	@RequestMapping("/viewprofile")//URL pattern for viewing user profile
	public String ViewProfile(HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method ViewProfile");
		LOGGER.debug("View your Profile");
		if(session.getAttribute("useremail")!=null) {
			//If user email present in session then go to ViewProfile.jsp .
			LOGGER.info("User Id Present");
		return "ViewProfile";
	}
		else {
			LOGGER.error("User Id expired");
			//If User email not present in session then go to WeatherLogin.jsp .
			return "WeatherLogin";
		}
	}
	
	@RequestMapping("/userupdate") //URL pattern for going to User update page
	public String UserUpdate(Model model,HttpServletRequest request) {
		UserRegistration userr=new UserRegistration();
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method UserUpdate");
		LOGGER.debug("Update your profile");
		if(session.getAttribute("useremail")!=null) {
			//If user email present in session then go to UserUpdate.jsp .
			LOGGER.info("User Id Present");
		try {
			// Get all the details of the user with the email as input
			SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

					.withProcedureName("UserDetails");

					Map<String, Object> inParamMap = new HashMap<String, Object>();
					inParamMap.put("pemail", session.getAttribute("useremail"));
					inParamMap.put("pfirstname", "@pfirstname");
					inParamMap.put("plastname", "@plastname");
					inParamMap.put("pmobile", "@mobile");
					inParamMap.put("pcountry", "@country");
					inParamMap.put("response", "@response");
					
					SqlParameterSource in = new MapSqlParameterSource(inParamMap);
					Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
					System.out.println(simpleJdbcCallResult.get("pfirstname"));
					System.out.println(simpleJdbcCallResult.get("plastname"));
					System.out.println(simpleJdbcCallResult.get("pmobile"));
					System.out.println(simpleJdbcCallResult.get("pcountry"));
					System.out.println(simpleJdbcCallResult.get("response"));
					LOGGER.info("Display Your Details");
					model.addAttribute("userr",simpleJdbcCallResult);
					session.setAttribute("userr",simpleJdbcCallResult);
			//If user email present in session then go to UserUpdate.jsp .
			return "UserUpdate";
			}
			catch(Exception e) {
				LOGGER.error("Can not Update your profile");
				return "WeatherLogin";
			}
		}
		else {
			LOGGER.error("User Id expired");
			//If User email not present in session then go to WeatherLogin.jsp .
			return "WeatherLogin";
		}
		
	}
	
	@RequestMapping("/weatheruserupdate") //URL pattern for updating user details
	public String UpdateDetails(@ModelAttribute("userupdate") UserUpdateDetails userreg,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method UpdateDetails");
		LOGGER.debug("Updating your details");
		System.out.println(userreg.toString());
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			try {
				
				// Stored Procedure to Update the User Details in Database.
				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("UserUpdate");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						inParamMap.put("pemail",session.getAttribute("useremail") );
						inParamMap.put("pfirstname", userreg.getFirstname());
						inParamMap.put("plastname", userreg.getLastname());
						inParamMap.put("pmobile", userreg.getMobile());
						inParamMap.put("pcountry", userreg.getCountry());
						inParamMap.put("response", "@response");
						
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
						System.out.println(simpleJdbcCallResult.get("response"));
				session.setAttribute("firstname",userreg.getFirstname());
				session.setAttribute("lastname", userreg.getLastname());
				session.setAttribute("useremail",session.getAttribute("useremail"));
				session.setAttribute("country",userreg.getCountry());
				session.setAttribute("mobile",userreg.getMobile());
				LOGGER.info("Details Updated");
				System.out.println("DataSource:"+datasource);
				}
			catch(Exception e) {
				LOGGER.error("Can not Update your Details");
				return "UserUpdate";
			}
			//If user email present in session then go to WeatherAfterLogin.jsp .
		return "WeatherAfterLogin";
	}
		else {
			LOGGER.error("User Id expired");
			//If User email not present in session then go to WeatherLogin.jsp .
			return "WeatherLogin";
		}
}
	@RequestMapping("/passwordchange")//URL pattern for going to Change user password page
	public String UserPasswordSite(Model model,HttpServletRequest request) {
		LOGGER.trace("Entering Method UserPasswordSite");
		LOGGER.debug("Change your Password");
		LOGGER.info("Create new Password");
		return "ChangePassword";
	}
	
	@RequestMapping("/updatepassword")//URL pattern for Changing user password
	public String PasswordUpdate(@ModelAttribute("userpassword") UserPassword userpassword,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		UserRegistration userr=new UserRegistration();
		LOGGER.trace("Entering Method PasswordUpdate");
		LOGGER.debug("Changing Password");
		
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
					System.out.println(session.getAttribute("useremail"));
					// Stored Procedure to Change password in database.
				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("UserPassChang");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						inParamMap.put("pemail",session.getAttribute("useremail") );
						inParamMap.put("oldppassword", userpassword.getPassword());
						inParamMap.put("newppassword", userpassword.getNewpassword());
				
						inParamMap.put("response", "@response");
						
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
						System.out.println(simpleJdbcCallResult.get("response"));
						System.out.println(simpleJdbcCallResult.get("response").equals("User password changed successfully "));
						LOGGER.info("Password Changed");
					if(simpleJdbcCallResult.get("response").equals("User password changed successfully ")) {
						//If user email present in session then go to WeatherAfterLogin.jsp .
					return "WeatherAfterLogin";
					
				}
				else {
					System.out.println("Not Changed");
					LOGGER.error("Password Not Changed");
					return "ChangePassword";
				}}
			
catch(Exception e) {
				
	LOGGER.error("Can not change password");
				return "WeatherLogin";
			}
		}
		else {
		
			LOGGER.error("User Id expired");
			//If User email not present in session then go to WeatherLogin.jsp .
		return "WeatherLogin";
	}
	}
	
	
}
