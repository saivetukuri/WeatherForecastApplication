<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
       <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ page import="org.json.*" %>
   <%@ page import="org.json.*" %>
   <%@page import="java.util.*" %>
   <%@page import="java.util.concurrent.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 
  <style>
.hourly {
  
  width: 100%;
  
  background-color: white;
  color: black;
  padding: 14px 28px;
  font-size: 14px;
  cursor: pointer;
  
}

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
</head>
<body style="background-color:#DCDCDC">
 <%@ include file="WeatherAfterLoginHead.jsp" %> 
 <%@ include file="Alerts.jsp" %>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<br>
<%@ include file="pagination.jsp" %>
<div class="container-fluid" style="width:40%;margin: 0 auto;float: none;background-color:#DCDCDC;">
<div class="card"  id="todayhourly" style="background-color:#DCDCDC">
</div>
<br>
<div>
 <a id="tmwhourlink" href="/tmwweatherhourly?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i=${j}"><button class="hourly" style="width:100%;background-color:#B0E0E6;"> Tomorrow</button></a>
</div>
</div>

<%@ include file="weatherhourlyretrieve.jsp" %>

</body>
</html>