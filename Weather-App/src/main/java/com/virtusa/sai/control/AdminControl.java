package com.virtusa.sai.control;

import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.virtusa.sai.dao.AdminLogin;

import com.virtusa.sai.dao.UserLogin;
import com.virtusa.sai.dao.UserPassword;
import com.virtusa.sai.dao.UserRegistration;
import com.virtusa.sai.dao.UserUpdateDetails;
// AdminControl is a Controller
@Controller
public class AdminControl {
	private static final Logger LOGGER = LoggerFactory.getLogger(AdminControl.class); // Logging for AdminControl class.
	@Autowired
	private DataSource datasource; // Datasource used is Hikari Connection Pool.
	@Autowired
	JdbcTemplate jdbctemplate; // Use to perform operations on Database(MySQL).
	@RequestMapping("/weatheradminlog") // URL Pattern for AdminLogin.jsp .
	public String AdminLogin(HttpServletRequest request) {
		LOGGER.trace("Entering Method AdminLogin");
		LOGGER.debug(" Enter the Login Credentials");
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
		// Move to page AdminLogin.jsp.
		return "AdminLogin";
	}
	
	@RequestMapping("/weatheradminlogafter") //URL Pattern for going to the Admin User page.
	public String AdminLoginPage(@ModelAttribute("admin") AdminLogin adminlogin,Model model,HttpServletRequest request)
	{
		LOGGER.trace("Entering Metohd AdminLoginPage");
		LOGGER.debug("Authenticating user with email: "+adminlogin.getAdminname());
		HttpSession session=request.getSession();
		System.out.println(datasource);
		try {
			// Stored Procedure used for Admin Login Authentication.
			SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

					.withProcedureName("AdminLogin");

					Map<String, Object> inParamMap = new HashMap<String, Object>();
					inParamMap.put("pemail", adminlogin.getAdminname());
				
					inParamMap.put("ppassword", adminlogin.getPassword());
					inParamMap.put("response", "@response");
					
					SqlParameterSource in = new MapSqlParameterSource(inParamMap);
					

					Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
					System.out.println(simpleJdbcCallResult.get("response"));
					session.setAttribute("useremail",adminlogin.getAdminname());
			
			// Stored Procedure used for getting all details of the admin who logged in.
			SimpleJdbcCall simpleJdbcCall1 = new SimpleJdbcCall(jdbctemplate)

					.withProcedureName("AdminDetails");

					Map<String, Object> inParamMap1 = new HashMap<String, Object>();
					inParamMap1.put("pemail", session.getAttribute("useremail"));
					inParamMap1.put("pfirstname", "@pfirstname");
					inParamMap1.put("plastname", "@plastname");
					inParamMap1.put("pmobile", "@mobile");
					inParamMap1.put("pcountry", "@country");
					inParamMap1.put("response", "@response");
							
					SqlParameterSource in1 = new MapSqlParameterSource(inParamMap1);
					Map<String, Object> simpleJdbcCallResult1 = simpleJdbcCall1.execute(in);
							
							
					LOGGER.warn("Checking the response");
					// Checking whether Login Credentials are correct or not.
			if(simpleJdbcCallResult.get("response").equals("User successfully logged in")) {
						
				LOGGER.info("User authenticated Successfully");
				model.addAttribute("userafterlogin", simpleJdbcCallResult1);
				session.setAttribute("userafterlogin", simpleJdbcCallResult1);
				session.setAttribute("firstname",simpleJdbcCallResult1.get("pfirstname"));
				session.setAttribute("lastname", simpleJdbcCallResult1.get("plastname"));
				session.setAttribute("useremail",session.getAttribute("useremail"));
				session.setAttribute("country",simpleJdbcCallResult1.get("pcountry"));
				session.setAttribute("mobile",simpleJdbcCallResult1.get("pmobile"));
				// If Login credentials are correct then move to the page AdminAfterLogin.jsp .
				return "AdminAfterLogin";
					}
		}
		catch(Exception e) {
			
			LOGGER.error("No User Exists");
			System.out.println("No User Exists");
			// If no user exists in the database then move to the page AdminLogin.jsp . 
			return "AdminLogin";
		}
		LOGGER.error("Invalid Login");
		// If Login Credentials are wrong then move to the page AdminLogin.jsp .
		return "AdminLogin";
		
	}
	
	@RequestMapping("/viewadminprofile") // URL Pattern for viewing admin profile
	public String AdminProfile(HttpServletRequest request) {
		LOGGER.trace("Entering Method AdminProfile");
		LOGGER.debug(" View Admin Profile");
		HttpSession session=request.getSession();
		// Check whether the admin email is present in session or not 
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			//If Admin email present in session then go to ViewAdminProfile.jsp .
		return "ViewAdminProfile";
		}
		else {

			LOGGER.error("User Id Expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
		return "AdminLogin";
		}
	}
	
	@RequestMapping("/adminpasswordchange") // URL Pattern for going to Change Password page
	public String AdminPasswordSite(Model model,HttpServletRequest request) {
		LOGGER.trace("Entering Method AdminPasswordSite");
		LOGGER.debug("Change Admin Password");
		HttpSession session=request.getSession();
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			//If Admin email present in session then go to ChangeAdminPassword.jsp .
		return "ChangeAdminPassword";
		}
		else {

			LOGGER.error("User Id Expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
		return "AdminLogin";
		}
		
	}
	
	@RequestMapping("/updateadminpassword") // URL Pattern for going to Change Admin Password Page
	public String UpdateAdminPassword(@ModelAttribute("adminpassword") UserPassword userpassword,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		UserRegistration userr=new UserRegistration();
		LOGGER.trace("Entering Method UpdateAdminPassword");
		LOGGER.debug("Update Admin Password");
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				
				System.out.println(session.getAttribute("useremail"));
				
				// Stored Procedure to Change Admin Password
				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("AdminPassChang");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						inParamMap.put("pemail",session.getAttribute("useremail") );
						inParamMap.put("oldppassword", userpassword.getPassword());
						inParamMap.put("newppassword", userpassword.getNewpassword());
				
						inParamMap.put("response", "@response");
						LOGGER.info("Display Admin Details");
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
						System.out.println(simpleJdbcCallResult.get("response"));
						System.out.println(simpleJdbcCallResult.get("response").equals("User password changed successfully "));
						model.addAttribute("response",simpleJdbcCallResult.get("response"));
						session.setAttribute("response",simpleJdbcCallResult.get("response"));
					if(simpleJdbcCallResult.get("response").equals("User password changed successfully ")) {
						LOGGER.info("Password Changed");
						// If Password is changed successfully then go to AdminAfterLogin.jsp .
					return "AdminAfterLogin";
					
				}
				else {
					LOGGER.error("Password not changed");
					
					System.out.println("Not Changed");
					// If Password is not changed successfully then go to ChangeAdminPassword.jsp .
					return "ChangeAdminPassword";
				}
					}
			
catch(Exception e) {
				
				LOGGER.error("Can not change password");
				// If any error occurs while changing password then go to AdminLogin.jsp
				return "AdminLogin";
			}
		}
		else {
		
			LOGGER.error("User Id Expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
		    return "AdminLogin";
	}
	}
	
	
	@RequestMapping("/adminupdate") // URL Pattern for going to Admin Update Page.
	public String AdminUpdate(Model model,HttpServletRequest request) {
		UserRegistration userr=new UserRegistration();
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method AdminUpdate");
		LOGGER.debug("Update Admin Details");
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			
		try {
			LOGGER.info("User Id Present");
				
			// Stored Procedure to get all details of the admin logged in to view on the input field
			SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

					.withProcedureName("AdminDetails");

					Map<String, Object> inParamMap = new HashMap<String, Object>();
					inParamMap.put("pemail", session.getAttribute("useremail"));
					inParamMap.put("pfirstname", "@pfirstname");
					inParamMap.put("plastname", "@plastname");
					inParamMap.put("pmobile", "@mobile");
					inParamMap.put("pcountry", "@country");
					inParamMap.put("response", "@response");
					
					SqlParameterSource in = new MapSqlParameterSource(inParamMap);
					Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
					LOGGER.info("Display Admin Details");
				
					
					model.addAttribute("userr",simpleJdbcCallResult);
					session.setAttribute("userr",simpleJdbcCallResult);
					//If Admin email present in session then go to AdminUpdate.jsp .		
			return "AdminUpdate";
			}
			catch(Exception e) {
				LOGGER.error("Can not Update Details");
				// If any error occurs while entering into the page then go to AdminLogin.
				return "AdminLogin";
			}
		}
		else {
			LOGGER.error("User Id Expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
			return "AdminLogin";
		}
		
	}
	
	
	@RequestMapping("/weatheradminupdate") // URL Pattern for going to a page after updating admin details
	public String UpdateDetails(@ModelAttribute("adminupdate") UserUpdateDetails userreg,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		System.out.println(userreg.toString());
		LOGGER.trace("Entering Method UpdateDetails");
		LOGGER.debug("Starting Update");
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				// Stored Procedure to update the Admin Details
				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("AdminUpdate");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						inParamMap.put("pemail",session.getAttribute("useremail") );
						inParamMap.put("pfirstname", userreg.getFirstname());
						inParamMap.put("plastname", userreg.getLastname());
						inParamMap.put("pmobile", userreg.getMobile());
						inParamMap.put("pcountry", userreg.getCountry());
						inParamMap.put("response", "@response");
						LOGGER.info("Display Admin Details");
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
						System.out.println(simpleJdbcCallResult.get("response"));
				session.setAttribute("firstname",userreg.getFirstname());
				session.setAttribute("lastname", userreg.getLastname());
				session.setAttribute("useremail",session.getAttribute("useremail"));
				session.setAttribute("country",userreg.getCountry());
				session.setAttribute("mobile",userreg.getMobile());
				model.addAttribute("response",simpleJdbcCallResult.get("response"));
				session.setAttribute("response",simpleJdbcCallResult.get("response"));
				System.out.println("DataSource:"+datasource);
				}
			catch(Exception e) {
				LOGGER.error("Can not Update Admin Details");
				// If any error occurs while updating then go to AdminUpdate.jsp .
				return "AdminUpdate";
			}
			LOGGER.info("Update Successfull");
			// If Admin details updated successfully then go to AdminAfterLogin.jsp .
		return "AdminAfterLogin";
	}
		else {
			LOGGER.error("User Id expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
			return "AdminLogin";
		}
}
	
	@RequestMapping("/addnewcustomer") // URL Pattern for going to Add new customer page
	public String AddCustomer(HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method AddCustomer");
		LOGGER.debug("Add a new  Customer");
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			LOGGER.info("Register for new customer");
			//If Admin email present in session then go to AddCustomer.jsp .
		return "AddCustomer";
		}
		else {
			LOGGER.error("User Id expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
			return "AdminLogin";
		}
		
	}
	
	@RequestMapping("/deletecustomer")// URL Pattern for going to Deleting customer page
	public String DeleteCustomer(HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method DeleteCustomer");
		LOGGER.debug("Delete any Customer");
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			LOGGER.info("Enter Customer email id");
			//If Admin email present in session then go to DeleteCustomer.jsp .
		return "DeleteCustomer";
		}
		else {
			LOGGER.error("User Id expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
			return "AdminLogin";
		}
	}
	
	@RequestMapping("/weatheradminlogafterhome")// URL Pattern for going back to Admin home page
	public String  AdminLoginPage(HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method AdminLoginPage");
		LOGGER.debug("Back to Home Page");
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			LOGGER.info("Welcome Home");
			//If Admin email present in session then go to AdminAfterLogin.jsp .
			return "AdminAfterLogin";
		}
		else {
			LOGGER.error("User Id Expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
			return "AdminLogin";
		}
		}
	
	@RequestMapping("/viewdeletedetails") // URL Pattern for view the details of user before deleting
	public String DeleteCustomerView(@RequestParam(value="email",required=false) String email,Model model,HttpServletRequest request) {
		System.out.println(email);
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method DeleteCustomerView");
		LOGGER.debug("View the Customer Details");
		model.addAttribute("emailsearch",email);
		session.setAttribute("emailsearch",email);
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
					
				// Get all the details of the user with the email as input
				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("UserDetails");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						inParamMap.put("pemail", email);
						inParamMap.put("pfirstname", "@pfirstname");
						inParamMap.put("plastname", "@plastname");
						inParamMap.put("pmobile", "@mobile");
						inParamMap.put("pcountry", "@country");
						inParamMap.put("response", "@response");
						LOGGER.info("Display the Customer Details");
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
						System.out.println(simpleJdbcCallResult.get("pfirstname"));
						System.out.println(simpleJdbcCallResult.get("plastname"));
						System.out.println(simpleJdbcCallResult.get("pmobile"));
						System.out.println(simpleJdbcCallResult.get("pcountry"));
						System.out.println(simpleJdbcCallResult.get("response"));
						
						model.addAttribute("userr",simpleJdbcCallResult);
						session.setAttribute("userr",simpleJdbcCallResult);
						//If Admin email present in session then go to DeleteView.jsp .
				return "DeleteView";
				}
				catch(Exception e) {
					LOGGER.error("Can not Delete Customer");
					//If any error occurs while entering into the page then go to AdminAfterLogin.jsp .
					return "AdminAfterLogin";
				}
			}
			else {
				LOGGER.error("User Id expired");
				//If Admin email not present in session then go to AdminLogin.jsp .
				return "AdminLogin";
			}
		
		
	}
	
	@RequestMapping("/deleteconfirm") // URL Pattern for going to a page after deletion of user.
	public String DeleteConfirm(@RequestParam(value="email",required=false) String email,Model model,HttpServletRequest request) {
		System.out.println(email);
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method DeleteConfirm");
		LOGGER.debug("Deleting Customer");
		model.addAttribute("emailsearch",email);
		session.setAttribute("emailsearch",email);
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
					
				// Stored Procedure used to delete a particular user in the database by Admin
				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("DeleteUser");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						inParamMap.put("pemail", email);
					
						inParamMap.put("response", "@response");
						
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
					
						System.out.println(simpleJdbcCallResult.get("response"));
						
						model.addAttribute("response",simpleJdbcCallResult.get("response"));
						session.setAttribute("response",simpleJdbcCallResult.get("response"));
						LOGGER.info("Deleted Customer Successfully");
						//If Deletion is Successful then go to DeleteCustomer
				return "DeleteCustomer";
				}
				catch(Exception e) {
					LOGGER.error("Cannot Delete Customer");
					//If any error occurs while deleting then go to DeleteView.jsp .
					return "DeleteView";
				}
			}
			else {
				LOGGER.error("User Id expired");
				//If Admin email not present in session then go to AdminLogin.jsp .
				return "AdminLogin";
			}
	}
	
	@RequestMapping("/updatecustomer") // URL Pattern for going to Update customer page
	public String UpdateCustomer(HttpServletRequest request) {
		LOGGER.trace("Entering Method UpdateCustomer");
		LOGGER.debug("Update Customer Details");
		HttpSession session=request.getSession();
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			//If Admin email present in session then go to UpdateCustomer.jsp .
		return "UpdateCustomer";
		}
		else {

			LOGGER.error("User Id Expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
		return "AdminLogin";
		}
	}
	
	@RequestMapping("/viewupdatedetails")// URL Pattern for viewing the customer details before updating
	public String UpdateCustomerView(@RequestParam(value="email",required=false) String email,Model model,HttpServletRequest request) {
		System.out.println(email);
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method UpdateCustomerView");
		LOGGER.debug(" View Customer Profile");
		model.addAttribute("emailsearch",email);
		session.setAttribute("emailsearch", email);
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				// Get all the details of the user with the email as input

				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("UserDetails");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						inParamMap.put("pemail", email);
						inParamMap.put("pfirstname", "@pfirstname");
						inParamMap.put("plastname", "@plastname");
						inParamMap.put("pmobile", "@mobile");
						inParamMap.put("pcountry", "@country");
						inParamMap.put("response", "@response");
						LOGGER.info("Display the Customer Details");
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
						System.out.println(simpleJdbcCallResult.get("pfirstname"));
						System.out.println(simpleJdbcCallResult.get("plastname"));
						System.out.println(simpleJdbcCallResult.get("pmobile"));
						System.out.println(simpleJdbcCallResult.get("pcountry"));
						System.out.println(simpleJdbcCallResult.get("response"));
						
						model.addAttribute("userr",simpleJdbcCallResult);
						session.setAttribute("userr",simpleJdbcCallResult);
						//If Admin email present in session then go to UpdateCustomerView.jsp .
	
				return "UpdateCustomerView";
				}
				catch(Exception e) {
					LOGGER.error("Cannot Update Customer Details");
					// If any error occurs while updating then go to AdminAfterLogin.jsp .
					return "AdminAfterLogin";
				}
			}
			else {
				LOGGER.error("User Id expired");
				//If Admin email not present in session then go to AdminLogin.jsp .
				return "AdminLogin";
			}
		
	}
	
	@RequestMapping("/updateconfirm") // URL Pattern for going to a page after updating of user details.
	public String UpdateConfirm(@ModelAttribute("userupdate") UserUpdateDetails userreg,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		System.out.println(userreg.toString());
		LOGGER.trace("Entering Method UpdateConfirm");
		LOGGER.debug("Updating Customer Details");
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				// Stored Procedure to Update the User Details in Database.
				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("UserUpdate");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						inParamMap.put("pemail",session.getAttribute("emailsearch"));
						inParamMap.put("pfirstname", userreg.getFirstname());
						inParamMap.put("plastname", userreg.getLastname());
						inParamMap.put("pmobile", userreg.getMobile());
						inParamMap.put("pcountry", userreg.getCountry());
						inParamMap.put("response", "@response");
						LOGGER.info("Display the Customer Details");
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
				System.out.println(simpleJdbcCallResult.get("response"));
				model.addAttribute("response", simpleJdbcCallResult.get("response"));
				session.setAttribute("response", simpleJdbcCallResult.get("response"));
				System.out.println("DataSource:"+datasource);
				}
			catch(Exception e) {
				LOGGER.error("Cannot Update Customer Details");
				// If error occurs while Updating User details then go to UpdateCustomerView.jsp .
				return "UpdateCustomerView";
			}
			LOGGER.info("Updated Customer Details Successfully");
			// If User Details are updated successfully then go to UpdateCustomer.jsp .
		return "UpdateCustomer";
	}
		else {
			LOGGER.error("User Id expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
			return "AdminLogin";
		}
	}
	
	@RequestMapping("/adminlistuser")// URL Pattern for viewing all the users present in database.
	public String ListCustomers(Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method ListCustomers");
		LOGGER.debug("Listing all customers");
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				// Get list of all users from database
				SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbctemplate)

						.withProcedureName("AllUsers");

						Map<String, Object> inParamMap = new HashMap<String, Object>();
						
						inParamMap.put("response", "@response");
						
						SqlParameterSource in = new MapSqlParameterSource(inParamMap);
						Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
					
						System.out.println(simpleJdbcCallResult.get("#result-set-1"));
						System.out.println(simpleJdbcCallResult.get("#result-set-1").toString());
						model.addAttribute("user1",simpleJdbcCallResult.get("#result-set-1"));
						session.setAttribute("user1",simpleJdbcCallResult.get("#result-set-1"));
						System.out.println(simpleJdbcCallResult.get("response"));
				model.addAttribute("response", simpleJdbcCallResult.get("response"));
				session.setAttribute("response", simpleJdbcCallResult.get("response"));
				LOGGER.info("Retrieving all customer details");
				
				System.out.println("DataSource:"+datasource);
				}
			catch(Exception e) {
				LOGGER.error("Cannot view all customers");
				// If error occurs while retrieving then go to AdminAfterLogin.jsp .
				return "AdminAfterLogin";
			}
			LOGGER.info("Displayed all Users");
			//If Admin email present in session then go to AllCustomers.jsp .

		return "AllCustomers";
	}
		else {
			LOGGER.error("User Id expired");
			//If Admin email not present in session then go to AdminLogin.jsp .
			return "AdminLogin";
		}
	}
	
	@PostMapping("/weatheradmincustomerreg") // URL Pattern for Registration of new user.
	public String PostRegister(@ModelAttribute("user") UserRegistration user,Model model,HttpServletRequest request) {
		LOGGER.trace("Entering Method PostRegister");
		LOGGER.debug("Adding Customer");
		HttpSession session=request.getSession();
		// Check whether the admin email is present in session or not
		if(session.getAttribute("useremail")!=null) {
		try {
			LOGGER.info("User Id Present");
			
		// Stored Procedure to add new user into database
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
				LOGGER.info("Inserting a new customer");

				Map<String, Object> simpleJdbcCallResult = simpleJdbcCall.execute(in);
				System.out.println(simpleJdbcCallResult.get("response"));
				model.addAttribute("response",simpleJdbcCallResult.get("response"));
				session.setAttribute("response",simpleJdbcCallResult.get("response"));
		System.out.println("DataSource:"+datasource);
		}
		catch(Exception e) {
			LOGGER.error("Adding Customer Failed");
			model.addAttribute("response","Failed");
			session.setAttribute("response","Failed");
			// If any error occurs while adding a new customer then go to AddCustomer.jsp .
			return "AddCustomer";
		}
		LOGGER.info("Response Created");
		// If Insertion is Successful then go to AddCustomer.jsp .
		return "AddCustomer";
	}
	
	else {

		LOGGER.error("User Id Expired");
		//If Admin email not present in session then go to AdminLogin.jsp .
	return "AdminLogin";
	}
			
	}
}

