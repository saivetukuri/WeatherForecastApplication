<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ page import="java.util.*" %>
        <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <jsp:useBean id="now" class="java.util.Date" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">

<link rel="SHORTCUT ICON" HREF="satellite/owm.ico">
	<link rel="stylesheet" type="text/css" href="satellite/example/leaflet/leaflet.css" />
	<link rel="stylesheet" type="text/css" href="satellite/leaflet-openweathermap.css" />
	<link rel="stylesheet" type="text/css" href="satellite/example/files/map.css" />
	<script src="satellite/example/leaflet/leaflet.js"></script>
	<script src="satellite/example/leaflet/Permalink.js"></script>
	<script src="satellite/example/leaflet/Permalink.Layer.js"></script>
	<script src="satellite/example/leaflet/Permalink.Overlay.js"></script>
	<script src="satellite/leaflet-openweathermap.js"></script>
	<link rel="stylesheet" type="text/css" href="satellite/example/leaflet/leaflet-languageselector.css" />
	<script src="satellite/example/leaflet/leaflet-languageselector.js"></script>
	<script src="satellite/example/files/map_i18n.js"></script>
	<script src="satellite/example/files/map.js"></script>
</head>
<body style="background-color:#DCDCDC">
<%@ include file="WeatherHead.jsp" %>
<br><br><br><br><br>



<script>
var today = new Date();
if(today.getHours()>=10){
	if(today.getMinutes()>=10){
var time = today.getHours() + ":" + today.getMinutes()
	}
	else{
		var time = today.getHours() + ":0" + today.getMinutes()
	}
}
else{
	if(today.getMinutes()>=10){
	var time = "0"+today.getHours() + ":" + today.getMinutes()
	}
	else{
		var time = "0"+today.getHours() + ":0" + today.getMinutes()	
	}
}
//document.getElementById("demo1").innerHTML = time;
</script>
<script>
document.getElementById("C").href='/weather_home1?lat=${latitude}&lng=${longitude}&cityname=${cityname}&units=metric';
document.getElementById("F").href='/weather_home1?lat=${latitude}&lng=${longitude}&cityname=${cityname}&units=imperial';
document.getElementById("K").href='/weather_home1?lat=${latitude}&lng=${longitude}&cityname=${cityname}&units=';
sessionStorage.setItem('units','${units}');
</script>

<c:if test="${not empty json}">
<c:if test="${json!='null'}">
<div id="map" style="width: 50%;height:450px;margin: 0 auto;float: none;"></div>

	<script>
	
		initMapHome('${latitude}','${longitude}','${cityname}');
		

	</script>

<br>

<div class="card" style="width:50%;margin: 0 auto;float: none;">

		<div class="card-body">
		<div class="card-title">
			<h6>${cityname},${country}</h6>
			<h6 class="card-title">
				Current Weather
			</h6>
			</div>
			<div class="card-subtitle">
			
				<fmt:formatDate var="time" value="${now}" pattern="HH:mm" />
					<p>${time}
					<fmt:parseNumber var="parsedNumber" type="number" value="${fn:substring(time,0,2)}" />
		<c:set var="hour" value="${parsedNumber}"/>
		
<c:if test="${hour >= 12}">
 <c:out value="pm"/>
</c:if>
<c:if test="${hour < 12}">
 <c:out value="am"/>
 </c:if>
					</p>
					
			</div>
			<div class="container" style="display: flex;flex-wrap: wrap; align-items:center;">
			<div style="display:flex;flex-wrap: wrap;align-items:center;">
			<div>
			<img class="img-valign"  src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/${json.get('current').get('weather').get(0).getString('icon')}.png" alt="Weather widget" >
			</div>
			<div >
			<p class="text2">${Math.round(json.get("current").getDouble("temp"))}
			<c:if test="${units=='metric'}">
			<sup>�</sup><b style="font-size:30px;">C</b>
			<c:set var="wind" value="m/s"/>
			</c:if>
			<c:if test="${units=='imperial'}">
			<sup>�</sup><b style="font-size:30px;">F</b>
			<c:set var="wind" value="km/hr"/>
			</c:if>
			<c:if test="${units==''}">
			<sup></sup><b style="font-size:30px;">K</b>
			<c:set var="wind" value="m/s"/>
			</c:if>
			</p>
<small style="font-size:15px;" >realfeel: <small>${Math.round(json.get("current").getDouble("feels_like"))}</small></small>
			</div>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div style="font-size:18px">
			<div>
			Humidity:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${json.get("current").get("humidity") } %
			</div>
			<hr>
			<div>
			Wind Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${json.get("current").get("wind_speed")} ${wind}
			</div>
			<hr>
<%-- 			AQI:${air.get("data").get("aqi")}
 --%>
 <div>			
 <c:if test="${!air.get('data').has('aqi')}">

</c:if>
<c:if test="${air.get('data').get('aqi')>=0&&air.get('data').get('aqi')<=50}">
Air Quality:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline; color:#009966;'>Good</p>
</c:if>
<c:if test="${air.get('data').get('aqi')>=51&&air.get('data').get('aqi')<=100}">
Air Quality:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:#ffc300;'>Moderate</p>

</c:if>
<c:if test="${air.get('data').get('aqi')>=101&&air.get('data').get('aqi')<=150}">
Air Quality:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:#ff9933;'>Unhealthy for Sensitive Groups</p>
</c:if>
<c:if test="${air.get('data').get('aqi')>=151&&air.get('data').get('aqi')<=200}">
Air Quality:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:#cc0033;'>Unhealthy</p>
</c:if>
<c:if test="${air.get('data').get('aqi')>=201 && air.get('data').get('aqi')<=300}">
Air Quality:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:#660099;'>Very Unhealthy</p>
</c:if>

<c:if test="${air.get('data').get('aqi')>=300}">
Air Quality:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:#7e0023;'>Hazardous</p>
</c:if>
	</div>		
			</div>
			</div>
			<div  style="display:flex;justify-content: space-between;flex-wrap:wrap;align-items: center;">
			<div class="card-subtitle" style="margin-left:1%;">
			
			<b>${json.get("current").get("weather").get(0).getString("description")}</b>
		</div>
			</div>
			
	<%-- 	<p class="card-subtitle">
			
			${json.get("current").get("weather").get(0).getString("description")}
		</p> --%>
		</div>
		</div>
		<br>
		<div class="card" style="width:50%;margin: 0 auto;float: none;">
<div class="card-header">
Current Air Quality
</div>
<div class="row">
<div class="col-6">
 <c:if test="${!air.get('data').has('aqi')}">

</c:if>
<c:if test="${air.get('data').has('aqi')}">
AQI:${air.get("data").get("aqi")}
</c:if>
<br>
</div>
<div class="col-6">
<c:if test="${!air.get('data').has('aqi')}">

</c:if>
<c:if test="${air.get('data').get('aqi')>=0&&air.get('data').get('aqi')<=50}">
Good<br>
<small>
Air quality is considered satisfactory, and air pollution poses little or no risk
</small>
</c:if>
<c:if test="${air.get('data').get('aqi')>51&&air.get('data').get('aqi')<=100}">
Moderate<br>
<small>
Air quality is acceptable; however, for some pollutants there may be a moderate health concern 
for a very small number of people who are unusually sensitive to air pollution.
</small>
</c:if>
<c:if test="${air.get('data').get('aqi')>101&&air.get('data').get('aqi')<=150}">
Unhealthy for Sensitive Groups<br>
<small>
Members of sensitive groups may experience health effects. The general public is not likely to be affected.
</small>
</c:if>
<c:if test="${air.get('data').get('aqi')>151&&air.get('data').get('aqi')<=200}">
Unhealthy<br>
<small>
Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects
</small>
</c:if>
<c:if test="${air.get('data').get('aqi')>201 && air.get('data').get('aqi')<=300}">
Very Unhealthy	<br>
<small>
Health warnings of emergency conditions. The entire population is more likely to be affected.
</small>
</c:if>

<c:if test="${air.get('data').get('aqi')>300}">
Hazardous<br>
<small>
Health alert: everyone may experience more serious health effects
</small>
</c:if>
</div>
</div>
</div>
<br>
		
</c:if>
<c:if test="${json=='null'}">
<h1 style="text-align: center;color:red;">No Details</h1>
</c:if>
</c:if>

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

.text2 {

  font-size: 64px;
}
.card_body{
display: flex;
    flex-grow: 1;
    margin-bottom: 16px;
}
</style>
<br><br>

</body>
</html>