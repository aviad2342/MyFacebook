<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@page import="java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="user" class="db.data.Users" scope="session"></jsp:useBean>
<jsp:useBean id="userData" class="db.data.SystemData" scope="application"></jsp:useBean>
<jsp:setProperty name="user" property="*"></jsp:setProperty>
<jsp:useBean id="con" class="db.data.MyConnection" scope="session"> </jsp:useBean>
<%
user.setPicture("pics/imageFacebookDefault.jpg");
user.setCoverImag("pics/facebook.collage.jpg");
user.setOnLine(false);
userData.addUser(user);
%>
<script>
alert("Successfully Registered");
location.href = "FormLogInValidation.html";
</script>
</body>
</html>