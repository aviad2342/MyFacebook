<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.util.ArrayList" %>
    <%@page import="db.data.Post"%>
    <%@page import="db.data.Comments"%>
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
ArrayList<Post> posts = userData.getUserPosts(userName);

if(posts != null ){
String json = "[";

for(int i = 0 ; i < posts.size() ; i++){
   String uName = posts.get(i).getByUser();
   int postId = posts.get(i).getPostId();
   String postby = posts.get(i).getByUserName();
   Date date = posts.get(i).getDate();
   String content = posts.get(i).getContent();
   json += "{ \"postId\": \""+postId+"\",\"userName\": \""+uName+"\",\"postby\": \""+postby+"\",\"date\": \""+date+"\",\"content\": \""+content+"\",\"comments\":[";
   
   if(posts.get(i).getComments() != null){
   	for(int j = 0 ; j < posts.get(i).getComments().size() ; j++){
	   String name = posts.get(i).getComments().get(j).getByUserName();
	   String comment = posts.get(i).getComments().get(j).getContent();
	   if(j+1 == posts.get(i).getComments().size()){
		   json += "{\"name\": \""+name+"\",\"comment\": \""+comment+"\"}]";
	   
	   }else{
		   json += "{\"name\": \""+name+"\",\"comment\": \""+comment+"\"},";
	   }
	   
   }
   
   if(i+1 == posts.size()){
	   json += "}]";
   
   }else{
	   json += "},";
   }
}else{
	if(i+1 == posts.size()){
		   json += "{}]}]";
	   
	   }else{
		   json += "{}]},";
	   }
	
 }
 }

response.getWriter().write(json);
response.getWriter().flush();
response.getWriter().close();
}
%>	

</body>
</html>