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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<style>
.hourly {
  
  width: 100%;
  
  background-color: white;
  color: blue;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
  text-align: center;
}
p { 
            display: block; 
            margin-bottom: 0em; 
        
</style>
<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>
<%@ include file="Alerts.jsp" %>
<br>
<%@ include file="pagination.jsp" %>
<div class="container" style="width:50%;">
<div class="container"  >
<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;margin: 0 auto;float: none;">
<div id="tmwdaydetails" class="card" style="width:49%;">

</div>

<div  class="card" style="width:49%; ">
<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between" >
<div>
SUNRISE/SUNSET<br>
<div id="tmwsunrise">
Sunrise<br>

 
</div>
</div>
<div style="margin-right:15%">
<img src="images/sun.png" height="128px" width="128px">
</div>
</div>

<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between" >
<div id="tmwsunset">
Sunset<br>

</div>
<div id="tmwtimediff" style="margin-right:15%">
Duration<br>

</div>
</div>

</div>

</div>
</div>
<br>


<div class="container" >
<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between">
<div  class="card " id="tmwmorningdetails" style="width:20%;">
<b>Morning:</b>

</div>
<div  class="card" id="tmwafternoondetails" style="width:20%;">
<b>Afternoon:</b>

</div>
<div  class="card" id="tmweveningdetails" style="width:20%;">

<b>Evening:</b>

</div>
<div  class="card" id="tmwnightdetails1" style="width:20%;">
<b>Night:</b>

</div>

</div>
</div>
<br>
<div class="container" >
<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between">
<div  class="card border-dark mb-3" id="tmwmoredetails" style="width:40%;margin: 0 auto;float: none; border:1;">

</div>
</div>
</div>
<br>
<a href="/hourly?lat=${latitude}&lng=${longitude}&cityname=${cityname}"><button class="hourly" style="width:%">Hourly</button></a>
<br>
<br><a href="/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i=2"><button class="hourly" style="width:100%"> next   ></button></a><br>
</div>
<%@ include file="tmwdetailsretrieve.jsp" %>
</body>
</html>