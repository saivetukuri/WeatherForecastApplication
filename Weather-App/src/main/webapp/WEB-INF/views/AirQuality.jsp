<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
       <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link  rel="stylesheet"  href="http://cdn.leafletjs.com/leaflet-0.7.5/leaflet.css"  />  
<script  src="http://cdn.leafletjs.com/leaflet-0.7.5/leaflet.js"></script>
</head>
<style>

tbody{
color:white;
}


</style>
<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>
<%@ include file="Alerts.jsp" %>
<br>
<%@ include file="pagination.jsp" %>
<div class="container">
<div class="card" style="width:70%;margin: 0 auto;float: none;">
<div class="card-header">
Current Air Quality
</div>


<div class="row" >
<div class="col-6" id="aqivalue">

</div>
<div class="col-6" id="airdesc">

</div>

</div>

</div>

<br>

<div class="card " style="width:70%; margin: 0 auto;float: none;">
    <div class="card-header"> 
        <ul class="nav nav-tabs card-header-tabs pull-right"  id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="pm25-tab" data-toggle="tab" href="#pm25" role="tab" aria-controls="pm25" aria-selected="true">Current Pollutants</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="airscale-tab" data-toggle="tab" href="#airscale" role="tab" aria-controls="airscale" aria-selected="false">Air Quality Scale</a>
            </li>
            
        </ul>
    </div>

    <div class="card-body">
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="pm25" role="tabpanel" aria-labelledby="pm25-tab">
            <div class="row" id="navigation" >
            
            <div class="col-3" id="pm2.5">
            
            
            </div>
            <div class="col-6" id="pm2.5desc">

            </div>
            
             <div class="col-3" id="pm2.5value">
            
            </div>
            

            </div>

            
            <br><br>
             <div class="row" id="navigation">
             
             <div class="col-3" id="o3">
             
             </div>
             <div class="col-6" id="o3desc">

            </div>
             
            <div class="col-3" id="o3value">
           
            </div>
            
           
 
            </div>
            
            <br><br>
            <div class="row" id="navigation">
            
             <div class="col-3" id="pm10">
             
             </div>
             <div class="col-6" id="pm10desc">

            </div>
             <div class="col-3" id="pm10value">
             
             </div>    
             
                        
 
            </div>
            
            <br><br>
      <div class="row" id="navigation">
            
            <div class="col-3" id="no2">
           
            
            </div>
            <div class="col-6" id="no2desc">

            </div>
             <div class="col-3" id="no2value">
            
            </div>
            
  

            </div>
            <br><br>
                        <div class="row" id="navigation">
            
            <div class="col-3" id="so2">
            
            
            </div>
            <div class="col-6" id="so2desc">

            </div>
            
             <div class="col-3" id="so2value">
          
            </div>
            

            </div>

            
            <br><br>
                        <div class="row" id="navigation">
            
            <div class="col-3" id="co">
            
            
            </div>
            <div class="col-6" id="codesc">

            </div>
            
             <div class="col-3" id="covalue">
          
            </div>
            

            </div>

            
            <br><br>
            </div>
            
            <div class="tab-pane fade" id="airscale" role="tabpanel" aria-labelledby="airscale-tab">
            <table class="infoaqitable cautionary" border=1> 
            <thead> 
            <tr> 
            <td>AQI</td><td>Air Pollution Level</td><td>Health Implications</td><td>Cautionary Statement (for PM2.5)</td> 
            </tr> 
            </thead> 
            <tbody>
            <tr style="background-color:#009966;"> 
            <td class="aqiwtxt" nowrap="true">0 - 50</td> 
            <td class="aqiwtxt">Good</td> 
            <td class="aqiwtxt">Air quality is considered satisfactory, and air pollution poses little or no risk</td>
             <td class="aqiwtxt">None</td> 
             </tr>
             <tr style="background-color:#ffde33" class="aqibtxt"> 
             <td class="aqibtxt" nowrap="true">51 -100</td>
              <td class="aqibtxt">Moderate</td> 
             <td class="aqibtxt">Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.</td> 
             <td class="aqibtxt">Active children and adults, and people with respiratory disease, such as asthma, should limit prolonged outdoor exertion.</td> 
             </tr> 
             <tr style="background-color:#ff9933;"> 
             <td class="aqibtxt" nowrap="true">101-150</td> 
             <td class="aqibtxt">Unhealthy for Sensitive Groups</td> 
             <td class="aqibtxt">Members of sensitive groups may experience health effects. The general public is not likely to be affected.</td> 
             <td class="aqibtxt">Active children and adults, and people with respiratory disease, such as asthma, should limit prolonged outdoor exertion.</td>
              </tr> <tr style="background-color:#cc0033;"> 
              <td class="aqiwtxt" nowrap="true">151-200</td> 
              <td class="aqiwtxt">Unhealthy</td> 
              <td class="aqiwtxt">Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects</td> 
              <td class="aqiwtxt">Active children and adults, and people with respiratory disease, such as asthma, should avoid prolonged outdoor exertion; everyone else, especially children, should limit prolonged outdoor exertion</td> 
              </tr> <tr style="background-color:#660099;"> <td class="aqiwtxt" nowrap="true">201-300</td> <td class="aqiwtxt">Very Unhealthy</td> <td class="aqiwtxt">Health warnings of emergency conditions. The entire population is more likely to be affected.</td> 
              <td class="aqiwtxt">Active children and adults, and people with respiratory disease, such as asthma, should avoid all outdoor exertion; everyone else, especially children, should limit outdoor exertion.</td> 
              </tr> <tr style="background-color:#7e0023;"> <td class="aqiwtxt" nowrap="true">300+</td> 
              <td class="aqiwtxt">Hazardous</td> 
              <td class="aqiwtxt">Health alert: everyone may experience more serious health effects</td> 
              <td class="aqiwtxt">Everyone should avoid all outdoor exertion</td> 
              </tr> 
              </tbody>
              </table>
            </div>
            
        </div>
    </div>
</div><br>
<div  id='map'  style='width: 70%;height:450px;margin: 0 auto;float: none;'></div>  
  
  
<script>  
      var  OSM_URL  =  'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';  
      var  OSM_ATTRIB  =  '&copy;  <a  href="http://openstreetmap.org/copyright">OpenStreetMap</a>  contributors';  
      var  osmLayer  =  L.tileLayer(OSM_URL,  {attribution:  OSM_ATTRIB});  
  
      var  WAQI_URL    =  "https://tiles.waqi.info/tiles/usepa-aqi/{z}/{x}/{y}.png?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520";  
      var  WAQI_ATTR  =  'Air  Quality  Tiles  &copy;  <a  href="http://waqi.info">waqi.info</a>';  
      var  waqiLayer  =  L.tileLayer(WAQI_URL,  {attribution:  WAQI_ATTR});  
  		var lat="${latitude}";
  		var lon="${longitude}";
  		console.log(${latitude!=null&&longitude!=null});
  		console.log(${longitude==null});
  		if(${latitude==null&&longitude==null}){
  			lat=sessionStorage.getItem("latitude");
  			lon=sessionStorage.getItem("longitude");
  			
  		}
      var  map  =  L.map('map').setView([lat,lon],4);
      var cityname=sessionStorage.getItem("cityname")
  		var marker=L.marker([lat,lon]).addTo(map).bindPopup(cityname+"<br><b>AQI:${airjson.get('data').get('aqi')}</b>").openPopup();
  		
      map.addLayer(osmLayer).addLayer(waqiLayer);  
</script>
<br>
<br>
<div class="card" style="width:70%;margin: 0 auto;float: none;">
<div class="card-header">
DAILY FORECAST
</div>
<div class="card-body" id="airforecast">

</div>
</div>
</div>
<%@ include file="AirQualityretrieve.jsp" %>




</body>
</html>