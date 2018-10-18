<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>facebook friends</title>
<link rel="shortcut icon" href="pics/Facebook.ico">
<link rel="stylesheet" type="text/css" href="FacebookStyle.css" />
<script src="jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {

$('#request').hide();

	
var logInUser = sessionStorage.getItem('user_name');

$.ajax({
    type : "POST",
    url : "UserDetails.jsp",
    data : "userName=" + friendUserName ,
    dataType: 'json',
    success : function(json) { 
		$('#profilepics').append('<img class="backpic" alt="" src="'+json.coverImag+'"><img class="prokpic" alt="" src="'+json.profilePicture+'">');
		$('#postName').before('Post on '+json.firstName +' '+json.lastName+' Wall?');
		$('#proNamelb').text(json.firstName +' '+json.lastName);		
}
});

$.ajax({
    type : "POST",
    url : "IsFriends.jsp",
    data : "userName=" + logInUser +"&friendUserName=" + friendUserName ,
    dataType: 'json',
    success : function(json) {
    	if(json.isFriend === 'no'){
    		$('#request').show();
    		$('#fpp').hide();
    	}

    }
});

$.ajax({
    type : "POST",
    url : "UserPostsObj.jsp",
    data : "userName=" + friendUserName ,
    dataType: 'json',
    success : function(json) {
    // if(json !== undefined){	
  	  var element = [];
  	  var post = "";
  	  $.each(json, function(i, element){ //each post
  		post += '<div class="Posts">' +
		'<label>Post by: ' + element.postby +' - '+nowDate(element.date)+'</label>' +
		'<p>'+ element.content +'</p>' +
		'<div>Like comments' +
			'<a class="show_comments" href="#" rel="toggle" role="button">Show/Hide comments</a>' +
		'</div>';
		
  		var ul = '<div class="comments"><input name="'+ element.postId +'" class="commentText" type="text" placeholder="Add Comment"><ul>';	
		$.each(element.comments , function(index, obj){ //each comment	
			if(obj.name !== undefined){
			ul+='<li>' + obj.name +': '+ obj.comment +'</li>';
			}
		})
		ul += '</ul></div></div>';	
		post += ul;
		
		})
		$('#friendsPost').append(post);
   // }
    // alert("noob");
    }
});

$('#request').click(function(){	
$.ajax({
    type : "POST",
    url : "AddNewFriend.jsp",
    data : "userName=" + logInUser +"&friendUserName=" + friendUserName ,
    dataType: 'json',
    success : function(json) {
    	if(json.isFriend === 'yes'){
      		$('#request').hide();
      		$('#fpp').show();
      		alert("congratulations you are now friend with "+json.Name);
      	}
     }
   });
 });
 
 
$(document).on('click','.show_comments', function() {
	$(this).parent().parent().find('div:last').slideToggle("slow");
	});
	

$(document).on('keypress','.commentText', function(e) {	
	  if (e.which == 13) {
		if($(this).parent().parent().find('input').val() !== ''){  
		  var id = $(this).parent().parent().find('input').attr("name");
		  var comment = $(this).parent().parent().find('input').val();
		  var $ul = $(this).parent().parent().find('ul');
		  $.ajax({
		        type : "POST",
		        url : "AddNewComment.jsp",
		        data : "byUser=" + logInUser+"&postId=" +id+"&content=" + comment ,
		        dataType: 'json',
		        success : function(json) {
		        	var element = [];
		         $.each(json, function(i, element){ 
		        	 $ul.append('<li>' + element.name +': '+ element.comment +'</li>');
		        	 
		         })
		        
		        }
		    });
		 $(this).parent().parent().find('input').val(""); 
	  }else{
			alert("Please enter comment!");
		}	
	  }
});

$('#post_input').click(function(){	
if($('#postText').val() != ''){
	$.ajax({
      type : "POST",
      url : "AddNewPost.jsp",
      data : "userName=" + logInUser+"&toTheUser=" + friendUserName+"&content=" + $('#postText').val() ,
      dataType: 'json',
      success : function(json) {
      	var element = [];
      	var	post = "";
       $.each(json, function(i, element){ //each post
      post += '<div class="posts">' +
			'<label>Post by: ' + element.postby +' - '+nowDate(element.date)+'</label>' +
			'<p>'+ element.content +'</p>' +
			'<div>Like comments' +
				'<a class="show_comments" href="#" rel="toggle" role="button">Show/Hide comments</a>' +
			'</div><div class="comments"><input name="'+ element.postId +'" class="commentText" type="text" placeholder="Add Comment"><ul></ul></div></div>';
      	  })
      	$('#friendsPost').prepend(post);
			$('#postText').val("");	
      }
  });
					
}
else{
	alert("Please enter post!");
  }
 });
 

});

function nowDate(date){
	
	var current_date = new Date(date);
	var dateFormat = "";
	month_value = current_date.getMonth();
	day_value = current_date.getDate();
	year_value = current_date.getFullYear();

	var months = new Array(12);
	months[0] = "January";
	months[1] = "February";
	months[2] = "March";
	months[3] = "April";
	months[4] = "May";
	months[5] = "June";
	months[6] = "July";
	months[7] = "August";
	months[8] = "September";
	months[9] = "October";
	months[10] = "November";
	months[11] = "December";
	
	dateFormat += months[month_value] + " " +day_value + " " + year_value;
	
	return dateFormat;
}

function getUser(){
	return dateFormat;
}
</script>

</head>
<body id="htmlBody" class="frameBody">
<%   
String userName = request.getParameter("uName");
%>
	<script> 
	var friendUserName = "<%=userName %>";
	</script>
	<div id="fwrapper" class="bwrapper">
			<nav id="main-menu">
			<div id="n1">
				<a class="nav1" href="MainPage.jsp" rel="toggle"><img alt="" src="pics/Facebooklogoicon.png"></a>
				</div>
				<div id="n7">
				<label id="loginame" class="lin"></label><a class="nav6" href="MainPage.jsp" rel="toggle">Back To Profile</a>
				</div>
			</nav>
		<div id="profile">
		<div id="profilepics" class="propics">
		</div>
		<div class="naabdiv"><label id="proNamelb" class="fproName"></label><input class="requestBtn" id="request" type="button" value="Send friend request?"/></div>
		<div id="fpp" class="friendProPosts">
		<div class="profilePosts">
		 <label id="postName" class="bodyLb"><input id="postText" class="bodyTxt" type="text"><input class="bodyBtn" id="post_input" type="button" value="Post"/></label>
		 </div> 
         <div id="friendsPost" class="friendshomePosts">
         </div>
         </div>
		</div>
		</div>
	<footer id="footerf" class="foot"> Copyright © Aviad Ben Hayun And Itamar Frenkel </footer>
</body>
</html>