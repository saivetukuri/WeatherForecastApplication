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
var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
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
else if(units=="metric"){
	degree='<sup>°</sup>'
	wind=' m/s';
}
else if(units=="imperial"){
	degree='<sup>°</sup>'
	wind=' km/hr';
}
for(var i=5;i>=0;i--){
console.log(JSON.parse(sessionStorage.getItem('history'+i)));
var date=new Date(JSON.parse(sessionStorage.getItem('history'+i)).current.dt*1000);
var hourdate=(date.getMonth()+1)+"/"+date.getDate();
var day=days[date.getDay()].substr(0,3);
console.log(hourdate);
console.log(day);
 document.getElementById("historyweather").innerHTML+='<div class="card" style="width:50%;margin: 0 auto;float: none;"><div style="display: flex;flex-wrap: wrap; align-items:center;">'+
 '<div style="text-align:left;"><b>'+hourdate+'<br>'+day+'</b></div>'+
 '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div><img src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('history'+i)).current.weather[0].icon+'.png" height="88px" width="88px"></div>'+
 '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div ><b style="font-size:35px">'+Math.round(JSON.parse(sessionStorage.getItem('history'+i)).current.temp)+degree+'</b></div>'+
 '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div><b>Humidity: </b>'+JSON.parse(sessionStorage.getItem('history'+i)).current.humidity+' %<br>'+
 '<b>Wind Speed: </b>'+JSON.parse(sessionStorage.getItem('history'+i)).current.wind_speed+wind+'<br></div>'+
 '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div style="max-width: 150px;"><b>'+JSON.parse(sessionStorage.getItem('history'+i)).current.weather[0].description+'</b></div>'+

'</div></div><br>';
}
<%@ include file="alertsretrieve.jsp" %>
<%@ include file="enablelink.jsp" %>
</script>
</body>
</html>