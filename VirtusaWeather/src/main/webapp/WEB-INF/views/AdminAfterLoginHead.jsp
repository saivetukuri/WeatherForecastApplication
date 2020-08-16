<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
</head>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Comfortaa');

*{
	margin: 0;
	padding: 0;
	outline: none;
	box-sizing: border-box;
	font-family: 'Comfortaa', cursive;
}
<style type="text/css">
.navbar {
  overflow: hidden;
  background-color: #333;
  top: 0; 
  width: 100%;
}
#card{
/*background: url('images/Weatherhome.jpg') no-repeat center;*/
background-size: cover;
	width: 100%;
	height: 100vh;

body {margin:0;}

</style>
<style>
  

.main {
    width: 50%;
    margin: 50px auto;
}



.has-search .form-control {
    padding-left: 2.375rem;
}

.has-search .form-control-feedback {
    position: absolute;
    z-index: 2;
    display: block;
    width: 2.375rem;
    height: 2.375rem;
    line-height: 2.375rem;
    text-align: center;
    pointer-events: none;
    color: #aaa;
}
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
  
}

.dropdown-content1 a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: none;
}
.dropdown-content1 {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
   right: -238px;
    
   padding: 0;
    margin: 0;
    top: 15px;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}
.dropdown {
  position: relative;
  display: inline-block;
}
.dropdown1 {
  position: relative;
  display: inline-block;
}
.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown1:hover .dropbtn {background-color: #3e8e41;}

.dropdown-content1 a:hover {background-color: #ddd;}

.dropdown1:hover .dropdown-content1 {display: block;}
  </style>
<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark"  >

    <a href="/weatheradminlogafterhome" class="navbar-brand">
        <img src="images/weathericon.jpg" height="28" alt="">WEATHER ADMIN
    </a>
    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav">
        <a href="/weatheradminlogafterhome" class="nav-item nav-link">Home</a>
            <a href="weatheradminlog" class="nav-item nav-link">Logout</a>
            <%-- <a href="#" class="nav-item nav-link">${userafterlogin.getFirstname()} ${userafterlogin.getLastname()}</a> --%>
            <div class="dropdown">
            <a class="nav-item nav-link" ><%=session.getAttribute("firstname") %>  <%=session.getAttribute("lastname") %></a>
            
             <div class="dropdown-content">
    		<a href="/viewadminprofile">View Admin Profile</a>
    		<a href="/adminpasswordchange">Change Admin Password</a>
    		<a href="/adminupdate">Update Admin Details</a>
    		<div class="dropdown1">
    		<a  >Manage Customers</a>
    		 <div class="dropdown-content1">
    		 <a href="/addnewcustomer">Add Customer Profile</a>
    		<a href="/deletecustomer">Delete Customer Profile</a>
    		<a href="/updatecustomer">Update Customer Profile</a>
    		 </div>
                 		</div>
    		<a href="/adminlistuser">List of Customers</a>
 			 </div>
        </div>

    </div>
 
  </div>
</nav>
</body>
</html>