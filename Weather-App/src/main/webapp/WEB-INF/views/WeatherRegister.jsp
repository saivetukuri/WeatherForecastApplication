<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
       <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>
<style>
    #main{
        margin-left: 35%;
        
        
    }
    #b{
        margin-left: 42%;
    }
    #form{
    
    background-color:red;
    }

</style>
<style type="text/css">
.navbar {
  overflow: hidden;
  background-color: #333;
  top: 0; /* Position the navbar at the top of the page */
  width: 100%; /* Full width */
  
 
}
.sticky {
  position: fixed;
  top: 0;
  width: 100%;
}
#card{
background: url('images/Weatherhome.jpg') no-repeat center;
background-size: cover;
	width: 100%;
	height: 100vh;
}
body {margin:0;}

</style>
<script>
function checkPassword(form) {
	var p;
	var e;
    password = form.password.value; 
    password2 = form.password2.value; 
	email= form.email.value;
   if (password != password2) { 
        alert ("\nPassword did not match: Please try again...")
        console.log(email);
        p=false;
        console.log(p);
        
    } 

    // If same return True. 
    else{ 
    	
    	// console.log(email);
    	p=true;
    	console.log(p);
         
    }
   var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
   if(email.match(mailformat))
   {
  e=true;
   console.log(email);
  console.log(e);
  
   }
   else
   {
   alert("You have entered an invalid email address!");
   e=false;
   console.log(e);
   }
   if((p && e)==true){
	   return true;
   }
   else{
	   return false;
   }
}


</script>
<body style="background-color:#DCDCDC">
<nav class="navbar navbar-expand-md navbar-dark bg-dark"  >

    <a href="weatherhome" class="navbar-brand">
        WEATHER APP
    </a>
    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav">
        <a href="weatherhome" class="nav-item nav-link">Home</a>
            <a href="weatherlog" class="nav-item nav-link">Login</a>
            <a href="weatherreg" class="nav-item nav-link">Register</a>
        </div>

    </div>
    
</nav>

<c:if test="${not empty response}">
<c:if test="${response=='Success'}">
<h1 style="text-align: center;color:blue;">Registration Successful</h1>
<c:set var = "response" scope = "session" value = "${null}"/>
</c:if>
<c:if test="${response!='Success'}">
<h1 style="text-align: center;color:red;">Registration Failed/User already exists</h1>
<c:set var = "response" scope = "session" value = "${null}"/>
</c:if>
</c:if>
    <h1 style="text-align: center;">Welcome to The Sign Up Page</h1>
    
    <div class="container" >
    
    <form action="weatherreg" method="post" modelAttribute="user" onSubmit = "return checkPassword(this)">
    <div id="main" >
        <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="firstname">First Name</label>            
                <input type="text" class="form-control" name="firstname" placeholder="Enter your First Name" required>
        </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="lastname">Last Name</label>
                <input type="text" class="form-control" name="lastname" placeholder="Enter your Last Name" required>
        </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="email">Email</label>
                <input type="email" class="form-control" name="email" placeholder="Enter your Email" required>
        </div>
        </div>
 		  <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="mobile">Mobile</label>
                <input type="number" class="form-control" min=1000000000 max=9999999999 name="mobile" placeholder="Enter your Mobile Number" required>
        </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="password">Enter Password</label>
                <input type="password" class="form-control" name="password" placeholder="Enter your Password" required>
          </div>
        </div>
 
 
        <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="password2">Confirm Password</label>
                <input type="password" class="form-control" name="password2" placeholder="Confirm Password" required>
            </div>
        </div>
	  <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="country">Country</label>
                <input type="text" class="form-control" name="country" placeholder="Enter your Country" required>
        </div>
        </div>
        </div>
        <br>
        <div id="b" >
        <button type="submit" class="btn btn-primary">Submit</button>
       
        <button type="reset" class="btn btn-primary">Reset</button>
        
        <input type="button" class="btn btn-primary" name="cancel" value="Cancel" onClick="window.location.href='/weatherhome';" />
        </div>
    </form>
    </div>

</body>
</html>