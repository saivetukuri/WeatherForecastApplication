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
</head>
<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>

<form action="weatheruserupdate" method="post" modelAttribute="userupdate">

    <div id="main" >
    <h1>Update Your Profile</h1>
    <div class="form-group">
            <div class="col-md-6 boxy">
                         
               Email:<input type="text" class="form-control" name="email" placeholder="Enter your First Name" value="<%=session.getAttribute("useremail") %>" disabled required>
        </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 boxy">
                        
                First Name:<input type="text" class="form-control" name="firstname" placeholder="Enter your First Name" value="${userr.get('pfirstname') }" required>
        </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 boxy">
                
                Last Name:<input type="text" class="form-control" name="lastname" placeholder="Enter your Last Name" value="${userr.get('plastname') }" required>
        </div>
        </div>
      
 		  <div class="form-group">
            <div class="col-md-6 boxy">
               
                Mobile:<input type="number" class="form-control" min=1000000000 max=9999999999 name="mobile" placeholder="Enter your Mobile Number" value="${userr.get('pmobile') }" required>
        </div>
        </div>
       
	  <div class="form-group">
            <div class="col-md-6 boxy">
               
                Country:<input type="text" class="form-control" name="country" placeholder="Enter your Country"  value="${userr.get('pcountry')}"required>
        </div>
        </div>
        </div>
        <br>
        <div id="b">
        <button type="submit" class="btn btn-primary">Update</button>
        </div>
    </form>
    
   
</body>
</html>