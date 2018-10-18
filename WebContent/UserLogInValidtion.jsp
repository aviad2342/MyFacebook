<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
  String password = request.getParameter("password"); 
  if(!userData.IsUserExists(userName, password)){  
    %>
 	  <script>
	  location.href = "FormLogInValidation.html?isUser=no";
	  </script>	
<%}else{ 
	session.setAttribute("LogInUser", userName);
	userData.updateUserLogin(userName, true);
%>
<jsp:forward page="MainPage.jsp" /> 
<%} %>
</body>
</html>