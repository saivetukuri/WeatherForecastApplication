<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>
<div class="card" style="width:50%;margin: 0 auto;float: none;">
<div class="card-header"><h1>My Profile</h1></div>
<div class="card-body">
Name: <%=session.getAttribute("firstname") %> <%=session.getAttribute("lastname") %><br>
Email: <%=session.getAttribute("useremail") %><br>
Mobile: <%=session.getAttribute("mobile") %><br>
Country:<%=session.getAttribute("country1")%><br>
</div>
</div>
</body>
</html>