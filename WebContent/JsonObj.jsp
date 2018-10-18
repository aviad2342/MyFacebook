<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.util.ArrayList" %>
    <%@page import="db.data.Users"%>
    <%@page import="org.json.simple.JSONObject"%>
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
ArrayList<Users> users = userData.getAllRegisteredUser(userName);

String json = "[";

for(int i = 0 ; i < users.size() ; i++){
   String uName = users.get(i).getUserName();
   String fName = users.get(i).getFirstName();
   String lName = users.get(i).getLastName();
   	
   if(i+1 == users.size()){
	   json += "{ \"userName\": \""+uName+"\",\"Name\": \""+fName+" "+lName+"\"}]";
   
   }else{
	   json += "{ \"userName\": \""+uName+"\",\"Name\": \""+fName+" "+lName+"\"},";
   }
 }

response.getWriter().write(json);
response.getWriter().flush();
response.getWriter().close();
%>	

</body>
</html>