<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<script>
var units='<%=session.getAttribute("units")%>';
if(units==null||units=="null"){
	  units=sessionStorage.getItem('units');
	  sessionStorage.setItem('units',units);
}
console.log("session units:"+units);
if(units==null||units=="null"){
	  units="metric";
	  sessionStorage.setItem('units',units);
}
if(sessionStorage.getItem("latitude")==null){
	 sessionStorage.setItem('latitude',17.3850);
	  sessionStorage.setItem('longitude',78.4867);
}
if(sessionStorage.getItem("longitude")==null){
	 sessionStorage.setItem('latitude',17.3850);
	  sessionStorage.setItem('longitude',78.4867);
}
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
var alert='<b>Alert:</b>';
var cyclone='';
var condition='';
var temp='';
var airalerts='';
var i;
var descriptionalerts=['thunderstorm with heavy rain','heavy thunderstorm',
	'ragged thunderstorm','thunderstorm with heavy drizzle','heavy intensity drizzle',
	'heavy intensity drizzle rain','shower rain and drizzle','heavy shower rain and drizzle',
	'heavy intensity rain','very heavy rain','extreme rain','freezing rain','heavy intensity shower rain',
	'ragged shower rain','Heavy snow','Sleet','Light shower sleet','Shower sleet','Rain and snow','Heavy shower snow',
	'volcanic ash','tornado','squalls'];
if(units==""){
	degree='<sup> </sup><b style="font-size:30px;">K</b>'
	wind=' m/s';
}
else if(units=="metric"){
	degree='<sup>°</sup><b style="font-size:15px;">C</b>'
	wind=' m/s';
}
else if(units=="imperial"){
	degree='<sup>°</sup><b style="font-size:15px;">F</b>'
	wind=' km/hr';
}
document.getElementById("pageid").href='/weather_forecast?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
document.getElementById("sat").href='/satellite??lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname");
document.getElementById("air").href='/airquality?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname");
document.getElementById("hour").href='/hourly?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname");
document.getElementById("daily").href='/weatherforecast?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
document.getElementById("month").href='/monthly?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
document.getElementById("history").href='/weatherhistory?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
for(var i=0;i<JSON.parse(sessionStorage.getItem('forecasthourly')).length;i++){
	var date=new Date(JSON.parse(sessionStorage.getItem('forecasthourly'))[i].dt*1000);
	var date1=new Date(Date.now());
	var todaydate=month[date1.getMonth()]+" "+("0"+date1.getDate()).substr(-2)+" "+date1.getUTCFullYear();
	var hourdate=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear();
	console.log(todaydate);
	console.log(hourdate);
	if(todaydate==hourdate){
	    var time=new Date(JSON.parse(sessionStorage.getItem('forecasthourly'))[i].dt*1000);
	    var hours = "0"+time.getHours();
	    //Minutes part from the timestamp
	    var minutes = "0" + time.getMinutes();
	    //Seconds part from the timestamp
	    var seconds = "0" + time.getSeconds();

	    //Will display time in 10:30:23 format
	    var formattedTime = hours.substr(-2) + ':' + minutes.substr(-2);
	    if(hours.substr(-2)>=12){
	    	formattedTime+=" pm";
	    }
	    else{
	    	formattedTime+=" am";
	    }
		console.log(formattedTime);
		console.log(i);
		console.log("insert");
		hourdate=(date.getMonth()+1)+"/"+date.getDate();
		document.getElementById("todayhourly").innerHTML+='<button type="button" class="hourly" data-toggle="collapse" data-target="#demo'+i+'"><div style="display: flex;flex-wrap: wrap; align-items:center;"><div style="text-align:left;"><b>'+formattedTime+
		'<br>'+hourdate+'</b></div><div><img  src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecasthourly'))[i].weather[0].icon+'.png" height="88px" width="88px">'+
		'</div>&nbsp;&nbsp;&nbsp;<div><b style="font-size:35px">'+Math.round(JSON.parse(sessionStorage.getItem('forecasthourly'))[i].temp)+degree+'</b></div>&nbsp;&nbsp;&nbsp;'
		+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><small style="font-size:12px">RealFeel:'+Math.round(JSON.parse(sessionStorage.getItem('forecasthourly'))[i].feels_like)+'</small></div>'+
		'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div >'+JSON.parse(sessionStorage.getItem('forecasthourly'))[i].weather[0].description+'</div>'
		+'</div></button>'+
		'<div id="demo'+i+'"class="collapse" style="background-color:#FFFFFF"><div class="row"><div class="col-6">'+
		'Wind:'+JSON.parse(sessionStorage.getItem('forecasthourly'))[i].wind_speed+" "+wind+'<hr>'+
		'Humidity:'+JSON.parse(sessionStorage.getItem('forecasthourly'))[i].humidity+'% <hr>'+
		'Indoor Humidity:'+JSON.parse(sessionStorage.getItem('forecasthourly'))[i].humidity+'% <hr>'+
		'</div>'+
		'<div class="col-6">'+
		'Dew Point:'+JSON.parse(sessionStorage.getItem('forecasthourly'))[i].dew_point+degree+'<hr>'+
		'Cloudiness:'+JSON.parse(sessionStorage.getItem('forecasthourly'))[i].clouds+'<hr>'+
		'Pressure:'+JSON.parse(sessionStorage.getItem('forecasthourly'))[i].pressure+'<hr>'+
		'</div></div></div><br>';
		
	}
	else{
		console.log("break at "+i);
		document.getElementById("tmwhourlink").href="/tmwweatherhourly?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i="+i;
		break;
	}
	
console.log(JSON.parse(sessionStorage.getItem('forecasthourly'))[i]);
}
<%@ include file="alertsretrieve.jsp" %>
<%@ include file="enablelink.jsp" %>
</script>
</body>
</html>