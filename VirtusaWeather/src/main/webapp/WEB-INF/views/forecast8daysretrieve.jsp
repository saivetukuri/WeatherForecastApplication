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
var start = new Date().getTime();
var units='<%=session.getAttribute("units")%>';
console.log(units);
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
console.log(units);
var alert='<b>Alert:</b>';
var cyclone='';
var condition='';
var temp='';
var airalerts='';
var i;
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
  
  if(units==""){
		degree='<sup> </sup>'
		wind=' m/s';
	}
	else if(units=="metric"||units==null){
		degree='<sup>°</sup>'
		wind=' m/s';
	}
	else if(units=="imperial"){
		degree='<sup>°</sup>'
		wind=' km/hr';
	}
  var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
for(var i=0;i<JSON.parse(sessionStorage.getItem('forecast8days')).length;i++){
	var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i].dt*1000);
	var hourdate=(date.getMonth()+1)+"/"+date.getDate();
console.log(JSON.parse(sessionStorage.getItem('forecast8days'))[i]);
if("rain" in JSON.parse(sessionStorage.getItem('forecast8days'))[i] && "snow" in JSON.parse(sessionStorage.getItem('forecast8days'))[i]){
document.getElementById('forecastdata').innerHTML+=' <div class="card" style="width:50%;margin: 0 auto;float: none;background-color:#B0E0E6;"><div style="display: flex;flex-wrap: wrap; align-items:center;">'+
'<div style="text-align:left;"><b>'+days[date.getDay()].substr(0,3)+'<br>'+hourdate+'</b></div>'+
'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><img src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].icon+'.png" height="88px" width="88px"></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div><b style="font-size:35px">'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.max)+degree+"</b><p style='font-size:15px;display:inline;'> /"+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.min)+degree+'</p></div>&nbsp;&nbsp;&nbsp;'+
'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><b>Rain</b>: '+JSON.parse(sessionStorage.getItem('forecast8days'))[i].rain+' mm/day</div>'+
'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div style="max-width: 150px;">'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description+'</div>'+
'<a id="forecastlink'+i+ '"href="/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i='+i+'" class="stretched-link"></a></div></div><br>';
}
else if("rain" in JSON.parse(sessionStorage.getItem('forecast8days'))[i] && !("snow" in JSON.parse(sessionStorage.getItem('forecast8days'))[i]) )
	{
	document.getElementById('forecastdata').innerHTML+=' <div class="card" style="width:50%;margin: 0 auto;float: none;background-color:#B0E0E6;"><div style="display: flex;flex-wrap: wrap; align-items:center;">'+
	'<div style="text-align:left;"><b>'+days[date.getDay()].substr(0,3)+'<br>'+hourdate+'</b></div>'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><img src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].icon+'.png" height="88px" width="88px"></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div><b style="font-size:35px">'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.max)+degree+"</b><p style='font-size:15px;display:inline;'> /"+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.min)+degree+'</p></div>&nbsp;&nbsp;&nbsp;'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><b>Rain</b>: '+JSON.parse(sessionStorage.getItem('forecast8days'))[i].rain+' mm/day</div>'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div style="max-width: 150px;" >'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description+'</div>'+
	'<a id="forecastlink'+i+ '"href="/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i='+i+'" class="stretched-link"></a></div></div><br>';
	}
else if(!("rain" in JSON.parse(sessionStorage.getItem('forecast8days'))[i]) && ("snow" in JSON.parse(sessionStorage.getItem('forecast8days'))[i])){
	document.getElementById('forecastdata').innerHTML+=' <div class="card" style="width:50%;margin: 0 auto;float: none;background-color:#B0E0E6;"><div style="display: flex;flex-wrap: wrap; align-items:center;">'+
	'<div style="text-align:left;"><b>'+days[date.getDay()].substr(0,3)+'<br>'+hourdate+'</b></div>'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><img src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].icon+'.png" height="88px" width="88px"></div>&nbsp;&nbsp;&nbsp;'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div><b style="font-size:35px">'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.max)+degree+"</b><p style='font-size:15px;display:inline;'> /"+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.min)+degree+'</p></div>&nbsp;&nbsp;&nbsp;'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><b>Rain</b>: 0.0 mm/day</div>'+
	'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div style="max-width: 150px;">'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description+'</div>'+
	'<a id="forecastlink'+i+ '"href="/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i='+i+'" class="stretched-link"></a></div></div><br>';

}
else if(!("rain" in JSON.parse(sessionStorage.getItem('forecast8days'))[i]) && !("snow" in JSON.parse(sessionStorage.getItem('forecast8days'))[i]) )
{
document.getElementById('forecastdata').innerHTML+=' <div class="card" style="width:50%;margin: 0 auto;float: none;background-color:#B0E0E6;"><div style="display: flex;flex-wrap: wrap; align-items:center;">'+
'<div style="text-align:left;"><b>'+days[date.getDay()].substr(0,3)+'<br>'+hourdate+'</b></div>'+
'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><img src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].icon+'.png" height="88px" width="88px"></div>&nbsp;&nbsp;&nbsp;'+
'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div><b style="font-size:35px">'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.max)+degree+"</b><p style='font-size:15px;display:inline;'> /"+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.min)+degree+'</p></div>&nbsp;&nbsp;&nbsp;'+
'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><b>Rain</b>: 0.0 mm/day</div>'+
'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div style="max-width: 150px;">'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description+'</div>'+
'<a id="forecastlink'+i+ '"href="/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i='+i+'" class="stretched-link"></a></div></div><br>';
}
if(i==0){
	document.getElementById('forecastlink0').href='/currentdetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}';
}
else if(i==1){
	document.getElementById('forecastlink1').href='/tmwdetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}';

}

}
<%@ include file="alertsretrieve.jsp" %>
<%@ include file="enablelink.jsp" %>
</script>
</body>
</html>