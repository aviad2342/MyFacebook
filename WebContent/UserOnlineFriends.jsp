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
<ul class="friendsList">
<%
String userName = request.getParameter("userName");
ArrayList<Users> users = userData.getUserFriends(userName);

if(users != null){
for(int i = 0 ; i < users.size() ; i++){
	if(users.get(i).getOnLine()){
   String uName = users.get(i).getUserName();
   String fName = users.get(i).getFirstName();
   String lName = users.get(i).getLastName();
 %>
<li><a href="Profiles.jsp?uName=<%=uName %>" rel="toggle" role="button"><%=fName + " " + lName %></a></li>		 				 
<% } 
}
}
%>	
</ul>
</body>
</html>