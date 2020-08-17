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
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</head>
<body style="background-color:#DCDCDC">
<%@ include file="WeatherAfterLoginHead.jsp" %>
<%@ include file="Alerts.jsp" %>
<br>
<%@ include file="pagination.jsp" %>

<c:if test="${units=='metric'}">
			
			<c:set var="tempunit" scope="session" value="°C"/>
			</c:if>
			<c:if test="${units=='imperial'}">
			
			<c:set var="tempunit" scope="session" value="°F"/>
			</c:if>
			<c:if test="${units==''}">
			
			<c:set var="tempunit" scope="session" value="K"/>
			</c:if>
<div class="container-fluid" id="historyweather">

</div>
<%@ include file="weatherhistoryretrieve.jsp" %>
<br>
<script>
window.onload = function () {

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	theme: "light2",
	title:{
		text:"History- 5 Days"
	},
	axisX: {
		valueFormatString: "DD MMMM YYYY"
	},
	axisY2: {
		title: "Temperature",
		suffix: "${tempunit}"
	},
	toolTip: {
		shared: true
	},
	legend: {
		cursor: "pointer",
		verticalAlign: "top",
		horizontalAlign: "center",
		dockInsidePlotArea: true,
		itemclick: toogleDataSeries
	},
	data: [
		{        
			type:"line",
			axisYType: "secondary",
			name: "Temperature",
			showInLegend: true,
			markerSize: 0,
			yValueFormatString: "###${tempunit}",
      	
		dataPoints: [
			
				
			{x:new Date(JSON.parse(sessionStorage.getItem('history5')).current.dt*1000),y:JSON.parse(sessionStorage.getItem('history5')).current.temp },
			{x:new Date(JSON.parse(sessionStorage.getItem('history4')).current.dt*1000), y:JSON.parse(sessionStorage.getItem('history4')).current.temp},
			{x:new Date(JSON.parse(sessionStorage.getItem('history3')).current.dt*1000), y:JSON.parse(sessionStorage.getItem('history3')).current.temp},
			{x:new Date(JSON.parse(sessionStorage.getItem('history2')).current.dt*1000), y:JSON.parse(sessionStorage.getItem('history2')).current.temp},
			{x:new Date(JSON.parse(sessionStorage.getItem('history1')).current.dt*1000), y:JSON.parse(sessionStorage.getItem('history1')).current.temp},
			{x:new Date(JSON.parse(sessionStorage.getItem('history0')).current.dt*1000),y:JSON.parse(sessionStorage.getItem('history0')).current.temp},
			
			
		]
	}]
});
chart.render();
function toogleDataSeries(e){
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	} else{
		e.dataSeries.visible = true;
	}
	chart.render();
}


}
</script>
<div id="chartContainer" style="height: 380px; width: 65%;margin: 0 auto;float: none;"></div> --%>

</body>
</html>