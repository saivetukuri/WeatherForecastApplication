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
</head>

  
<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>
<%@ include file="Alerts.jsp" %>
<br>
<%@ include file="pagination.jsp" %>

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

</script>               
  <script>
var x = document.getElementById("demo");
var start = new Date().getTime();
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
  console.log("units:"+units);
if(units==""){
	degree='<sup></sup><b style="font-size:30px;">K</b>';
		wind=' m/s';
}
else if(units=="metric"){
	degree='<sup>°</sup><b style="font-size:30px;">C</b>';
		wind=' m/s';
}
else if(units=="imperial"){
	degree='<sup>°</sup><b style="font-size:30px;">F</b>';
		wind=' km/hr';
}
	var alert='<b>Alert:</b>';
	var cyclone='';
	var condition='';
	var temp='';
	var airalerts='';
	var i;
	  var unixnow=Math.floor(Date.now() / 1000);
	  var month = new Array();
	  month[0] = "January";
	  month[1] = "February";
	  month[2] = "March";
	  month[3] = "April";
	  month[4] = "May";
	  month[5] = "June";
	  month[6] = "July";
	  month[7] = "August";
	  month[8] = "September";
	  month[9] = "October";
	  month[10] = "November";
	  month[11] = "December";
	var descriptionalerts=['thunderstorm with heavy rain','heavy thunderstorm',
		'ragged thunderstorm','thunderstorm with heavy drizzle','heavy intensity drizzle',
		'heavy intensity drizzle rain','shower rain and drizzle','heavy shower rain and drizzle',
		'heavy intensity rain','very heavy rain','extreme rain','freezing rain','heavy intensity shower rain',
		'ragged shower rain','Heavy snow','Sleet','Light shower sleet','Shower sleet','Rain and snow','Heavy shower snow',
		'volcanic ash','tornado','squalls'];
  console.log(lat,lon);
  console.log("units:"+units);
  var ts = Math.round((new Date()).getTime() / 1000);
  const place=await fetch(
  		'http://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&appid=32a5443257de297a3b5b97d1ea462ed8&units='+units		 
  		 )
  		 
  		 const dataplace=await place.json();
  		 var combining = /[\u0300-\u036F]/g;
  		sessionStorage.setItem("latitude", lat);
  		sessionStorage.setItem("longitude", lon);
  		sessionStorage.setItem("cityname",(dataplace.name).normalize('NFKD').replace(combining, ''));
  		
  		
  		initMapLog(lat,lon,(dataplace.name).normalize('NFKD').replace(combining, ''));
  		 document.getElementById("place").innerHTML = (dataplace.name).normalize('NFKD').replace(combining, '')+","+dataplace.sys.country;
    const response=await fetch(
  		  'https://api.openweathermap.org/data/2.5/onecall/timemachine?lat='+lat+'&lon='+lon+'&dt='+ts+'&appid=32a5443257de297a3b5b97d1ea462ed8&units='+units
  				  );
    
    const data=await response.json();
    sessionStorage.setItem('currentnow',JSON.stringify(data));
    document.getElementById("icon").src='https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+data.current.weather[0].icon+'.png'

    document.getElementById("temp").innerHTML=Math.round(data.current.temp)+degree;

    document.getElementById("realfeel").innerHTML=data.current.feels_like;
    console.log(data.current.humidity);
    document.getElementById("humidity").innerHTML="Humidity:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data.current.humidity+" %";
    console.log(data.current.wind_speed);
    document.getElementById("wind").innerHTML="Wind Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data.current.wind_speed+wind;
    document.getElementById("main").innerHTML="<b>"+data.current.weather[0].description+"</b>";
    document.getElementById("tempmore").innerHTML="<a href="+"'/currentdetails?lat="+lat+"&lng="+lon+"&cityname="+(dataplace.name).normalize('NFKD').replace(combining, '')+"&units='"+units+" class='btn btn-secondary' style='font-size:13px'>More Details &nbsp;<i class='fas fa-arrow-right'></i>"
   const air=await fetch(
  'https://api.waqi.info/feed/geo:'+lat+';'+lon+'/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520'		 
   );
   const dataair=await air.json();
   sessionStorage.setItem('airquality',JSON.stringify(dataair));
   console.log(dataair.data.aqi);
   if(dataair.data.aqi=="undefined"){
  	 document.getElementById("aqi").innerHTML="";
  	 
   }
   else{
  	
   document.getElementById("aqi").innerHTML="Air Quality:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
   if(dataair.data.aqi>=0&&dataair.data.aqi<=50){
  	 document.getElementById("aqi").innerHTML+="Good";
  	 document.getElementById("airdesc").innerHTML="Good<br><small>Air quality is considered satisfactory, and air pollution poses little or no risk</small><br>";
  	document.getElementById("airdesc").innerHTML+="<a href="+"'/airquality?lat="+lat+"&lng="+lon+"&cityname="+(dataplace.name).normalize('NFKD').replace(combining, '')+"' class='btn btn-secondary'style='font-size:13px'>More Details  &nbsp;<i class='fas fa-arrow-right'></i>"
   }
   else if(dataair.data.aqi>=51&&dataair.data.aqi<=100){
  	 document.getElementById("aqi").innerHTML+="Moderate";
  	 document.getElementById("airdesc").innerHTML="Moderate<br><small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small><br>";
  	document.getElementById("airdesc").innerHTML+="<a href="+"'/airquality?lat="+lat+"&lng="+lon+"&cityname="+(dataplace.name).normalize('NFKD').replace(combining, '')+"' class='btn btn-secondary'style='font-size:13px'>More Details  &nbsp;<i class='fas fa-arrow-right'></i>"
   }
   else if(dataair.data.aqi>=101&&dataair.data.aqi<=150){
  	 document.getElementById("aqi").innerHTML+="Unhealthy for Sensitive Groups";
  	 document.getElementById("airdesc").innerHTML="Unhealthy for Sensitive Groups<br><small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small><br>"
  		document.getElementById("airdesc").innerHTML+="<a href="+"'/airquality?lat="+lat+"&lng="+lon+"&cityname="+(dataplace.name).normalize('NFKD').replace(combining, '')+"' class='btn btn-secondary'style='font-size:13px'>More Details  &nbsp;<i class='fas fa-arrow-right'></i>"
   }
   else if(dataair.data.aqi>=151&&dataair.data.aqi<=200){
  	 document.getElementById("aqi").innerHTML+="Unhealthy";
  	 document.getElementById("airdesc").innerHTML="Unhealthy<br>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects<br>";
  	document.getElementById("airdesc").innerHTML+="<a href="+"'/airquality?lat="+lat+"&lng="+lon+"&cityname="+(dataplace.name).normalize('NFKD').replace(combining, '')+"' class='btn btn-secondary'style='font-size:13px'>More Details  &nbsp;<i class='fas fa-arrow-right'></i>"
   }
   else if(dataair.data.aqi>=201&&dataair.data.aqi<=300){
  	 document.getElementById("aqi").innerHTML+="Very Unhealthy";
  	 document.getElementById("airdesc").innerHTML="Very Unhealthy<br><small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small><br>";
  	document.getElementById("airdesc").innerHTML+="<a href="+"'/airquality?lat="+lat+"&lng="+lon+"&cityname="+(dataplace.name).normalize('NFKD').replace(combining, '')+"' class='btn btn-secondary'style='font-size:13px'>More Details  &nbsp;<i class='fas fa-arrow-right'></i>"
   }
   else if(dataair.data.aqi>300){
  	 document.getElementById("aqi").innerHTML+="Hazardous";
  	 document.getElementById("airdesc").innerHTML="Hazardous<br><small>Health alert: everyone may experience more serious health effects</small><br>";
  	document.getElementById("airdesc").innerHTML+="<a href="+"'/airquality?lat="+lat+"&lng="+lon+"&cityname="+(dataplace.name).normalize('NFKD').replace(combining, '')+"' class='btn btn-secondary'style='font-size:13px'>More Details  &nbsp;<i class='fas fa-arrow-right'></i>"
   }
   }
   
   if(dataair.data.aqi=="undefined"){
  	 document.getElementById("aqidetail").innerHTML="";
   }
   else{
  	 document.getElementById("aqidetail").innerHTML="AQI:"+dataair.data.aqi;
   }
   document.getElementById("C").href='/weather_forecast?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '')+'&units=metric';
   document.getElementById("F").href='/weather_forecast?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '')+'&units=imperial';
   document.getElementById("K").href='/weather_forecast?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '')+'&units=';
   document.getElementById("pageid").href='/weather_forecast?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '')+'&units='+units;
   document.getElementById("sat").href='/satellite??lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '');
   document.getElementById("air").href='/airquality?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '');
   document.getElementById("hour").href='/hourly?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '');
   document.getElementById("daily").href='/weatherforecast?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '')+'&units='+units;
   document.getElementById("month").href='/monthly?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '')+'&units='+units;
   document.getElementById("history").href='/weatherhistory?lat='+lat+'&lng='+lon+'&cityname='+(dataplace.name).normalize('NFKD').replace(combining, '')+'&units='+units;


   
   $.ajax({
   	url:'https://api.openweathermap.org/data/2.5/onecall?lat='+sessionStorage.getItem("latitude")+'&lon='+sessionStorage.getItem("longitude")+'&appid=32a5443257de297a3b5b97d1ea462ed8&units='+units,
   	type:"GET",
   	datatype:"jsonp",
   	success: function(data1){
   		//console.log(data);
   		console.log("forecast");
   		console.log(units);
   		sessionStorage.setItem('forecast',JSON.stringify(data1));
   		sessionStorage.setItem('forecast8days',JSON.stringify(data1.daily));
   		sessionStorage.setItem('forecasthourly',JSON.stringify(data1.hourly));
   		console.log(JSON.parse(sessionStorage.getItem('forecast8days')));
   		
   	
   		var end = new Date().getTime();
		    console.log("forecasttime:"+(end - start));
		    
		    
//Alerts-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		   <%@ include file="alertsretrieve.jsp" %>
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		    
		   for(i=5;i>=0;i--){ 
			  
				$.ajax({
					
						  
						ajaxI:i,
				    	url:'https://api.openweathermap.org/data/2.5/onecall/timemachine?lat='+sessionStorage.getItem("latitude")+"&lon="+sessionStorage.getItem("longitude")+"&dt="+(unixnow-(i*86400))+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units,
				    	
				    			type:"GET",
				    	datatype:"jsonp",
				    	success: function(data){
				    		i=this.ajaxI;
				    		console.log("history");
				    		console.log(unixnow-(i*86400));
				    		sessionStorage.setItem('history'+i,JSON.stringify(data));
				    		console.log(i);
				    		console.log(new Date(JSON.parse(sessionStorage.getItem('history'+i)).current.dt*1000));
				    		console.log(JSON.parse(sessionStorage.getItem('history'+i)));
				    		var end = new Date().getTime();
				 		    console.log("historytime:"+(end - start));
				 		  
				    	}
					  
				    });
				  }
		  
   	}
   });
   <%@ include file="enablelink.jsp" %>
}

getLocation();
</script>
<div id="map" style="width: 700px;height:450px;margin: 0 auto;float: none;"></div>
<br>
<div class="container">
<div class="card" style="width:65%;margin: 0 auto;float: none;">
<!-- <h3 id="place"></h3> -->
		<div class="card-body">
			<div class="card-title">
			<h6 id="place"></h6>
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
<small style="font-size:15px;" >realfeel:<small id="realfeel"></small></small>
			</div>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div style="font-size:18px" id="info">
			<p id="humidity">
			
			</p>
			<hr>
			<p id="wind">
			
			</p>
			<hr>
			<p id="aqi"></p>
			
			
 
			</div>
			</div>
		<div  style="display:flex;justify-content: space-between;flex-wrap:wrap;align-items: center;">
		<div  style="margin-left:1%;" id="main">

		</div>
		<div id="tempmore" style="margin-right:10%;padding:10px;"></div>
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
</body>
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
	

</html>