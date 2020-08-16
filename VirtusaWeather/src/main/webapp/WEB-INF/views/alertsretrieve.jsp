
	var date=new Date(JSON.parse(sessionStorage.getItem('currentnow')).current.dt*1000);
    		 		   var hourdate=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear();
    		 		   var descriptiontempalert=JSON.parse(sessionStorage.getItem('currentnow')).current.weather[0].description;
    		 		   // Weather Condition
    		 		   console.log("Current Alerts");
    		 		   console.log(descriptiontempalert);
    		 		   console.log("units:"+units);
    		 		   if(descriptionalerts.includes(descriptiontempalert)){
    		 		   console.log("Current detected");
    		 		   	condition+=hourdate+":"+JSON.parse(sessionStorage.getItem('currentnow')).current.weather[0].description+";&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    		 		   }
    		 		   // Cyclone
    		 		   if(units=='metric' || units==''){
    		 		   	console.log('standard');
    		 		   if(JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed>=17 && JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed<=24)
    		 		   {
    		 		   	cyclone+=hourdate+":"+"Cyclonic Storm;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    		 		   }
    		 		   else if(JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed>24 && JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed<=32)
    		 		   {
    		 		   	cyclone+=hourdate+":"+"Severe Cyclonic storm;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    		 		   }
    		 		   else if(JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed>32 && JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed<=61)
    		 		   {
    		 		   	cyclone+=hourdate+":"+"very Severe Cyclonic storm;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    		 		   	}
    		 		   else if(JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed>61){
    		 		   	cyclone+=hourdate+":"+"Super Cyclone; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		";
    		 		   }
    		 		   }
    		 		   else if(units=='imperial'){
    		 		   	console.log('imperial');
    		 		   	if(JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed>=39 && JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed<=54)
    		 		   	{
    		 		   		cyclone+=hourdate+":"+"Cyclonic Storm; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed>54 && JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed<=72)
    		 		   	{
    		 		   		cyclone+=hourdate+":"+"Severe Cyclonic storm;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed>72 && JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed<=136)
    		 		   {
    		 		   		cyclone+=hourdate+":"+"very Severe Cyclonic storm; 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    		 		   		}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.wind_speed>136){
    		 		   		cyclone+=hourdate+":"+"Super Cyclone; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    		 		   	}
    		 		   }

    		 		   // Temperature
    		 		   if(units=='metric'){
    		 		   	if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=40 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=44){
    		 		   		temp+=hourdate+":"+"Hot("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 	";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>44 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=46){
    		 		   		temp+=hourdate+":"+"Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>46 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=53){
    		 		   		temp+=hourdate+":"+"Severe Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>53){
    		 		   		temp+=hourdate+":"+"Extreme Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=6 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=10){
    		 		   		temp+=hourdate+":"+"Cold("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=4 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<6){
    		 		   		temp+=hourdate+":"+"Cold Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('forecast8days'))[0].temp<4){
    		 		   		temp+=hourdate+":"+"Severe Cold Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		";
    		 		   	}
    		 		   }
    		 		   else if(units=='imperial'){
    		 		   	if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=104 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=111){
    		 		   		temp+=hourdate+":"+"Hot("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>111 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=115){
    		 		   		temp+=hourdate+":"+"Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>115 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=128){
    		 		   		temp+=hourdate+":"+"Severe Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>128){
    		 		   		temp+=hourdate+":"+"Extreme Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=42 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=50){
    		 		   		temp+=hourdate+":"+"Cold("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=39 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=41){
    		 		   		temp+=hourdate+":"+"Cold Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('forecast8days'))[0].temp<39){
    		 		   		temp+=hourdate+":"+"Severe Cold Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   }
    		 		   else if(units==''){
    		 		   	if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=313 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=317){
    		 		   		temp+=hourdate+":"+"Hot("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>317 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=319){
    		 		   		temp+=hourdate+":"+"Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>319 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=326){
    		 		   		temp+=hourdate+":"+"Severe Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>326){
    		 		   		temp+=hourdate+":"+"Extreme Heat Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=279 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<=283){
    		 		   		temp+=hourdate+":"+"Cold("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp>=277 && JSON.parse(sessionStorage.getItem('currentnow')).current.temp<278){
    		 		   		temp+=hourdate+":"+"Cold Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   	else if(JSON.parse(sessionStorage.getItem('currentnow')).current.temp<277){
    		 		   		temp+=hourdate+":"+"Severe Cold Wave("+JSON.parse(sessionStorage.getItem('currentnow')).current.temp+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
    		 		   	}
    		 		   }

    		 		  if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=150){
    	    		    	/* document.getElementById('details').innerHTML+='Air Quality:Unhealthy for Sensitive Groups';
    	    		    	 document.getElementById('airdesc').innerHTML='Unhealthy for Sensitive Groups<br>'+
    	    	    		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>'; */
    	    		   airalerts+=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+":Air Quality is Unhealthy for Sensitive Groups with (AQI:"+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    	    		    }
    	    		    else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=200){
    	    		    	/* document.getElementById('details').innerHTML+='Air Quality:Unhealthy';
    	    		    	 document.getElementById('airdesc').innerHTML='Unhealthy<br>'+
    	    	    		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
    	    		    	  */airalerts+=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+":Air Quality is Unhealthy (AQI:"+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		";
    	    		    }
    	    		    else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=300){
    	    		    	/* document.getElementById('details').innerHTML+='Air Quality:Very Unhealthy';
    	    		    	 document.getElementById('airdesc').innerHTML='Very Unhealthy<br>'+
    	    	    		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
    	    		    	  */airalerts+=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+":Air Quality is Very Unhealthy  (AQI:"+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		";
    	    		    }
    	    		    else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>300){
    	    		    	/* document.getElementById('details').innerHTML+='Air Quality:Hazardous';
    	    		    	 document.getElementById('airdesc').innerHTML='Hazardous<br>'+
    	    	    		    '<small>Health alert: everyone may experience more serious health effects</small>';
    	    		    	  */airalerts+=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+":Air Quality is Unhealthy for Sensitive Groups  (AQI:"+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		";
    	    		    }
	
	
	console.log(descriptionalerts);
	console.log(JSON.parse(sessionStorage.getItem('forecast8days')).length);
for(i=0;i < JSON.parse(sessionStorage.getItem('forecast8days')).length;i++){
	var date=new Date(JSON.parse(sessionStorage.getItem('forecast8days'))[i].dt*1000);
	var hourdate=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear();
	var descriptiontempalert=JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description;
	// Weather Condition
	console.log("Alerts");
	console.log("Description:"+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description);
	console.log("WindSpeed:"+JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed);
	console.log("Temperature:"+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve);
	console.log(descriptionalerts.includes(descriptiontempalert));
	
	if(descriptionalerts.includes(descriptiontempalert)){
		console.log("condition detected");
		condition+=hourdate+":"+JSON.parse(sessionStorage.getItem('forecast8days'))[i].weather[0].description+"; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	";
	}
	// Cyclone
	if(units=='metric' || units==''){
		console.log('standard');
	if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed>=17 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed<=24)
	{
		cyclone+=hourdate+":"+"Cyclonic Storm; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	}
	else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed>24 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed<=32)
	{
		cyclone+=hourdate+":"+"Severe Cyclonic storm; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	}
	else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed>32 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed<=61)
{
		cyclone+=hourdate+":"+"very Severe Cyclonic storm; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
	else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed>61){
		cyclone+=hourdate+":"+"Super Cyclone; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	}
	}
	else if(units=='imperial'){
		console.log('imperial');
		if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed>=39 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed<=54)
		{
			cyclone+=hourdate+":"+"Cyclonic Storm; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed>54 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed<=72)
		{
			cyclone+=hourdate+":"+"Severe Cyclonic storm; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed>72 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed<=136)
	{
			cyclone+=hourdate+":"+"very Severe Cyclonic storm;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
			}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].wind_speed>136){
			cyclone+=hourdate+":"+"Super Cyclone;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
		}
	}
	
	// Temperature
	if(units=='metric'){
		if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=40 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=44){
			temp+=hourdate+":"+"Hot("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>44 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=46){
			temp+=hourdate+":"+"Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>46 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=53){
			temp+=hourdate+":"+"Severe Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>53){
			temp+=hourdate+":"+"Extreme Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=6 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=10){
			temp+=hourdate+":"+"Cold("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=4 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<6){
			temp+=hourdate+":"+"Cold Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<4){
			temp+=hourdate+":"+"Severe Cold Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
	}
	else if(units=='imperial'){
		if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=104 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=111){
			temp+=hourdate+":"+"Hot("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>111 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=115){
			temp+=hourdate+":"+"Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>115 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=128){
			temp+=hourdate+":"+"Severe Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>128){
			temp+=hourdate+":"+"Extreme Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=42 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=50){
			temp+=hourdate+":"+"Cold("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=39 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=41){
			temp+=hourdate+":"+"Cold Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<39){
			temp+=hourdate+":"+"Severe Cold Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ";
		}
	}
	else if(units==''){
		if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=313 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=317){
			temp+=hourdate+":"+"Hot("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>317 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=319){
			temp+=hourdate+":"+"Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>319 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=326){
			temp+=hourdate+":"+"Severe Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>326){
			temp+=hourdate+":"+"Extreme Heat Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=279 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<=283){
			temp+=hourdate+":"+"Cold("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve>=277 && JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<278){
			temp+=hourdate+":"+"Cold Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		else if(JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve<277){
			temp+=hourdate+":"+"Severe Cold Wave("+JSON.parse(sessionStorage.getItem('forecast8days'))[i].temp.eve+")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
	}
	
	
}

if("daily" in JSON.parse(sessionStorage.getItem('airquality')).data.forecast){
	
for (i=0;i < JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25.length;i++){
	var date=new Date(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].day);
    console.log(month[date.getMonth()]+" "+date.getDate()+" "+date.getUTCFullYear());
    airdate=month[date.getMonth()]+" "+date.getDate()+" "+date.getUTCFullYear()
    var today=new Date(Date.now());
    console.log(month[today.getMonth()]+" "+today.getDate()+" "+today.getUTCFullYear());
    airtoday=month[today.getMonth()]+" "+today.getDate()+" "+today.getUTCFullYear();
    console.log(airdate==airtoday);
	if(airdate!=airtoday){
	console.log(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i]);
	if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg<=150){
    	/* document.getElementById('details').innerHTML+='Air Quality:Unhealthy for Sensitive Groups&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
    	 document.getElementById('airdesc').innerHTML='Unhealthy for Sensitive Groups<br>'+
		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>'; */
   airalerts+=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+":Air Quality is Unhealthy for Sensitive Groups with (AQI:"+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    }
    else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg<=200){
    	/* document.getElementById('details').innerHTML+='Air Quality:Unhealthy';
    	 document.getElementById('airdesc').innerHTML='Unhealthy<br>'+
		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
    	 */ airalerts+=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+":Air Quality is Unhealthy (AQI:"+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    }
    else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg<=300){
    	/* document.getElementById('details').innerHTML+='Air Quality:Very Unhealthy';
    	 document.getElementById('airdesc').innerHTML='Very Unhealthy<br>'+
		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
    	  */airalerts+=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+":Air Quality is Very Unhealthy  (AQI:"+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    }
    else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>300){
    	/* document.getElementById('details').innerHTML+='Air Quality:Hazardous';
    	 document.getElementById('airdesc').innerHTML='Hazardous<br>'+
		    '<small>Health alert: everyone may experience more serious health effects</small>';
    	  */airalerts+=month[date.getMonth()]+" "+("0"+date.getDate()).substr(-2)+" "+date.getUTCFullYear()+":Air Quality is Unhealthy for Sensitive Groups  (AQI:"+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+"); &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    }
}
	
	}

}
console.log("alert:"+condition+" "+cyclone+" "+temp+" "+airalerts);
console.log("condition:"+condition);
alert+=condition;
alert+=cyclone;
alert+=temp;
alert+=airalerts;
if(alert!='<b>Alert:</b>'){
document.getElementById("alerts").innerHTML="<b>"+alert+"</b>";
}
else{
	document.getElementById("alerts").innerHTML='';
}