<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
    password = form.newpassword.value; 
    password2 = form.newpassword2.value; 

   if (password != password2) { 
        alert ("\nPassword did not match: Please try again...") 
        return false; 
    } 

    // If same return True. 
    else{ 
        
        return true; 
    } 
} 
</script>
</head>
<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>
<form action="/updatepassword" method="post" modelAttribute="userpassword" onSubmit = "return checkPassword(this)">

    <div id="main" >
    <h1>Change Your Password</h1>
    <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="password">Enter Old Password</label>
                <input type="password" class="form-control" name="password" placeholder="Enter your Old Password" required>
          </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="newpassword1">Enter New Password</label>
                <input type="password" class="form-control" name="newpassword" placeholder="Enter your New Password" required>
          </div>
        </div>
 
 
        <div class="form-group">
            <div class="col-md-6 boxy">
                <label for="newpassword2">Confirm New Password</label>
                <input type="password" class="form-control" name="newpassword2" placeholder="Confirm New Password" required>
            </div>
        </div>
        </div>
        <br>
        <div id="b">
        <button type="submit" class="btn btn-primary">Change Password</button>
        </div>
    </form>

</body>
</html>