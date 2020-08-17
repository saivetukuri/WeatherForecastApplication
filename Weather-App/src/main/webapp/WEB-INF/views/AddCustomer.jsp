<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
       <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
    #main{
        margin-left: 35%;
        
        
    }
    #b{
        margin-left: 47%;
    }
    #form{
    
    background-color:red;
    }

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
<%@ include file="AdminAfterLoginHead.jsp" %>
<br>
<c:if test="${not empty response}">
<c:if test="${response=='Success'}">
<h1 style="text-align: center;color:blue;">Registration Successful</h1>

</c:if>
<c:if test="${response!='Success'}">
<h1 style="text-align: center;color:red;">Registration Failed/User already exists</h1>
</c:if>
</c:if>

<h1 style="text-align: center;">Welcome to The Sign Up Page</h1>
    <br>
    <div class="container" >
    
    <form action="weatheradmincustomerreg" method="post" modelAttribute="user" onSubmit = "return checkPassword(this)">
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
        <div id="b">
        <button type="submit" class="btn btn-primary">Submit</button>
        </div>
    </form>
    </div>

</body>
</html>