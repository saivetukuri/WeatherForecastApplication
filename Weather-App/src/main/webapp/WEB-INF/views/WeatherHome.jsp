<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

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

</script>

  
<body style="background-color:#DCDCDC">
<%@ include file="WeatherHead.jsp" %>

<br><br><br><br><br>
<script>
var x = document.getElementById("demo");

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else { 
    x.innerHTML = "Geolocation is not supported by this browser.";
  }
}

async function showPosition(position) {
 
  var lat=position.coords.latitude;
  var lon=position.coords.longitude;
  var units=sessionStorage.getItem('units');
  console.log("units before: "+units)
  var degree;
  if(units==null){
	  units="metric";
	  sessionStorage.setItem('units',units);
  }
  if(lat==null){
	  lat=17.3850;
	  lon=78.4867;
	  sessionStorage.setItem('latitude',lat);
	  sessionStorage.setItem('longitude',lon);
  }
  if(lon==null){
	  lat=17.3850;
	  lon=78.4867;
	  sessionStorage.setItem('latitude',lat);
	  sessionStorage.setItem('longitude',lon);
  }
  console.log("units after:"+units);
  if(units==""){
		degree='<sup></sup><b style="font-size:30px;">K</b>'
		wind=' m/s';
	}
	else if(units=="metric"){
		degree='<sup>°</sup><b style="font-size:30px;">C</b>'
		wind=' m/s';
	}
	else if(units=="imperial"){
		degree='<sup>°</sup><b style="font-size:30px;">F</b>'
		wind=' km/hr';
	}
  console.log(lat,lon);
var ts = Math.round((new Date()).getTime() / 1000);
const place=await fetch(
		'http://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&appid=32a5443257de297a3b5b97d1ea462ed8&units='+units		 
		 );
		 
		 const dataplace=await place.json();
		 var combining = /[\u0300-\u036F]/g; 
		 document.getElementById("place").innerHTML = (dataplace.name).normalize('NFKD').replace(combining, '')+","+dataplace.sys.country;
		 initMapHome(lat,lon,(dataplace.name).normalize('NFKD').replace(combining, ''));
  const response=await fetch(
		  'https://api.openweathermap.org/data/2.5/onecall/timemachine?lat='+lat+'&lon='+lon+'&dt='+ts+'&appid=32a5443257de297a3b5b97d1ea462ed8&units='+units
				  );
  
  const data=await response.json(); 
  document.getElementById("icon").src='https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+data.current.weather[0].icon+'.png'

  document.getElementById("temp").innerHTML=Math.round(data.current.temp)+degree;

  document.getElementById("realfeel").innerHTML=Math.round(data.current.feels_like);
  console.log(data.current.humidity);
  document.getElementById("humidity").innerHTML="Humidity:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data.current.humidity+" %";
  console.log(data.current.wind_speed);
  document.getElementById("wind").innerHTML="Wind Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data.current.wind_speed+wind;
  
  document.getElementById("main").innerHTML='<b>'+data.current.weather[0].description+'</b>';
 const air=await fetch(
'https://api.waqi.info/feed/geo:'+lat+';'+lon+'/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520'		 
 );
 const dataair=await air.json();
 console.log(dataair.data.aqi);
 if(dataair.data.aqi=="undefined"){
	 document.getElementById("aqi").innerHTML="";
	 
 }
 else{
	
 document.getElementById("aqi").innerHTML="Air Quality:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
 if(dataair.data.aqi>=0&&dataair.data.aqi<=50){
	 document.getElementById("aqi").innerHTML+="<p style='display:inline;color:#00E39B;'>Good</p>";
	 document.getElementById("airdesc").innerHTML="Good<br><small>Air quality is considered satisfactory, and air pollution poses little or no risk</small>";
 }
 else if(dataair.data.aqi>=51&&dataair.data.aqi<=100){
	 document.getElementById("aqi").innerHTML+="<p style='display:inline;color:#ffc300;'> Moderate</p>";
	 document.getElementById("airdesc").innerHTML="Moderate<br><small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>";
 }
 else if(dataair.data.aqi>=101&&dataair.data.aqi<=150){
	 document.getElementById("aqi").innerHTML+="<p style='display:inline;color:#ff9933;'>Unhealthy for Sensitive Groups</p>";
	 document.getElementById("airdesc").innerHTML="Unhealthy for Sensitive Groups<br><small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>"
 }
 else if(dataair.data.aqi>=151&&dataair.data.aqi<=200){
	 document.getElementById("aqi").innerHTML+="<p style='display:inline;color:#cc0033;'>Unhealthy</p>";
	 document.getElementById("airdesc").innerHTML="Unhealthy<br><small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects</small>";
 }
 else if(dataair.data.aqi>=201&&dataair.data.aqi<=300){
	 document.getElementById("aqi").innerHTML+="<p style='display:inline;color:#660099;'>Very Unhealthy</p>";
	 document.getElementById("airdesc").innerHTML="Very Unhealthy<br><small>Health warnings of emergency conditions. The entire population is more likely to be affected.<small>";
 }
 else if(dataair.data.aqi>300){
	 document.getElementById("aqi").innerHTML+="<p style='display:inline;color:#7e0023;'>Hazardous</p>";
	 document.getElementById("airdesc").innerHTML="Hazardous<br><small>Health alert: everyone may experience more serious health effects</small>";
 }
 }
 
 if(dataair.data.aqi=="undefined"){
	 document.getElementById("aqidetail").innerHTML="";
 }
 else{
	 document.getElementById("aqidetail").innerHTML="AQI:"+dataair.data.aqi;
 }
 document.getElementById("C").href='/weather_home1?lat='+lat+'&lng='+lon+'&cityname=&units=metric';
 document.getElementById("F").href='/weather_home1?lat='+lat+'&lng='+lon+'&cityname=&units=imperial';
 document.getElementById("K").href='/weather_home1?lat='+lat+'&lng='+lon+'&cityname=&units=';
 
}

getLocation();
</script>

<c:if test="${not empty json}">
<c:if test="${json=='null'}">
<h1 style="text-align: center;color:red;">No Details</h1>
</c:if>
</c:if>
<br>
<div id="map" style="width: 700px;height:450px;margin: 0 auto;float: none;"></div><br>
<div class="card" style="width:50%;margin: 0 auto;float: none;">
<!-- <h3 id="place"></h3> -->
		<div class="card-body">
			<div class="card-title">
			<h4 id="place"></h4>
			<h6>
			
				<b>Current Weather</b>
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
			<div >
			<img class="img-valign" id="icon"  src="" alt="Weather widget" >
			</div>
			<div>
			<p class="text2" id="temp">
			
			</p>
<small style="font-size:15px;" >realfeel: <small id="realfeel"></small></small>
			</div>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div style="font-size:18px;" id="info">
			<div id="humidity">
			
			</div>
			<hr>
			<div id="wind">
			
			</div>
			<hr>
			<div id="aqi"></div>
			
			
 
			</div>
			</div>
			<div  style="display:flex;justify-content: space-between;flex-wrap:wrap;align-items: center;">
		<div  style="margin-left:1%;" id="main">

		</div>
		</div>
		 
		</div>
		
		
			
</div>
		<br>
<br>
		<div class="card" style="width:50%;margin: 0 auto;float: none;">
<div class="card-header">
Current Air Quality
</div>
<div class="row">
<div class="col-6" id="aqidetail">

<br>
</div>
<div class="col-6" id="airdesc">

</div>
</div>
</div>
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

.text2 {

  font-size: 64px;
}
.card_body{
display: flex;
    flex-grow: 1;
    margin-bottom: 16px;
}
</style>
 
  
 
 
  
 
</body>
</html>