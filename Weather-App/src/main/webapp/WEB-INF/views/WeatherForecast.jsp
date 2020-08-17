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

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src='https://kit.fontawesome.com/a076d05399.js'></script>
</head>


<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>
<%@ include file="Alerts.jsp" %>
<br>
<%@ include file="pagination.jsp" %>


<div id="map" style="width: 50%;height:450px;margin: 0 auto;float: none;"></div>

	<script>
	var lat="<%=session.getAttribute("latitude") %>";
	var lng="<%=session.getAttribute("longitude") %>";
		initMapLog(lat,lng,'${cityname}');
		
		

	</script>
	<br>
<div class="container">
<div class="card" style="width:65%;margin: 0 auto;float: none;">

		<div class="card-body">
		<div class="card-title">
			<h6 >
			${cityname},${country.get("country")}<br>
				<b>Current Weather</b>
			</h6>
			</div>
			<div class="card-subtitle">

			<p id="timenow">

					</p>
					
			 
			</div>
			<div class="container" style="display: flex;flex-wrap: wrap; align-items:center;">
			<div style="display:flex;flex-wrap: wrap;align-items:center;">
			<div >
			<img class="img-valign" id="iconnow"  src="" alt="Weather widget" >
			</div>
			<div >
			<p id="text2">
			<c:if test="${units=='metric'}">
			<sup>°</sup><b style="font-size:30px;">C</b>
			</c:if>
			<c:if test="${units=='imperial'}">
			<sup>°</sup><b style="font-size:30px;">F</b>
			</c:if>
			<c:if test="${units==''}">
			<sup></sup><b style="font-size:30px;">K</b>
			</c:if>
			</p>
<small style="font-size:15px;" >realfeel:<small id="feels_like"></small></small>
			</div>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div id="details" style="font-size:18px">
			
			</div>
			</div>
				<div  style="display:flex;justify-content: space-between;flex-wrap:wrap;align-items: center;">
		<div id="desc" style="margin-left:1%;">
			
		</div>
		<div style="margin-right:10%;padding:10px;">
		<a href="/currentdetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}" class="btn btn-secondary" style="font-size:13px">
More Details  &nbsp;<i class='fas fa-arrow-right'></i>
</a>
		</div>
		</div>
			</div>
		
		</div>
		<br>
	<div class="card" style="width:65%;margin: 0 auto;float: none;">
<div class="card-body text">
<div class="container" style="display:flex;justify-content: space-equally;flex-wrap:wrap;">

<div  id="aqivalue" class="col-6" style="display:flex;flex-wrap: wrap;">
Current Air Quality<br>

</div>

<div style="display:flex;flex-wrap: wrap;align-items:center;" class="col-6">
<div id="airdesc">
Air Quality:
</div>
<br>
<div style="margin-right:10%;padding:10px;">
<a href="/airquality?lat=${latitude}&lng=${longitude}&cityname=${cityname}" class="btn btn-secondary" style="font-size:13px">
More Details  &nbsp;<i class='fas fa-arrow-right'></i>
</a> 
</div>

</div>

</div>

<br>
</div>
</div>	
<br>


<div class="card" style="width:65%;margin: 0 auto;float: none;">
		<div class="card-body">
			<div class="card-title" style="display:flex;justify-content: space-between;flex-wrap:wrap;">
				<h4>Tonight</h4>
				<p style="float:right;font-size:15px" id="todaydate"></p>
			</div>
			
			<div class="container" style="display: flex;justify-content: space-evenly;flex-wrap: wrap; align-items:center;">
			<div style="display:flex;flex-wrap: wrap;align-items:center;">
			<div >
			<img class="img-valign" id="icontoday" src="" >
			</div>
			<div >
			<p class="text2" id="todaytemp">
			<c:if test="${units=='metric'}">
			<sup>°</sup><b style="font-size:30px;">C</b>
			</c:if>
			<c:if test="${units=='imperial'}">
			<sup>°</sup><b style="font-size:30px;">F</b>
			</c:if>
			<c:if test="${units==''}">
			<sup></sup><b style="font-size:30px;">K</b>
			</c:if>
			</p>
<small style="font-size:20px;" >realfeel:<small id="todayfeel_like"></small></small>
			</div>
			</div>
			
			
			
			<div id="todaydesc">

</div>
 			

			
			
					<div>
					
<a href="/currentdetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}">
<i style="color:black;" class='fas fa-arrow-right'></i>
</a>
 			

			
			</div>
	
			</div>
			
			</div>
			

		</div>
		<br>
		
		
		
		<div class="card" style="width:65%;margin: 0 auto;float: none;">
		<div class="card-body">
		<div class="card-title" style="display:flex;justify-content: space-between;flex-wrap:wrap;">
			<h4 >
				Tomorrow</h4>
				<p style="float:right;font-size:15px" id="tmwdate">${tmwdate}</p>
			
			</div>
			<div class="container" style="display: flex;justify-content: space-evenly;flex-wrap: wrap; align-items:center;">
			<div style="display:flex;flex-wrap: wrap;align-items:center;">
			<div>
			<img class="img-valign"  id="icontmw" src="" alt="Weather widget" >
			</div>
			<div >
			<p class="text2" id="tmwtemp">
			<c:if test="${units=='metric'}">
			<sup>°</sup><b style="font-size:30px;">C</b>
			</c:if>
			<c:if test="${units=='imperial'}">
			<sup>°</sup><b style="font-size:30px;">F</b>
			</c:if>
			<c:if test="${units==''}">
			<sup></sup><b style="font-size:30px;">K</b>
			</c:if>
			</p>
<small style="font-size:20px;" >realfeel:<small id="tmwfeel_like"></small></small>
			</div>
			</div>
			
			
			<div id="tmwdesc">
			

</div>
 			

			
			
					<div>
					
<a href="/tmwdetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}"  >
<i style="color:black;" class='fas fa-arrow-right'></i>
</a>
 			

			
			</div>
			</div>
			</div>
			

		</div>
</div>
		<%@ include file="Weatherretrieve1.jsp" %>
		
		<br>

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

  font-size: 64px;
}
.text2 {

  font-size: 64px;
}
.card_body{
display: flex;
    flex-grow: 1;
    margin-bottom: 16px;
}
hr { margin: 0.5em auto; }
</style>	


</body>

</html>