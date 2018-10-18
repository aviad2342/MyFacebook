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

boolean isFriends = userData.addFriend(userName, friendUserName); 
String isFriend = isFriends?"yes":"no";
String nane = userData.getLogUserName(friendUserName);

if(isFriends){
	
	String noti = "And "+nane+" Are Now Friends";
	userData.addNotification(userName, noti);
}

String json = "{\"isFriend\":\""+isFriend+"\", \"Name\": \""+nane+"\"}";

response.getWriter().write(json);
response.getWriter().flush();
response.getWriter().close();
%>
</body>
</html>