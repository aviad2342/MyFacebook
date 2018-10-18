<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
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
<jsp:useBean id="post" class="db.data.Post" scope="request"></jsp:useBean>
<%
String userName = request.getParameter("userName");
String postToUser = request.getParameter("toTheUser");
String PostContent = request.getParameter("content");

int id;
String json = "";
String postBy = userData.getLogUserName(userName);


SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yy");
String now = sdf.format(new Date());
//get a java date (java.util.Date) from the Calendar instance.
//this java date will represent the current date, or "now".
java.util.Date currentDate = sdf.parse(now);

//now, create a java.sql.Date from the java.util.Date
java.sql.Date nowDate = new java.sql.Date(currentDate.getTime());

post.setToUser(postToUser);
post.setByUser(userName);
post.setDate(nowDate);
post.setContent(PostContent);

id = userData.addPost(post);
json += "[{ \"postId\": \""+id+"\", \"userName\": \""+userName+"\",\"postby\": \""+postBy+"\",\"date\": \""+nowDate+"\",\"content\": \""+PostContent+"\"}]";

if(id != 0){
	String noti;
	if(userName.equals(postToUser)){
		noti = "Added A New Post";
	}else{
	String nane = userData.getLogUserName(postToUser);
    noti = "Posted On "+nane+" Wall";
	}
	userData.addNotification(userName, noti);
}
	

response.getWriter().write(json);
response.getWriter().flush();
response.getWriter().close();
%>	
</body>
</html>