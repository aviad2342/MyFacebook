<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.util.*" %>
    <%@page import="db.data.Users"%>
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
Users user = userData.getLogUser(userName);
String firstName = user.getFirstName();
String lastName = user.getLastName();
String password = user.getPassword();
String mail = user.getEmail();
String profilePicture = user.getPicture();
String coverImag = user.getCoverImag();

String json = "{ \"userName\": \""+userName+"\",\"firstName\": \""+firstName+"\",\"lastName\": \""+lastName+"\",\"profilePicture\": \""+profilePicture+"\",\"coverImag\": \""+coverImag+"\"}";
	

response.getWriter().write(json);
response.getWriter().flush();
response.getWriter().close();
%>
</body>
</html>	