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
</style>
<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>
<%@ include file="Alerts.jsp" %>
<br>
<%@ include file="pagination.jsp" %>
<div class="container" style="width:50%;">
<div class="container"  >

<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between" >
<div class="card" style="width:49%;">
CURRENT WEATHER
<br>
<div id="timenowdetails">


</div>
<br>
<div class="container" id="tempdetails" style="display: flex;flex-wrap: wrap; align-items:center;">
<div style="display:flex;flex-wrap: wrap;align-items:center;">
<div >
<img class="img-valign" id="iconnowdetails"src="">
</div>
<div >
			<p id="text2">
			
			</p>
<small style="font-size:15px;" >realfeel:<small id="feels_likedetails"></small></small>
			</div>
			</div>
			
			
			</div>
			<div id="descdetails" style="margin-left:1%;">
			
		</div>
		</div>
	<div class="card" style="width:49%;" id="nowmoredetails">
		
		</div>
		</div>
		<br>
		<div class="row">
<div class="col-12" >
<a href="/hourly?lat=${latitude}&lng=${longitude}&cityname=${cityname}"><button class="hourly" style="width:100%"> See Hourly ></button></a>
</div>
		</div>
		

<br>
<a href="/tmwdetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}"><button class="hourly" id="tmwdatebutton" style="width:100%">         ></button></a>
</div>
<br>
<div class="container"  >
<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;margin: 0 auto;float: none;">
<div id="nowdaydetails" class="card" style="width:49%;">





</div>

<div  class="card" style="width:49%; ">
<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between" >
<div>
SUNRISE/SUNSET<br>
<div id="nowsunrise">
Sunrise<br>

 
</div>
</div>
<div style="margin-right:15%">
<img src="images/sun.png" height="128px" width="128px">
</div>
</div>

<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between" >
<div id="nowsunset">
Sunset<br>

</div>
<div id="nowtimediff" style="margin-right:15%">
Duration<br>

</div>
</div>

</div>

</div>
</div>
<br>

<div class="container" >
<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between">
<div  class="card " id="nowmorningdetails" style="width:20%;">
<b>Morning:</b>

</div>
<div  class="card" id="nowafternoondetails" style="width:20%;">
<b>Afternoon:</b>

</div>
<div  class="card" id="noweveningdetails" style="width:20%;">

<b>Evening:</b>

</div>
<div  class="card" id="nownightdetails1" style="width:20%;">
<b>Night:</b>

</div>

</div>
</div>
<br>
<br>
<a href="weatherhistory?lat=${latitude}&lng=${longitude}&cityname=${cityname}&units=${units}"><button class="hourly" style="width:100%">Previous 5 Days Data</button></a>
</div>
<%@ include file="todaydetailsretrieve.jsp" %>
<style>
 .img-valign {
  vertical-align: middle;
  margin-bottom: 0.75em;
}
p { 
            display: block; 
            margin-bottom: 0em; 
        }
.text1 {
  font-size: 44px;
}

#text2 {

  font-size: 44px;
}
.text2 {

  font-size: 44px;
}
.card_body{
display: flex;
    flex-grow: 1;
    margin-bottom: 16px;
}

</style>	
</body>
</html>