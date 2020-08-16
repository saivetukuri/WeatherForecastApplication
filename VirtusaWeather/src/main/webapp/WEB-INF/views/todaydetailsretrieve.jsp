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
$( document ).ready(function() {
	var start = new Date().getTime();
	var units='<%=session.getAttribute("units")%>';
	if(units==null||units=="null"){
		  units="metric";
		  sessionStorage.setItem('units',units);
	}
	if(sessionStorage.getItem("latitude")==null || sessionStorage.getItem("longitude")==null){
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
	  var descriptionalerts=['thunderstorm with heavy rain','heavy thunderstorm',
			'ragged thunderstorm','thunderstorm with heavy drizzle','heavy intensity drizzle',
			'heavy intensity drizzle rain','shower rain and drizzle','heavy shower rain and drizzle',
			'heavy intensity rain','very heavy rain','extreme rain','freezing rain','heavy intensity shower rain',
			'ragged shower rain','Heavy snow','Sleet','Light shower sleet','Shower sleet','Rain and snow','Heavy shower snow',
			'volcanic ash','tornado','squalls'];
	  if(units==""){
			degree='<sup> </sup><b style="font-size:30px;">K</b>'
			d1='<sup> </sup><b style="font-size:13px;">K</b>'
			wind=' m/s';
		}
		else if(units=="metric"){
			degree='<sup>°</sup><b style="font-size:30px;">C</b>'
			d1='<sup>°</sup><b style="font-size:13px;">C</b>'
			wind=' m/s';
		}
		else if(units=="imperial"){
			degree='<sup>°</sup><b style="font-size:30px;">F</b>'
			d1='<sup>°</sup><b style="font-size:13px;">F</b>'
			wind=' km/hr';
		}
	$.ajax({
    	url:'https://api.openweathermap.org/data/2.5/onecall/timemachine?lat='+sessionStorage.getItem("latitude")+"&lon="+sessionStorage.getItem("longitude")+"&dt="+Math.floor(Date.now() / 1000)+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units,
    	type:"GET",
    	datatype:"jsonp",
    	success: function(data){
    		
    		console.log("current");
    		sessionStorage.setItem('currentnow',JSON.stringify(data));
    		
    		    var date=new Date(JSON.parse(sessionStorage.getItem('currentnow')).current.dt*1000);
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
    		   
    		    document.getElementById('timenowdetails').innerHTML=formattedTime;
    		    document.getElementById("iconnowdetails").src='https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('currentnow')).current.weather[0].icon+'.png'
    		    console.log(JSON.parse(sessionStorage.getItem('currentnow')).current.weather[0].icon);
    		    console.log(JSON.parse(sessionStorage.getItem('currentnow')).current.temp);
    		    console.log(JSON.parse(sessionStorage.getItem('currentnow')).current);
    		    if(units=='metric'){
    		    document.getElementById('text2').innerHTML=Math.round(JSON.parse(sessionStorage.getItem('currentnow')).current.temp)+'<sup>°</sup><b style="font-size:30px;">C</b>';
    		    }
    		    else if(units=='imperial'){
    		    	document.getElementById('text2').innerHTML=Math.round(JSON.parse(sessionStorage.getItem('currentnow')).current.temp)+'<sup>°</sup><b style="font-size:30px;">F</b>';
    		    }
    		    else if(units==''){
    		    	document.getElementById('text2').innerHTML=Math.round(JSON.parse(sessionStorage.getItem('currentnow')).current.temp)+'<sup></sup><b style="font-size:30px;">K</b>';
    		    }
    		    document.getElementById('feels_likedetails').innerHTML=Math.round(JSON.parse(sessionStorage.getItem('currentnow')).current.feels_like);
    		    document.getElementById('descdetails').innerHTML=JSON.parse(sessionStorage.getItem('currentnow')).current.weather[0].description;
    		    document.getElementById('nowmoredetails').innerHTML='<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;"><div>UV Index:'+JSON.parse(sessionStorage.getItem('currentnow')).current.uvi+'</div></div>'+
    		    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;"><div>Wind: '+JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed+wind+'</div></div>'+
    		    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;"><div>Humidity: '+JSON.parse(sessionStorage.getItem('currentnow')).current.humidity+' %</div></div>'+
    		    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;"><div>Dew Points: '+JSON.parse(sessionStorage.getItem('currentnow')).current.dew_point+d1+'</div></div>'+
    		    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;"><div>Pressure: '+JSON.parse(sessionStorage.getItem('currentnow')).current.pressure+' mbar</div></div>'+
    		    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;"><div>Cloud Cover: '+JSON.parse(sessionStorage.getItem('currentnow')).current.clouds+'</div></div>'+
    		    '<div style="display:flex;flex-wrap: wrap;align-items:center;justify-content:space-between;"><div>Visibility: '+JSON.parse(sessionStorage.getItem('currentnow')).current.visibility+' m</div></div>';
    		    
    		    var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[1].dt*1000);
	    		document.getElementById('tmwdatebutton').innerHTML=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+' >';
	    		var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[0].dt*1000);
	    		console.log(JSON.parse(sessionStorage.getItem('forecast8days'))[0]);
	    		document.getElementById('nowdaydetails').innerHTML+=(date.getMonth()+1)+"/"+date.getDate()+'<br><div style="display:flex;flex-wrap: wrap;align-items:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
	        	'<div><img id="iconnowdetails" src="https://openweathermap.org/themes/openweathermap/assets/vendor/owm/img/widgets/'+JSON.parse(sessionStorage.getItem('forecast8days'))[0].weather[0].icon+'.png">'+
	        	'</div><div><p style="font-size:44px;margin-bottom: 0em;display:block;"><b>'+
	        	Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].temp.max)+degree+'</b><small style="font-size:15px;">/'+Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].temp.min)+d1+'</small></p>'+
	        	'</div></div>'+
	        	'<br>'+'<b>'+JSON.parse(sessionStorage.getItem('forecast8days'))[0].weather[0].description+'</b>';
	    			
	    		
    		    document.getElementById('nowmorningdetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
    	        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].temp.morn)+degree+
    	        '</b></p><small style="font-size:15px;" >realfeel: '+
    	        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].feels_like.morn)+d1+
    	        '</small></div>';
    	        document.getElementById('nowafternoondetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
    	        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].temp.day)+degree+
    	        '</b></p><small style="font-size:15px;" >realfeel: '+
    	        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].feels_like.day)+d1+
    	        '</small></div>';
    	        document.getElementById('noweveningdetails').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
    	        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].temp.eve)+degree+
    	        '</b></p><small style="font-size:15px;" >realfeel: '+
    	        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].feels_like.eve)+d1+
    	        '</small></div>';document.getElementById('nownightdetails1').innerHTML+='<div ><p style="font-size:44px;margin-bottom: 0em;"><b>'+
    	        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].temp.night)+degree+
    	        '</b></p><small style="font-size:15px;" >realfeel: '+
    	        Math.round(JSON.parse(sessionStorage.getItem('forecast8days'))[0].feels_like.night)+d1+
    	        '</small></div>';
    	        
	    		console.log(JSON.parse(sessionStorage.getItem('forecast8days')));
	    		var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[0].sunrise*1000);
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
	    		document.getElementById('nowsunrise').innerHTML+='<h3>'+formattedTime+'</h3>';
	    		var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[0].sunset*1000);
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
	    		document.getElementById('nowsunset').innerHTML+='<h3>'+formattedTime+'</h3>';
	    		var ms=JSON.parse(sessionStorage.getItem('forecast8days'))[0].sunset*1000-JSON.parse(sessionStorage.getItem('forecast8days'))[0].sunrise*1000;
	    	    
	    	    var seconds = ms / 1000;
	    	    
	    	    var hours = parseInt( seconds / 3600 );
	    	    seconds = seconds % 3600; 
	    	    var minutes = parseInt( seconds / 60 ); 
	    	    hours+":"+minutes
	    		document.getElementById('nowtimediff').innerHTML+='<h3>'+hours+":"+minutes+"hrs</h3>";
	    		var end = new Date().getTime();
		 		    console.log("time:"+(end - start));
    	}
	
});
	<%@ include file="alertsretrieve.jsp" %>
    <%@ include file="enablelink.jsp" %>

});
</script>
</body>
</html>