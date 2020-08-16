<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
#marquee {

	/*line-height: 50px;*/
	height:20px;
	background-color: red;
	color: white;
    white-space: nowrap;
    overflow: hidden;
    box-sizing: border-box;
}
#marquee p {
    display: inline-block;
    font-size:13px;
    padding-left: 100%;
    animation: marquee 60s linear infinite;
}
@keyframes marquee {
    0%   { transform: translate(0, 0); }
    100% { transform: translate(-100%, 0); }
}

</style>
<body>
<div style="background-color:#F7DC6F;color:red;" id="marquee">
<p  id="alerts"></p>
</div>
</body>
</html>