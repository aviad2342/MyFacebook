<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="userData" class="db.data.SystemData" scope="request"></jsp:useBean>
<%
String userName = request.getParameter("userName");
String friendUserName = request.getParameter("friendUserName");
String isFriend = userData.isAfriend(userName, friendUserName)?"yes":"no";


String json = "{ \"isFriend\":\""+isFriend+"\"}";

response.getWriter().write(json);
response.getWriter().flush();
response.getWriter().close();
%>
</body>
</html>	