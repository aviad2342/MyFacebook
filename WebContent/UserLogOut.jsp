<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.util.ArrayList" %>
    <%@page import="db.data.Users"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="userData" class="db.data.SystemData" scope="application"></jsp:useBean>
<%
String userName = request.getParameter("userName");
userData.updateUserLogin(userName, false);

 %>

</body>
</html>