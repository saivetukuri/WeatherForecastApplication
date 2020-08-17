<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<script>
$(document).ready(function(){
$.getJSON("worldcities.json",function(data){
var cities =' ';
$.each(data,function(key,value){
cities+='<tr>';
cities+='<td>'+value.city+'</td>';
cities+='<td>'+value.city_ascii+'</td>';
cities+='<td>'+value.lat+'</td>';
cities+='<td>'+value.lng+'</td>';
cities+='<td>'+value.country+'</td>';
cities+='<td>'+value.iso2+'</td>';
cities+='<td>'+value.iso3+'</td>';
cities+='<td>'+value.admin_name+'</td>';
cities+='<td>'+value.capital+'</td>';
cities+='<td>'+value.population+'</td>';
cities+='<td>'+value.id+'</td>';
cities+='</tr>'
});
$('#cities').append(cities);
});
});

</script>
<body>
<div class="container">
<div class="table-responsive">
<h1> JSON data to html table</h1><br>
<table class="table table-bordered table-striped" id="cities">
<tr>
<th>City</th>
<th>City_ASCII</th>
<th>Latitude</th>
<th>Longitude</th>
<th>Country</th>
<th>iso2</th>
<th>iso3</th>
<th>admin_name</th>
<th>capital</th>
<th>Population</th>
<th>Id</th>
</tr>
</table>
</div>
</div>
</body>
</html>
