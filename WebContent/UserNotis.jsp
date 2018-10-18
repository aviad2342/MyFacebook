<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.util.ArrayList" %>
    <%@page import="db.data.Notification"%>
    <%@page import="org.json.simple.JSONObject"%>
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
// String userName = "aviad2342";

ArrayList<Notification> notification = userData.getUserNotifications(userName);

if(notification != null ){
	
String json = "[";

for(int i = 0 ; i < notification.size() ; i++){
   
   String name = notification.get(i).getName();
   String content = notification.get(i).getContent();
   
   json += "{ \"name\": \""+name+"\",\"content\": \""+content+"\"}";
   
	if(i+1 == notification.size()){
		json += "]";
	   
	   }else{
		   json += ",";
	   }
}


response.getWriter().write(json);
response.getWriter().flush();
response.getWriter().close();
}
%>	
</body>
</html>