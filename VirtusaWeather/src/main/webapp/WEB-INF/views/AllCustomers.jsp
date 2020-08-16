<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
</script>
</head>
<body style="background-color:#DCDCDC">
<%@ include file="AdminAfterLoginHead.jsp" %>
<br>

<div class="container">
<h1 style="text-align:center">List of Customers</h1>
<div class="col-md-7 offset-md-4 mt-5 " style="width:50%;margin: 0 auto;float: none;">
<div class="input-group mb-4">
<input id="myInput" type="text" class="form-control" placeholder="Search..">
</div>
</div>

<table class="table table-bordered" style="background-color:white">
<thead>
<tr>
<th>First Name</th><th>Last Name</th><th>Email ID</th><th>Mobile</th><th>Country</th>
</tr>
</thead>
<tbody>
 <c:forEach var="i" begin="0" end="${user1.size()-1}">
<tbody id="myTable">
<tr>
<td>${user1.get(i).get("firstname")}</td>
<td>${user1.get(i).get("lastname")}</td>
<td>${user1.get(i).get("email")}</td>
<td>${user1.get(i).get("mobile")}</td>
<td>${user1.get(i).get("country")}</td>
</tr>
</tbody>
</c:forEach>
</table>
</div>
</body>
</html>