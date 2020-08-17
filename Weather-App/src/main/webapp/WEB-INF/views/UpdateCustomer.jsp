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
function show(){
	var x = document.getElementById("email").value;
	alert(x);
}
function ValidateEmail(inputText)
{
var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
if(inputText.value.match(mailformat))
{
document.form1.email.focus();
console.log(document.form1.email.value);
window.location.href = "/viewupdatedetails?email="+document.form1.email.value;
return true;
}
else
{
alert("You have entered an invalid email address!");

return false;
}
}
</script>

<style>
.input-group-append{
cursor: pointer;
}

</style>
<body style="background-color:#DCDCDC">
<%@ include file="AdminAfterLoginHead.jsp" %>

<div class="col-lg-12 text-center mt-5">
  <h1>Update Customer</h1>
</div>

<div class="col-md-7 offset-md-4 mt-5 " style="width:50%;margin: 0 auto;float: none;">
<form name="form1" action="viewupdatedetails" method="post" modelAttribute="customersearch">
<div class="input-group mb-4">
  <input type="email" class="form-control" placeholder="Enter customer Email id" id="email" name="email">
  <div class="input-group-append">
    <span class="input-group-text" onclick="ValidateEmail(document.form1.email)"><i class="fa fa-search"></i></span>
  </div>
  </div>
  </form>
</div>

<c:if test="${not empty response}">
<c:if test="${response=='Success'}">
<h1>Updated Sucessfully</h1>

</c:if>
<c:if test="${response!='Success'}">
<h1>Updated Again</h1>
</c:if>
</c:if>
</body>
</html>