<%@page import="java.io.File"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.awt.Image"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.FileStore"%>
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
<jsp:useBean id="userData" class="db.data.SystemData" scope="request"></jsp:useBean>
<%

//String userName = request.getParameter("userName");
InputStream input = application.getResourceAsStream("/pics/amit.jpg");

URL u = application.getResource("/pics/amit.jpg");
URL use = application.getResource("/WEB-INF‬");
Image image = ImageIO.read(input);
userData.getStream(image,use);

%>	
</body>
</html>