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
<jsp:useBean id="comment" class="db.data.Comments" scope="request"></jsp:useBean>
<%
String userName = request.getParameter("byUser");
String postId = request.getParameter("postId");
String content = request.getParameter("content");

String postBy = userData.getLogUserName(userName);

int id = Integer.parseInt(postId);
comment.setCommentId(id);
comment.setByUser(userName);
comment.setContent(content);


boolean is = userData.addComment(comment);
String json = "[{ \"name\":\""+postBy+"\",\"comment\":\""+content+"\"}]";

if(is){
	String noti = "Added A New Comment"; 
	userData.addNotification(userName, noti);
}


response.getWriter().write(json);
response.getWriter().flush();
response.getWriter().close();
%>	
</body>
</html>