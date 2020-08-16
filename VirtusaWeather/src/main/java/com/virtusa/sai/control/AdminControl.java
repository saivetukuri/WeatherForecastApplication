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

@Controller
public class AdminControl {
	private static final Logger LOGGER = LoggerFactory.getLogger(AdminControl.class);
	@Autowired
	private DataSource datasource;
	@Autowired
	JdbcTemplate jdbctemplate;
	@RequestMapping("/weatheradminlog")
	public String AdminLogin(HttpServletRequest request) {
		LOGGER.trace("Entering Method AdminLogin");
		LOGGER.debug(" Enter the Login Credentials");
		HttpSession session=request.getSession();
		Enumeration<String> attributes = request.getSession().getAttributeNames();
		LOGGER.info("Deleting all Session Values");
		while (attributes.hasMoreElements()) {
		    String attribute = (String) attributes.nextElement();
		    System.out.println(attribute+" : "+request.getSession().getAttribute(attribute));
		    session.removeAttribute(attribute);
		    System.out.println(attribute+" : "+request.getSession().getAttribute(attribute));
		}
		return "AdminLogin";
	}
	
	@RequestMapping("/weatheradminlogafter")
	public String AdminLoginPage(@ModelAttribute("admin") AdminLogin adminlogin,Model model,HttpServletRequest request)
	{
		LOGGER.trace("Entering Metohd AdminLoginPage");
		LOGGER.debug("Authenticating user with email: "+adminlogin.getAdminname());
HttpSession session=request.getSession();
		
		
		
		System.out.println(datasource);
		try {
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
					if(simpleJdbcCallResult.get("response").equals("User successfully logged in")) {
						LOGGER.info("User authenticated Successfully");
						model.addAttribute("userafterlogin", simpleJdbcCallResult1);
						session.setAttribute("userafterlogin", simpleJdbcCallResult1);
						session.setAttribute("firstname",simpleJdbcCallResult1.get("pfirstname"));
						session.setAttribute("lastname", simpleJdbcCallResult1.get("plastname"));
						session.setAttribute("useremail",session.getAttribute("useremail"));
						session.setAttribute("country",simpleJdbcCallResult1.get("pcountry"));
						session.setAttribute("mobile",simpleJdbcCallResult1.get("pmobile"));
						return "AdminAfterLogin";
					}
		}
		catch(Exception e) {
			
			LOGGER.error("No User Exists");
			System.out.println("No User Exists");
			return "AdminLogin";
		}
		LOGGER.error("Invalid Login");
		return "AdminLogin";
		
	}
	
	@RequestMapping("/viewadminprofile")
	public String AdminProfile(HttpServletRequest request) {
		LOGGER.trace("Entering Method AdminProfile");
		LOGGER.debug(" View Admin Profile");
		HttpSession session=request.getSession();

		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
		return "ViewAdminProfile";
		}
		else {

			LOGGER.error("User Id Expired");
		return "AdminLogin";
		}
	}
	
	@RequestMapping("/adminpasswordchange")
	public String AdminPasswordSite(Model model,HttpServletRequest request) {
		LOGGER.trace("Entering Method AdminPasswordSite");
		LOGGER.debug("Change Admin Password");
		HttpSession session=request.getSession();

		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
		return "ChangeAdminPassword";
		}
		else {

			LOGGER.error("User Id Expired");
		return "AdminLogin";
		}
		
	}
	
	@RequestMapping("/updateadminpassword")
	public String UpdateAdminPassword(@ModelAttribute("adminpassword") UserPassword userpassword,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		UserRegistration userr=new UserRegistration();
		LOGGER.trace("Entering Method UpdateAdminPassword");
		LOGGER.debug("Update Admin Password");
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				
					System.out.println(session.getAttribute("useremail"));
					
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
					return "AdminAfterLogin";
					
				}
				else {
					LOGGER.error("Password not changed");
					System.out.println("Not Changed");
					
					return "ChangeAdminPassword";
				}}
			
catch(Exception e) {
				e.printStackTrace();
				LOGGER.error("Can not change password");

				return "AdminLogin";
			}
		}
		else {
		
			LOGGER.error("User Id Expired");
		return "AdminLogin";
	}
	}
	
	
	@RequestMapping("/adminupdate")
	public String AdminUpdate(Model model,HttpServletRequest request) {
		UserRegistration userr=new UserRegistration();
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method AdminUpdate");
		LOGGER.debug("Update Admin Details");
		if(session.getAttribute("useremail")!=null) {
		try {
			LOGGER.info("User Id Present");
				
			
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
					
			return "AdminUpdate";
			}
			catch(Exception e) {
				LOGGER.error("Can not Update Details");
				return "AdminLogin";
			}
		}
		else {
			LOGGER.error("User Id Expired");
			return "AdminLogin";
		}
		
	}
	
	
	@RequestMapping("/weatheradminupdate")
	public String UpdateDetails(@ModelAttribute("adminupdate") UserUpdateDetails userreg,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		System.out.println(userreg.toString());
		LOGGER.trace("Entering Method UpdateDetails");
		LOGGER.debug("Starting Update");
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				
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
				return "AdminUpdate";
			}
			LOGGER.info("Update Successfull");
		return "AdminAfterLogin";
	}
		else {
			LOGGER.error("User Id expired");
			return "AdminLogin";
		}
}
	
	@RequestMapping("/addnewcustomer")
	public String AddCustomer(HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method AddCustomer");
		LOGGER.debug("Add a new  Customer");
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			LOGGER.info("Register for new customer");
		return "AddCustomer";
		}
		else {
			LOGGER.error("User Id expired");
			return "AdminLogin";
		}
		
	}
	
	@RequestMapping("/deletecustomer")
	public String DeleteCustomer(HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method DeleteCustomer");
		LOGGER.debug("Delete any Customer");
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			LOGGER.info("Enter Customer email id");
		return "DeleteCustomer";
		}
		else {
			LOGGER.error("User Id expired");
			return "AdminLogin";
		}
	}
	
	@RequestMapping("/weatheradminlogafterhome")
	public String  AdminLoginPage(HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method AdminLoginPage");
		LOGGER.debug("Back to Home Page");
		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
			LOGGER.info("Welcome Home");
			return "AdminAfterLogin";
		}
		else {
			LOGGER.error("User Id Expired");
			return "AdminLogin";
		}
		}
	
	@RequestMapping("/viewdeletedetails")
	public String DeleteCustomerView(@RequestParam(value="email",required=false) String email,Model model,HttpServletRequest request) {
		System.out.println(email);
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method DeleteCustomerView");
		LOGGER.debug("View the Customer Details");
		model.addAttribute("emailsearch",email);
		session.setAttribute("emailsearch",email);
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
					
				
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
				return "DeleteView";
				}
				catch(Exception e) {
					LOGGER.error("Can not Delete Customer");
					return "AdminAfterLogin";
				}
			}
			else {
				LOGGER.error("User Id expired");
				return "AdminLogin";
			}
		
		
	}
	
	@RequestMapping("/deleteconfirm")
	public String DeleteConfirm(@RequestParam(value="email",required=false) String email,Model model,HttpServletRequest request) {
		System.out.println(email);
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method DeleteConfirm");
		LOGGER.debug("Deleting Customer");
		model.addAttribute("emailsearch",email);
		session.setAttribute("emailsearch",email);
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
					
				
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
				return "DeleteCustomer";
				}
				catch(Exception e) {
					LOGGER.error("Cannot Delete Customer");
					return "DeleteView";
				}
			}
			else {
				LOGGER.error("User Id expired");
				return "AdminLogin";
			}
	}
	
	@RequestMapping("/updatecustomer")
	public String UpdateCustomer(HttpServletRequest request) {
		LOGGER.trace("Entering Method UpdateCustomer");
		LOGGER.debug("Update Customer Details");
		HttpSession session=request.getSession();

		if(session.getAttribute("useremail")!=null) {
			LOGGER.info("User Id Present");
		return "UpdateCustomer";
		}
		else {

			LOGGER.error("User Id Expired");
		return "AdminLogin";
		}
	}
	
	@RequestMapping("/viewupdatedetails")
	public String UpdateCustomerView(@RequestParam(value="email",required=false) String email,Model model,HttpServletRequest request) {
		System.out.println(email);
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method UpdateCustomerView");
		LOGGER.debug(" View Customer Profile");
		model.addAttribute("emailsearch",email);
		session.setAttribute("emailsearch", email);
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				
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
						
				return "UpdateCustomerView";
				}
				catch(Exception e) {
					LOGGER.error("Cannot Update Customer Details");
					return "AdminAfterLogin";
				}
			}
			else {
				LOGGER.error("User Id expired");
				return "AdminLogin";
			}
		
	}
	
	@RequestMapping("/updateconfirm")
	public String UpdateConfirm(@ModelAttribute("userupdate") UserUpdateDetails userreg,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		System.out.println(userreg.toString());
		LOGGER.trace("Entering Method UpdateConfirm");
		LOGGER.debug("Updating Customer Details");
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				
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
				return "UpdateCustomerView";
			}
			LOGGER.info("Updated Customer Details Successfully");
		return "UpdateCustomer";
	}
		else {
			LOGGER.error("User Id expired");
			return "AdminLogin";
		}
	}
	
	@RequestMapping("/adminlistuser")
	public String ListCustomers(Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		LOGGER.trace("Entering Method ListCustomers");
		LOGGER.debug("Listing all customers");
		if(session.getAttribute("useremail")!=null) {
			try {
				LOGGER.info("User Id Present");
				
				
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
				return "AdminAfterLogin";
			}
			LOGGER.info("Displayed all Users");
		return "AllCustomers";
	}
		else {
			LOGGER.error("User Id expired");
			return "AdminLogin";
		}
	}
	
	@PostMapping("/weatheradmincustomerreg")
	public String PostRegister(@ModelAttribute("user") UserRegistration user,Model model,HttpServletRequest request) {
		LOGGER.trace("Entering Method PostRegister");
		LOGGER.debug("Adding Customer");
		HttpSession session=request.getSession();

		if(session.getAttribute("useremail")!=null) {
		try {
			LOGGER.info("User Id Present");
			
		
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
			return "AddCustomer";
		}
		LOGGER.info("Response Created");
		return "AddCustomer";
	}
	
	else {

		LOGGER.error("User Id Expired");
	return "AdminLogin";
	}
			
	}
}

