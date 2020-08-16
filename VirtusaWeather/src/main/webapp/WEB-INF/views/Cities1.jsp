<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
 <head>
  <title>Webslesson Tutorial | Search HTML Table Data by using JQuery</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
  <style>
  #result {
   position: absolute;
   width: 100%;
   max-width:870px;
   cursor: pointer;
   overflow-y: auto;
   max-height: 400px;
   box-sizing: border-box;
   z-index: 1001;
  }
  .link-class:hover{
   background-color:#f1f1f1;
  }
  </style>
 </head>
 <body>
  <br /><br />
  <div class="container" style="width:900px;">
   <h2 align="center">JSON Live Data Search using Ajax JQuery</h2>
   <h3 align="center">Employee Data</h3>   
   <br /><br />
   <div align="center">
    <input type="text" name="search" id="search" placeholder="Search Employee Details" class="form-control"/>
    <input type="hidden" name="latitudes" id="latitudes" value="">
    <input type="hidden" name="longitudes" id="longitudes" value="">
   </div>
   <ul class="list-group" id="result"></ul>
   <br />
  </div>
 </body>
</html>

<script>
$(document).ready(function(){
	  var lat;
	  var lng;
 $.ajaxSetup({ cache: false });
 $('#search').click(function(){
	  $('#result').html('');
	  $('#state').val('');

	  var searchField = $('#search').val();
	 /* $('#result').append('<li class="list-group-item link-class">'+searchField+'</li>') */
			  $('#result').append('<li class="list-group-item link-class" onclick="getLocation()">Current Location<i class="fas fa-location-arrow" style="font-size:24px;float: right;"></i></li> ');

	 });
 $('#search').keyup(function(){
  $('#result').html('');
  $('#state').val('');
  $('#result').append('<li class="list-group-item link-class" onclick="getLocation()">Current Location<i class="fas fa-location-arrow" style="font-size:24px;float: right;"></i></li> ');
  var searchField = $('#search').val();
  var expression = new RegExp('^'+searchField, "i");
  $.getJSON('worldcities.json', function(data) {
	  
	  if(searchField.length>=2){
		  /* $('#result').append('<li class="list-group-item link-class">'+searchField+'</li>') */
		  $('#result').append('<a href="/weather_forecast?lat=0&lng=0&cityname='+searchField+'"><li class="list-group-item link-class">'+searchField+'</li></a>')
   $.each(data, function(key, value){
    if (value.city_ascii.search(expression) != -1 )
    {
    	
     $('#result').append('<a href="/weather_forecast?lat='+value.lat+'&lng='+value.lng+'&cityname='+value.city_ascii+'"><li class="list-group-item link-class">'+value.city_ascii+',' +value.admin_name+','+value.country+'</li></a>');
     
     
    }
   });
	  }
  });
 });

 $('#result').on('click', 'li', function() {
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
