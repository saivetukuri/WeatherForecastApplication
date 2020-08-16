<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
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
<style>
  .form-group{
    margin-left: 35%;
  }
  .con{
    text-align: center;
  }
  </style>

<style type="text/css">
.navbar {
  overflow: hidden;
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
<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark"  >

    <a href="weatheradminlog" class="navbar-brand">
        WEATHER ADMIN
    </a>
    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav">
            <a href="weatheradminlog" class="nav-item nav-link">Login</a>
            <!-- <a href="weatherreg" class="nav-item nav-link">Register</a> -->
        </div>

    </div>
    
</nav>
<h1 style="text-align: center;">Admin Login</h1>
  <br>
  <div class="container">
    <form action="weatheradminlogafter" method="post" modelAttribute="admin">
        <div class="form-group">
          <div class="col-md-6 boxy">
           <label for="username">Admin User Name</label>
        <input type="email" class="form-control" name="adminname" aria-describedby="emailHelp" placeholder="Enter your Email">
        </div>
        <div class="col-md-6 boxy">
          <label for="pass">Password</label>
          <input type="password" class="form-control" name="password" placeholder="Enter Password">
          </div>
        </div>
          <div class="con">
        <input type="submit" class="btn btn-primary" value="Login"> &nbsp;
        
          </div>
      </form>
      </div>
  
</body>
</html>