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
	console.log(units);
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
	console.log(sessionStorage.getItem("latitude"));
	console.log(sessionStorage.getItem("longitude"));
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
	
$.ajax({
	url:'https://api.waqi.info/feed/geo:'+sessionStorage.getItem("latitude")+";"+sessionStorage.getItem("longitude")+"/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520",
	type:"GET",
	datatype:"jsonp",
	success: function(data){
		//console.log(data);
		console.log("air");
		sessionStorage.setItem('airquality',JSON.stringify(data));
		var end = new Date().getTime();
		    console.log("airtime:"+(end - start));
console.log(JSON.parse(sessionStorage.getItem('airquality')));
// AQI
if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=50){
    
    document.getElementById('airdesc').innerHTML='Air Quality:Good<br>'+
    '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
    }
    else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=100){
    	
    	 document.getElementById('airdesc').innerHTML='Moderate<br>'+
		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
    }
    else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=150){
    	
    	 document.getElementById('airdesc').innerHTML='Unhealthy for Sensitive Groups<br>'+
		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
    }
    else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=200){
    	
    	 document.getElementById('airdesc').innerHTML='Unhealthy<br>'+
		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
    }
    else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=300){
    	
    	 document.getElementById('airdesc').innerHTML='Very Unhealthy<br>'+
		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
    }
    else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>300){
    	
    	 document.getElementById('airdesc').innerHTML='Hazardous<br>'+
		    '<small>Health alert: everyone may experience more serious health effects</small>';
    }
    document.getElementById('aqivalue').innerHTML='AQI:'+JSON.parse(sessionStorage.getItem("airquality")).data.aqi+'<br>';
    
    // PM 2.5
    document.getElementById('pm2.5').innerHTML='PM<sub>2.5</sub><br>';
    if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v<=50){
        
        document.getElementById('pm2.5desc').innerHTML='Good<br>'+
        '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
        document.getElementById('pm2.5value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v;
        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v<=100){
        	
        	 document.getElementById('pm2.5desc').innerHTML='Moderate<br>'+
    		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
             document.getElementById('pm2.5value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v;

        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v<=150){
        	
        	 document.getElementById('pm2.5desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
    		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
             document.getElementById('pm2.5value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v;

        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v<=200){
        	
        	 document.getElementById('pm2.5desc').innerHTML='Unhealthy<br>'+
    		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
        	 document.getElementById('pm2.5value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v;
        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v<=300){
        	
        	 document.getElementById('pm2.5desc').innerHTML='Very Unhealthy<br>'+
    		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
        	 document.getElementById('pm2.5value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v;
        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v>300){
        	
        	 document.getElementById('pm2.5desc').innerHTML='Hazardous<br>'+
    		    '<small>Health alert: everyone may experience more serious health effects</small>';
        	 document.getElementById('pm2.5value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm25.v;
        }
    //O3
    if("o3" in JSON.parse(sessionStorage.getItem('airquality')).data.iaqi){
    document.getElementById('o3').innerHTML='O<sub>3</sub><br>';
    if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v<=50){
        
        document.getElementById('o3desc').innerHTML='Good<br>'+
        '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
        document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v;
        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v<=100){
        	
        	 document.getElementById('o3desc').innerHTML='Moderate<br>'+
    		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
        	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v;

        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v<=150){
        	
        	 document.getElementById('o3desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
    		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
        	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v;

        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v<=200){
        	
        	 document.getElementById('o3desc').innerHTML='Unhealthy<br>'+
    		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
        	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v;
        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v<=300){
        	
        	 document.getElementById('o3desc').innerHTML='Very Unhealthy<br>'+
    		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
        	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v;
        }
        else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v>300){
        	
        	 document.getElementById('o3desc').innerHTML='Hazardous<br>'+
    		    '<small>Health alert: everyone may experience more serious health effects</small>';
        	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v;
        }
    }
    else if ("o3" in JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily){
    	document.getElementById('o3').innerHTML='O<sub>3</sub><br>';
        if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg<=50){
            
            document.getElementById('o3desc').innerHTML='Good<br>'+
            '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
            document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg<=100){
            	
            	 document.getElementById('o3desc').innerHTML='Moderate<br>'+
        		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
            	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg<=150){
            	
            	 document.getElementById('o3desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
        		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
            	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg<=200){
            	
            	 document.getElementById('o3desc').innerHTML='Unhealthy<br>'+
        		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
            	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg<=300){
            	
            	 document.getElementById('o3desc').innerHTML='Very Unhealthy<br>'+
        		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
            	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.o3[2].avg>300){
            	
            	 document.getElementById('o3desc').innerHTML='Hazardous<br>'+
        		    '<small>Health alert: everyone may experience more serious health effects</small>';
            	 document.getElementById('o3value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.o3.v;
            }
    }
    else{
    	document.getElementById('o3').innerHTML='';
    	document.getElementById('o3desc').innerHTML='';
	 document.getElementById('o3value').innerHTML='';
    }
    	
    //PM10
    if("pm10" in JSON.parse(sessionStorage.getItem('airquality')).data.iaqi){
        document.getElementById('pm10').innerHTML='PM<sub>10</sub><br>';
        if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v<=50){
            
            document.getElementById('pm10desc').innerHTML='Good<br>'+
            '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
            document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v<=100){
            	
            	 document.getElementById('pm10desc').innerHTML='Moderate<br>'+
        		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
            	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v<=150){
            	
            	 document.getElementById('pm10desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
        		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
            	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v<=200){
            	
            	 document.getElementById('pm10desc').innerHTML='Unhealthy<br>'+
        		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
            	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v<=300){
            	
            	 document.getElementById('pm10desc').innerHTML='Very Unhealthy<br>'+
        		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
            	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v>300){
            	
            	 document.getElementById('pm10desc').innerHTML='Hazardous<br>'+
        		    '<small>Health alert: everyone may experience more serious health effects</small>';
            	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.pm10.v;
            }
        }
        else if ("pm10" in JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily){
        	document.getElementById('pm10').innerHTML='PM<sub>10</sub><br>';
            if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg<=50){
                
                document.getElementById('pm10desc').innerHTML='Good<br>'+
                '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
                document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg<=100){
                	
                	 document.getElementById('pm10desc').innerHTML='Moderate<br>'+
            		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
                	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg;

                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg<=150){
                	
                	 document.getElementById('pm10desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
            		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
                	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg;

                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg<=200){
                	
                	 document.getElementById('pm10desc').innerHTML='Unhealthy<br>'+
            		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
                	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg<=300){
                	
                	 document.getElementById('pm10desc').innerHTML='Very Unhealthy<br>'+
            		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
                	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg>300){
                	
                	 document.getElementById('pm10desc').innerHTML='Hazardous<br>'+
            		    '<small>Health alert: everyone may experience more serious health effects</small>';
                	 document.getElementById('pm10value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm10[2].avg;
                }
        }
        else{
        	document.getElementById('pm10').innerHTML='';
        	document.getElementById('pm10desc').innerHTML='';
    	 document.getElementById('pm10value').innerHTML='';
        }
    
    //NO2
    if("no2" in JSON.parse(sessionStorage.getItem('airquality')).data.iaqi){
        document.getElementById('no2').innerHTML='NO<sub>2</sub><br>';
        if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v<=50){
            
            document.getElementById('no2desc').innerHTML='Good<br>'+
            '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
            document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v<=100){
            	
            	 document.getElementById('no2desc').innerHTML='Moderate<br>'+
        		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
            	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v<=150){
            	
            	 document.getElementById('no2desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
        		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
            	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v<=200){
            	
            	 document.getElementById('no2desc').innerHTML='Unhealthy<br>'+
        		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
            	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v<=300){
            	
            	 document.getElementById('no2desc').innerHTML='Very Unhealthy<br>'+
        		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
            	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v>300){
            	
            	 document.getElementById('no2desc').innerHTML='Hazardous<br>'+
        		    '<small>Health alert: everyone may experience more serious health effects</small>';
            	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.no2.v;
            }
        }
        else if ("no2" in JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily){
        	document.getElementById('no2').innerHTML='NO<sub>2</sub><br>';
            if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg<=50){
                
                document.getElementById('no2desc').innerHTML='Good<br>'+
                '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
                document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg<=100){
                	
                	 document.getElementById('no2desc').innerHTML='Moderate<br>'+
            		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
                	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg;

                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg<=150){
                	
                	 document.getElementById('no2desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
            		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
                	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg;

                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg<=200){
                	
                	 document.getElementById('no2desc').innerHTML='Unhealthy<br>'+
            		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
                	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg<=300){
                	
                	 document.getElementById('no2desc').innerHTML='Very Unhealthy<br>'+
            		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
                	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg>300){
                	
                	 document.getElementById('no2desc').innerHTML='Hazardous<br>'+
            		    '<small>Health alert: everyone may experience more serious health effects</small>';
                	 document.getElementById('no2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.no2[2].avg;
                }
        }
        else{
        	document.getElementById('no2').innerHTML='';
        	document.getElementById('no2desc').innerHTML='';
    	 document.getElementById('no2value').innerHTML='';
        }
    //SO2
    if("so2" in JSON.parse(sessionStorage.getItem('airquality')).data.iaqi){
        document.getElementById('so2').innerHTML='SO<sub>2</sub><br>';
        if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v<=50){
            
            document.getElementById('so2desc').innerHTML='Good<br>'+
            '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
            document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v<=100){
            	
            	 document.getElementById('so2desc').innerHTML='Moderate<br>'+
        		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
            	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v<=150){
            	
            	 document.getElementById('so2desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
        		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
            	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v<=200){
            	
            	 document.getElementById('so2desc').innerHTML='Unhealthy<br>'+
        		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
            	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v<=300){
            	
            	 document.getElementById('so2desc').innerHTML='Very Unhealthy<br>'+
        		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
            	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v>300){
            	
            	 document.getElementById('so2desc').innerHTML='Hazardous<br>'+
        		    '<small>Health alert: everyone may experience more serious health effects</small>';
            	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.so2.v;
            }
        }
        else if ("so2" in JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily){
        	document.getElementById('so2').innerHTML='SO<sub>2</sub><br>';
            if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg<=50){
                
                document.getElementById('so2desc').innerHTML='Good<br>'+
                '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
                document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg<=100){
                	
                	 document.getElementById('so2desc').innerHTML='Moderate<br>'+
            		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
                	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg;

                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg<=150){
                	
                	 document.getElementById('so2desc').innerHTML='Unhealthy for Sensitive Groups<br>'+
            		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
                	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg;

                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg<=200){
                	
                	 document.getElementById('so2desc').innerHTML='Unhealthy<br>'+
            		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
                	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg<=300){
                	
                	 document.getElementById('so2desc').innerHTML='Very Unhealthy<br>'+
            		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
                	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg>300){
                	
                	 document.getElementById('so2desc').innerHTML='Hazardous<br>'+
            		    '<small>Health alert: everyone may experience more serious health effects</small>';
                	 document.getElementById('so2value').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.so2[2].avg;
                }
        }
        else{
        	document.getElementById('so2').innerHTML='';
        	document.getElementById('so2desc').innerHTML='';
    	 document.getElementById('so2value').innerHTML='';
        }
    
    //CO
    if("co" in JSON.parse(sessionStorage.getItem('airquality')).data.iaqi){
        document.getElementById('co').innerHTML='CO<br>';
        if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v<=50){
            
            document.getElementById('codesc').innerHTML='Good<br>'+
            '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
            document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v<=100){
            	
            	 document.getElementById('codesc').innerHTML='Moderate<br>'+
        		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
            	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v<=150){
            	
            	 document.getElementById('codesc').innerHTML='Unhealthy for Sensitive Groups<br>'+
        		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
            	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v;

            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v<=200){
            	
            	 document.getElementById('codesc').innerHTML='Unhealthy<br>'+
        		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
            	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v<=300){
            	
            	 document.getElementById('codesc').innerHTML='Very Unhealthy<br>'+
        		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
            	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v;
            }
            else if(JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v>300){
            	
            	 document.getElementById('codesc').innerHTML='Hazardous<br>'+
        		    '<small>Health alert: everyone may experience more serious health effects</small>';
            	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.iaqi.co.v;
            }
        }
        else if ("co" in JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily){
        	document.getElementById('co').innerHTML='NO<sub>2</sub><br>';
            if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg<=50){
                
                document.getElementById('codesc').innerHTML='Good<br>'+
                '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small>';
                document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg<=100){
                	
                	 document.getElementById('codesc').innerHTML='Moderate<br>'+
            		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small>';
                	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg;

                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg<=150){
                	
                	 document.getElementById('codesc').innerHTML='Unhealthy for Sensitive Groups<br>'+
            		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small>';
                	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg;

                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg<=200){
                	
                	 document.getElementById('codesc').innerHTML='Unhealthy<br>'+
            		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small>';
                	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg<=300){
                	
                	 document.getElementById('codesc').innerHTML='Very Unhealthy<br>'+
            		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small>';
                	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg;
                }
                else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg>300){
                	
                	 document.getElementById('codesc').innerHTML='Hazardous<br>'+
            		    '<small>Health alert: everyone may experience more serious health effects</small>';
                	 document.getElementById('covalue').innerHTML=JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.co[2].avg;
                }
        }
        else{
        	document.getElementById('co').innerHTML='';
        	document.getElementById('codesc').innerHTML='';
    	 document.getElementById('covalue').innerHTML='';
        }
    //Air Quality Forecast
    if("daily" in JSON.parse(sessionStorage.getItem('airquality')).data.forecast){
    	
    for(var i=0;i<JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25.length;i++){
    console.log(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i]);
    var date=new Date(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].day);
    console.log(month[date.getMonth()]+" "+date.getDate()+" "+date.getUTCFullYear());
    airdate=month[date.getMonth()]+" "+date.getDate()+" "+date.getUTCFullYear()
    var today=new Date(Date.now());
    console.log(month[today.getMonth()]+" "+today.getDate()+" "+today.getUTCFullYear());
    airtoday=month[today.getMonth()]+" "+today.getDate()+" "+today.getUTCFullYear();
    console.log(airdate==airtoday);
	 if(airdate!=airtoday){
	 if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg<=50){
	        
		 document.getElementById('airforecast').innerHTML+='<div class="row">'+
		 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+'</div>'+'<div class="col-6">Good<br>'+
	        '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small></div></div><br>';
	        
	        }
	        else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg<=100){
	        	
	        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
	       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+'</div>'+'<div class="col-6">Moderate<br>'+
	    		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small></div></div><br>';
	             

	        }
	        else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg<=150){
	        	
	        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
	       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+'</div>'+'<div class="col-6">Unhealthy for Sensitive Groups<br>'+
	    		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small></div></div><br>';
	             

	        }
	        else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg<=200){
	        	
	        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
	       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+'</div>'+'<div class="col-6">Unhealthy<br>'+
	    		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small></div></div><br>';
	        	 
	        }
	        else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg<=300){
	        	
	        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
	       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+'</div>'+'<div class="col-6">Very Unhealthy<br>'+
	    		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small></div></div><br>';
	        }
	        else if(JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg>300){
	        	
	        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
	       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.forecast.daily.pm25[i].avg+'</div>'+'<div class="col-6">Hazardous<br>'+
	    		    '<small>Health alert: everyone may experience more serious health effects</small></div></div><br>';
	        	 
	        }
	 }
	 else{
		 if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=0 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=50){
		        
			 document.getElementById('airforecast').innerHTML+='<div class="row">'+
			 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+'</div>'+'<div class="col-6">Good<br>'+
		        '<small>Air quality is considered satisfactory, and air pollution poses little or no risk.</small></div></div><br>';
		        
		        }
		        else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=51 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=100){
		        	
		        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
		       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+'</div>'+'<div class="col-6">Moderate<br>'+
		    		    '<small>Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</small></div></div><br>';
		             

		        }
		        else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=101 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=150){
		        	
		        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
		       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+'</div>'+'<div class="col-6">Unhealthy for Sensitive Groups<br>'+
		    		    '<small>Members of sensitive groups may experience health effects. The general public is not likely to be affected.</small></div></div><br>';
		             

		        }
		        else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=151 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=200){
		        	
		        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
		       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+'</div>'+'<div class="col-6">Unhealthy<br>'+
		    		    '<small>Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.</small></div></div><br>';
		        	 
		        }
		        else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>=201 && JSON.parse(sessionStorage.getItem('airquality')).data.aqi<=300){
		        	
		        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
		       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+'</div>'+'<div class="col-6">Very Unhealthy<br>'+
		    		    '<small>Health warnings of emergency conditions. The entire population is more likely to be affected.</small></div></div><br>';
		        }
		        else if(JSON.parse(sessionStorage.getItem('airquality')).data.aqi>300){
		        	
		        	document.getElementById('airforecast').innerHTML+='<div class="row">'+
		       	 '<div class="col-6" >'+airdate+'<br>'+JSON.parse(sessionStorage.getItem('airquality')).data.aqi+'</div>'+'<div class="col-6">Hazardous<br>'+
		    		    '<small>Health alert: everyone may experience more serious health effects</small></div></div><br>';
		        	 
		        }
	 }

    }
}
    else{
    	document.getElementById('airforecast').innerHTML='';
    }
    
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