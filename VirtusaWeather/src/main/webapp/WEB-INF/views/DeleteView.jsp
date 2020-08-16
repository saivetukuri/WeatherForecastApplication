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
function deletecustomer(email){
	if (confirm('Do you want Delete?')) {
		  
		  console.log(email);
		  window.location.href = "/deleteconfirm?email="+email;
		   
		} else {
		  
		  console.log('Go back');
		  
		  return false;
		}
}
</script>
<body style="background-color:#DCDCDC">
<%@ include file="AdminAfterLoginHead.jsp" %>
<br>
<c:if test="${userr.get('response')=='Success'}">


<div class="card" style="width:50%;margin: 0 auto;float: none;">
<div class="card-header"><h1>${userr.get("pfirstname")} ${userr.get("plastname")}'s Profile</h1></div>
<div class="card-body">
Name:  ${userr.get("pfirstname")} ${userr.get("plastname")}<br>
Email: ${emailsearch}<br>
Mobile: ${userr.get("pmobile")}<br>
Country:${userr.get("pcountry")}<br>
</div>

</div>
<br>
<div style="width:50%;margin: 0 auto;float: none;">
<button class="btn btn-primary" onclick=" deletecustomer('${emailsearch}')">Delete Customer</button>&nbsp;<a href="/deletecustomer" ><button  class="btn btn-primary">Cancel</button></a>
</div>
</c:if>
<c:if test="${userr.get('response')!='Success'}">
<h1>No User Exists</h1>
</c:if>
</body>
</html>