<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
.page-link {
  pointer-events: none;
  cursor: default;
  opacity: 0.6;
}
</style>
<body>
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
   
      <li class="page-item"><a class="page-link" id="pageid"  href="weather_forecast?lat=${latitude}&lng=${longitude}&cityname=${cityname}&units=${units}" >Now</a></li>
    
    <li class="page-item"><a class="page-link"  href="satellite?lat=${latitude}&lng=${longitude}&cityname=${cityname}" id="sat" >Satellite</a></li>
    <li class="page-item"><a class="page-link"  href="/airquality?lat=${latitude}&lng=${longitude}&cityname=${cityname}" id="air">Air Quality</a></li>
    <li class="page-item"><a class="page-link"  href="/hourly?lat=${latitude}&lng=${longitude}&cityname=${cityname}" id="hour">Hourly</a></li>
    <li class="page-item"><a class="page-link"  href="/weatherforecast?lat=${latitude}&lng=${longitude}&cityname=${cityname}&units=${units}" id="daily">Forecast-7days</a></li>
     <li class="page-item"><a class="page-link"  href="/monthly?lat=${latitude}&lng=${longitude}&cityname=${cityname}&units=${units}" id="month">13days</a></li>
    <li class="page-item">
      <a class="page-link"  href="weatherhistory?lat=${latitude}&lng=${longitude}&cityname=${cityname}&units=${units}" id="history">History-5days </a>
    </li>
  </ul>
</nav>
</body>
</html>