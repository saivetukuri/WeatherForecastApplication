<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<br>
<div id="map" style="width: 50%;height:450px;margin: 0 auto;float: none;"></div>

	<script>
	var lat=sessionStorage.getItem("latitude");
	var lng=sessionStorage.getItem("longitude");
	var cityname=sessionStorage.getItem("cityname");
	if(cityname==null||cityname==""){
		cityname='${cityname}';
		sessionStorage.setItem('cityname',cityname);
		
	}
		initMapLog(lat,lng,sessionStorage.getItem("cityname"));
		console.log("satellite latitude: "+lat);
		console.log("satellite longitude: "+lng);
		console.log("cityname model:${cityname}")
		console.log("cityname:"+sessionStorage.getItem("cityname"));
		
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
		var alert='<b>Alert: </b>';
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
		   document.getElementById("pageid").href='/weather_forecast?lat='+lat+'&lng='+lng+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
		   document.getElementById("sat").href='/satellite??lat='+lat+'&lng='+lng+'&cityname='+sessionStorage.getItem("cityname");
		   document.getElementById("air").href='/airquality?lat='+lat+'&lng='+lng+'&cityname='+sessionStorage.getItem("cityname");
		   document.getElementById("hour").href='/hourly?lat='+lat+'&lng='+lng+'&cityname='+sessionStorage.getItem("cityname");
		   document.getElementById("daily").href='/weatherforecast?lat='+lat+'&lng='+lng+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
		   document.getElementById("month").href='/monthly?lat='+lat+'&lng='+lng+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
		   document.getElementById("history").href='/weatherhistory?lat='+lat+'&lng='+lng+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
		<%@ include file="alertsretrieve.jsp" %>
		<%@ include file="enablelink.jsp" %>
	</script>
	
</body>
</html>