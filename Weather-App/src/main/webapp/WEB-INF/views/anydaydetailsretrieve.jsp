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
console.log("units first check:"+units);
if(units==null||units=="null"){
	  units="metric";
	  console.log("units updated:"+units);
	  sessionStorage.setItem('units',units);
}
console.log("latitude check:"+sessionStorage.getItem("latitude"));
console.log("longitude check:"+sessionStorage.getItem("longitude"));
if(sessionStorage.getItem("latitude")==null){
	 sessionStorage.setItem('latitude',17.3850);
	  sessionStorage.setItem('longitude',78.4867);
	  console.log("latitude updated:"+sessionStorage.getItem("latitude"));
	  console.log("longitude updated:"+sessionStorage.getItem("longitude"));
	  
}
if(sessionStorage.getItem("longitude")==null){
	 sessionStorage.setItem('latitude',17.3850);
	  sessionStorage.setItem('longitude',78.4867);
	  console.log("latitude updated:"+sessionStorage.getItem("latitude"));
	  console.log("longitude updated:"+sessionStorage.getItem("longitude"));
}
var i=<%=session.getAttribute("i")%>;
console.log("i check:"+i);
var alert='<b>Alert:</b>';
var cyclone='';
var condition='';
var temp='';
var airalerts='';

var month = new Array();
  month[0] = "January";
  month[i] = "February";
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
  document.getElementById("pageid").href='/weather_forecast?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
  document.getElementById("sat").href='/satellite??lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname");
  document.getElementById("air").href='/airquality?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname");
  document.getElementById("hour").href='/hourly?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname");
  document.getElementById("daily").href='/weatherforecast?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
  document.getElementById("month").href='/monthly?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
  document.getElementById("history").href='/weatherhistory?lat='+sessionStorage.getItem("latitude")+'&lng='+sessionStorage.getItem("longitude")+'&cityname='+sessionStorage.getItem("cityname")+'&units='+units;
  
  console.log("units condition:"+units)
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
  console.log("Any Day Weather Details session:"+JSON.parse(sessionStorage.getItem('forecast8days'))[i]);
if(units=='metric'){
   
    
	var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i].dt*1000);
	console.log(JSON.parse(sessionStorage.getItem('forecast8days'))[i]);
	document.getElementById('anydaydetails').innerHTML+=(date.getMonth()+1)+"/"+date.getDate()+'<br><div style="display:flex;flex-wrap: wrap;align-items:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
	'<div><img id="iconanydetails" src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].icon+'.png">'+
	'</div><div><p style="font-size:44px;margin-bottom: 0em;display:block;"><b>'+
	Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.max)+degree+'</b><small style="font-size:15px;">/'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.min)+degree+'</small></p>'+
	'</div></div>'+
	'<br>'+'<b>'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description+'</b>';
  
    document.getElementById('anymorningdetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
    Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.morn)+degree+
    '</b></p><small style="font-size:15px;" >realfeel: '+
    Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.morn)+degree+
    '</small></div>';
    document.getElementById('anyafternoondetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
    Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.day)+degree+
    '</b></p><small style="font-size:15px;" >realfeel: '+
    Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.day)+degree+
    '</small></div>';
    document.getElementById('anyeveningdetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
    Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve)+degree+
    '</b></p><small style="font-size:15px;" >realfeel: '+
    Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.eve)+degree+
    '</small></div>';
	document.getElementById('anynightdetails1').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
    Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.night)+degree+
    '</b></p><small style="font-size:15px;" >realfeel: '+
    Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.night)+degree+
    '</small></div>';
	
    }
    else if(units=='imperial'){
    	 
    	var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i].dt*1000);
    	console.log(JSON.parse(sessionStorage.getItem('forecast8days'))[i]);
    	document.getElementById('anydaydetails').innerHTML+=(date.getMonth()+1)+"/"+date.getDate()+'<br><div style="display:flex;flex-wrap: wrap;align-items:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
    	'<div><img id="iconanydetails" src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].icon+'.png">'+
    	'</div><div><p style="font-size:44px;margin-bottom: 0em;display:block;"><b>'+
    	Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.max)+degree+'</b><small style="font-size:15px;">/'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.min)+degree+'</small></p>'+
    	'</div></div>'+
    	'<br>'+'<b>'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description+'</b>';
     
        document.getElementById('anymorningdetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.morn)+degree+
        '</b></p><small style="font-size:15px;" >realfeel: '+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.morn)+degree+
        '</small></div>';
        document.getElementById('anyafternoondetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.day)+degree+
        '</b></p><small style="font-size:15px;" >realfeel: '+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.day)+degree+
        '</small></div>';
        document.getElementById('anyeveningdetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve)+degree+
        '</b></p><small style="font-size:15px;" >realfeel: '+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.eve)+degree+
        '</small></div>';
    	document.getElementById('anynightdetails1').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.night)+degree+
        '</b></p><small style="font-size:15px;" >realfeel: '+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.night)+degree+
        '</small></div>';
    		
    }
    else if(units==''){
    	var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i].dt*1000);
    	console.log(JSON.parse(sessionStorage.getItem('forecast8days'))[i]);
    	document.getElementById('anydaydetails').innerHTML+=(date.getMonth()+1)+"/"+date.getDate()+'<br><div style="display:flex;flex-wrap: wrap;align-items:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
    	'<div><img id="iconanydetails" src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].icon+'.png">'+
    	'</div><div><p style="font-size:44px;margin-bottom: 0em;display:block;"><b>'+
    	Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.max)+degree+'</b><small style="font-size:15px;">/'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.min)+degree+'</small></p>'+
    	'</div></div>'+
    	'<br>'+'<b>'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description+'</b>';
      
        document.getElementById('anymorningdetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.morn)+degree+
        '</b></p><small style="font-size:15px;" >realfeel: '+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.morn)+degree+
        '</small></div>';
        document.getElementById('anyafternoondetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.day)+degree+
        '</b></p><small style="font-size:15px;" >realfeel: '+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.day)+degree+
        '</small></div>';
        document.getElementById('anyeveningdetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve)+degree+
        '</b></p><small style="font-size:15px;" >realfeel: '+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.eve)+degree+
        '</small></div>';
    	document.getElementById('anynightdetails1').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.night)+degree+
        '</b></p><small style="font-size:15px;" >realfeel: '+
        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].feels_like.night)+degree+
        '</small></div>';
    		
    }
  console.log(JSON.parse(sessionStorage.getItem('forecast8days')));
	var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i].sunrise*1000);
  var hours = "0"+date.getHours();

  var minutes = "0" + date.getMinutes();

  var seconds = "0" + date.getSeconds();

  var formattedTime = hours.substr(-2) + ':' + minutes.substr(-2);
  if(hours.substr(-2)>=12){
  	formattedTime+=" pm";
  }
  else{
  	formattedTime+=" am";
  }
	document.getElementById('anysunrise').innerHTML+='<h3>'+formattedTime+'</h3>';
	var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i].sunset*1000);
  var hours = "0"+date.getHours();
  var minutes = "0" + date.getMinutes();
  var seconds = "0" + date.getSeconds();
  var formattedTime = hours.substr(-2) + ':' + minutes.substr(-2);
  if(hours.substr(-2)>=12){
  	formattedTime+=" pm";
  }
  else{
  	formattedTime+=" am";
  }
	document.getElementById('anysunset').innerHTML+='<h3>'+formattedTime+'</h3>';
	var ms=JSON.parse(sessionStorage.getItem('forecast8days'))[i].sunset*1000-JSON.parse(sessionStorage.getItem('forecast8days'))[i].sunrise*1000;
  var seconds = ms / 1000;
  var hours = parseInt( seconds / 3600 );
  seconds = seconds % 3600;
  var minutes = parseInt( seconds / 60 ); 
  hours+":"+minutes
	document.getElementById('anytimediff').innerHTML+='<h3>'+hours+":"+minutes+"hrs</h3>";
  console.log(i);
  console.log(i+1);
  console.log(i-1);
  if(i+1<=7 && i-1==1){
	  var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i-1].dt*1000);
  document.getElementById('prev').href='/tmwdetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}';
  document.getElementById('prev1').innerHTML=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear();
  
  var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i+1].dt*1000);
  document.getElementById('next').href='/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i=${i+1}';
  document.getElementById('next1').innerHTML=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear();
  }
  else if(i+1 <= 7 && i-1>1){
	  var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i-1].dt*1000);
	  document.getElementById('prev').href='/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i=${i-1}';
	  document.getElementById('prev1').innerHTML=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear();
	  
	  var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i+1].dt*1000);
	  document.getElementById('next').href='/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i=${i+1}';
	  document.getElementById('next1').innerHTML=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear(); 
  }
  else if(i+1 > 7){
	  var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i-1].dt*1000);
	  document.getElementById('prev').href='/anydaydetails?lat=${latitude}&lng=${longitude}&cityname=${cityname}&i=${i-1}';
	  document.getElementById('prev1').innerHTML=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear();
	  document.getElementById('next1').style.visibility = 'hidden';
	  document.getElementById('next').style.visibility = 'hidden';
  }
	var end = new Date().getTime();
	    console.log("time:"+(end - start));
	    document.getElementById('anymoredetails').innerHTML+='<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;"><div style="margin-left:10%"><b >Humidity:</b></div><div style="margin-right:10%" >'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].humidity+' %</div></div>'+
	    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between"><div style="margin-left:10%"><b >Dew Points:</b></div><div style="margin-right:10%">'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[i].dew_point)+degree+'</div></div>'+
	    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between"><div style="margin-left:10%"><b>Pressure:</b></div><div style="margin-right:10%">'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].pressure+' mbar</div></div>'+	    
	    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between"><div style="margin-left:10%"><b>UVI:</b></div><div style="margin-right:10%">'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].uvi+'</div></div>'+
	    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between"><div style="margin-left:10%"><b>Wind Speed:</b></div><div style="margin-right:10%">'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed+wind+'</div></div>';	
	    if("rain" in JSON.parse(sessionStorage.getItem('forecast8days'))[i]){
		    document.getElementById('anymoredetails').innerHTML+='<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between"><div style="margin-left:10%"><b>Rain:</b></div><div style="margin-right:10%">'+JSON.parse(sessionStorage.getItem('forecast8days'))[i].rain+'mm/day</div></div>';

	    }
	    <%@ include file="alertsretrieve.jsp" %>
	    <%@ include file="enablelink.jsp" %>
</script>
</body>
</html>