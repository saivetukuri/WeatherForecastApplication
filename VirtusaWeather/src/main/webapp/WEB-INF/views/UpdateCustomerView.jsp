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
<script>
function updatecustomer(email){
	if (confirm('Do you want Update?')) {
		  
		  console.log(email);
		  return true
		   
		} else {
		  
		  console.log('Go back');
		  
		  return false;
		}
}
</script>
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
<body style="background-color:#DCDCDC">
<%@ include file="AdminAfterLoginHead.jsp" %>
<c:if test="${userr.get('response')=='Success'}">

<form action="updateconfirm" method="post" modelAttribute="userupdate" >

    <div id="main" >
    <h1>Update Your Profile</h1>
    <div class="form-group">
            <div class="col-md-6 boxy">
                         
               Email:<input type="text" class="form-control" name="email" placeholder="Enter your First Name" value="${emailsearch}" disabled required>
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
        <button type="submit" class="btn btn-primary" onclick="return updatecustomer('${emailsearch}')">Update</button>
        <input type="button" class="btn btn-primary" name="cancel" value="Cancel" onClick="window.location.href='/updatecustomer';" />
        </div>
    </form>
   
</c:if>
<c:if test="${userr.get('response')!='Success'}">
<h1>No User Exists</h1>
</c:if>
</body>
</html>