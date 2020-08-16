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
</head>
<body>
<%@ include file="AdminAfterLoginHead.jsp" %>
	<br><br><br><br><br> 

<c:if test="${not empty response}">
<c:if test="${response=='Success' || response=='User password changed successfully '}">
<h1 style="text-align: center;color:blue;">Updated Successfully</h1>
</c:if>
</c:if>
</body>
</html>