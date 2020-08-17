<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
</head>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Comfortaa');

*{
	margin: 0;
	padding: 0;
	outline: none;
	box-sizing: border-box;
	/* font-family: 'Comfortaa', cursive; */
}

body{
/* 	background: url('images/Weatherhome.jpg') no-repeat center; */
	background-size: cover;
	width: 100%;
	height: 100vh;
}

.wrapper{
	position: absolute;
    top: 20%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0, 0, 0,0.6);
    max-width: 550px;
    width: 100%;
    padding: 15px;
    display: flex;
    justify-content: space-between;
    border-radius: 5px;
}

.wrapper .input {
    width: 85%;
    padding: 15px 20px;
    border: none;
    border-radius: 5px;
    font-weight: bold;
}

.searchbtn {
    background: #ffec00;
    width: 30%;
    border-radius: 5px;
    position: relative;
    cursor: pointer;
}

.searchbtn .fas{
	position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 18px;
}
</style>
<style type="text/css">
.navbar {
  overflow: visible;
  background-color: #333;
  top: 0; /* Position the navbar at the top of the page */
  width: 100%; /* Full width */
  
 
}
.sticky {
  position: fixed;
  top: 0;
  width: 100%;
}
#card{
background: url('images/Weatherhome.jpg') no-repeat center;
background-size: cover;
	width: 100%;
	height: 100vh;
}
body {margin:0;}

</style>
<script>
function myFunction(lat,lng,city_ascii,units) {
	console.log(lat,lng,city_ascii,units);
	window.location.href = "/weather_home1?lat="+lat+"&lng="+lng+"&cityname="+city_ascii+"&units="+units;
	}
</script>
 <script>

 $(document).ready(function(){
	 
	  var lat;
	  var lng;
	  var city_ascii;
	  var units=sessionStorage.getItem('units');
$.ajaxSetup({ cache: false });
$('#search').click(function(){
	  $('#result').html('');
	  $('#state').val('');

	  var searchField = $('#search').val();
	 
			  $('#result').append('<li class="list-group-item link-class" onclick="getLocation()">Current Location<i class="fas fa-location-arrow" style="font-size:24px;float: right;"></i></li> ');

	 });
$('#search').keyup(function(){
 $('#result').html('');
 $('#state').val('');
 $('#result').append('<li class="list-group-item link-class" onclick="getLocation()" >Current Location<i class="fas fa-location-arrow" style="font-size:24px;float: right;"></i></li> ');
 var searchField = $('#search').val();
 var expression = new RegExp('^'+searchField, "i");
 $.getJSON('worldcities.json', function(data) {
	  
	  if(searchField.length>=2){
		  
		  $('#result').append('<li class="list-group-item link-class" id="loc" onclick="myFunction(0'+',0'+','+"'"+searchField+"','"+units+"'"+')">'+searchField+'</li>')
  $.each(data, function(key, value){
   if (value.city_ascii.search(expression) != -1 )
   {
   	console.log("myFunction("+value.lat+','+value.lng+','+'"'+value.city_ascii+'"'+',"'+units+'")');
    
    
   	$('#result').append('<li class="list-group-item link-class" id="loc" onclick="myFunction('+value.lat+','+value.lng+','+"'"+value.city_ascii+"','"+units+"'"+')">'+value.city_ascii+',' +value.admin_name+','+value.country+'</li>');
   }
  });
	  }
 });
});

$('#result').on('click', '#loc', function() {
 var click_text = $(this).text().split('|');
 $('#search').val($.trim(click_text[0]));
 $("#result").html('');
 
});
});
$(document).mouseup(function(e){
   var container = $("#search");

   // If the target of the click isn't the container
   if(!container.is(e.target) && container.has(e.target).length === 0){
   	$('#result').hide();
   }
   else{
   	$('#result').show();
   }
});
</script>
 <style>
 li:hover {
  background-color: lightgrey;
  cursor: pointer;
  
}
 #result {
   position: absolute;
   width: 100%;
   max-width:757px;
   cursor: pointer;
   overflow-y: auto;
   max-height: 400px;
 box-sizing: border-box; 
 
   z-index:1001;
  }


 </style>
 <style>
  /* Styles for wrapping the search box */

.main {
    width: 50%;
    margin: 50px auto;
}

/* Bootstrap 4 text input with search icon */

.has-search .form-control {
    padding-left: 2.375rem;
}

.has-search .form-control-feedback {
    position: absolute;
    z-index: 2;
    display: block;
    width: 2.375rem;
    height: 2.375rem;
    line-height: 2.375rem;
    text-align: center;
    pointer-events: none;
    color: #aaa;
}
.list-group-flush .list-group-item:first-child {
  border-top: 0; }
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 190px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index:2001;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}
.dropdown {
  position: relative;
  display: inline-block;
}
.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown:hover .dropbtn {background-color: #3e8e41;}
  </style>
<body>

<nav class="navbar navbar-expand-md navbar-dark bg-dark"  >

    <a href="weatherhome" class="navbar-brand">
        WEATHER APP
    </a>
    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav">
        <a href="weatherhome" class="nav-item nav-link">Home</a>
            <a href="weatherlog" class="nav-item nav-link">Login</a>
            <a href="weatherreg" class="nav-item nav-link">Register</a>
            <div class="dropdown">
            <a class="nav-item nav-link" >Units</a>
            
            <div class="dropdown-content">
    		<a href="" id="C">Metric (�C, m/s, mm)</a>
    		<a href="" id="F">Imperial (�F, miles/hr, in)</a>
    		<a href="" id="K">Standard(K,m/s, mm) </a>
 			 </div>
        </div>
        </div>
        </div>

  
    
</nav>
<div class="card" id="card" style="height:150px;width:100%;">			

   <div class="main">
  
  <!-- Actual search box -->
  <div class="form-group has-search">
    <span class="fa fa-search form-control-feedback"></span>
    <input type="text" class="form-control" name="search" id="search" placeholder="Search">
    <ul class="list-group list-group-flush" id="result"></ul>
  </div>
  </div>
   <br />
</div>
<script>
var x = document.getElementById("demo");

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else { 
    x.innerHTML = "Geolocation is not supported by this browser.";
  }
}

function showPosition(position) {
  
 
  var units=sessionStorage.getItem('units');
  if(units==null){
	  units="metric";
	  sessionStorage.setItem('units',units);
  }
  myFunction(position.coords.latitude,position.coords.longitude,"",units);
  

}


</script>
 
</body>
</html>