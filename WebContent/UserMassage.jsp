<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.util.ArrayList" %>
    <%@page import="db.data.Message"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="userData" class="db.data.SystemData" scope="application"></jsp:useBean>
<jsp:useBean id="message" class="db.data.Message" scope="session"> </jsp:useBean>
<%
String userName = request.getParameter("userName");
ArrayList<Message> messages = userData.getUserMessages(userName);
String json = "[";

if(messages != null){
for(int i = 0 ; i < messages.size() ; i++){
   String from = messages.get(i).getFrom();
   String content = messages.get(i).getContent();
   String isread = messages.get(i).getIsRead()?"yes":"no";
   
   json += "{ \"from\": \""+from+"\",\"content\": \""+content+"\",\"isread\": \""+isread+"\"}";
        
      if(i+1 == messages.size()){
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