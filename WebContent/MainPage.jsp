<%@page import="db.data.Message"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@page import="java.sql.*"%>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Welcome to facebook</title>
<link rel="shortcut icon" href="pics/Facebook.ico">
<link rel="stylesheet" type="text/css" href="FacebookStyle.css" />
<script src="jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.9.3/typeahead.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	$('#profile').hide();
	$('#home').show();
	$('#msgLb').hide();
	$('#notiLb').hide();
	$('#notidiv').hide();
	$('#msgdiv').hide();
	
	if(sessionStorage.getItem('user_name') !== null){
	var logInUser = sessionStorage.getItem('user_name');
	var logInUserPassword = sessionStorage.getItem('password');

	var ops = [];
	var UserFriends = [];
	
	$.ajax({
        type : "POST",
        url : "UserDetails.jsp",
        data : "userName=" + logInUser ,
        dataType: 'json',
        success : function(json) { 
			$('#profilepics').append('<img class="backpic" alt="" src="'+json.coverImag+'"><img id="pp" class="prokpic" alt="" src="'+json.profilePicture+'">');
			$('#loginame').text('Hi '+json.firstName +' '+json.lastName);
			$('#proNamelb').text('Hi '+json.firstName +' '+json.lastName);		
	    }
    });
	  
	  $.ajax({
          type : "POST",
          url : "JsonObj.jsp",
          data : "userName=" + logInUser ,
          dataType: 'json',
          success : function(json) {
        	  var element = [];
        	  $.each(json, function(i, element){ //each post
        		  ops[i]=element.Name;
        		  UserFriends[element.Name] = element.userName;
  			})
  			$('#inputFriends').typeahead({
				name: 'accounts',
				local: ops
			});  
          }
      });
	
	
	  $( "#inputFriends" ).keypress(function(e) {
		  if (e.which == 13) {
			  var fullN = $( "#inputFriends" ).val();
			  if(fullN != "" && jQuery.inArray(fullN, ops) != -1){
			  location.href = "Profiles.jsp?uName="+UserFriends[fullN];
			  }
		  }
		});
	  
	  $.ajax({
          type : "POST",
          url : "UserMassage.jsp",
          data : "userName=" + logInUser ,
          dataType: 'json',
          success : function(json) {
          	var element = [];
          	var notiNum = 0;
  			$.each(json, function(index, element){
  				if(element.isread === 'no'){
  					notiNum++;
  				}
  			});
  			if(notiNum > 0){
				$('#msgLb').show();
				$('#msgLb').text(notiNum);
					
			}
          }
      });
	  
	  $.ajax({
		  type : "POST",
          url : "UserNotis.jsp",
          data : "userName=" + logInUser ,
          dataType: 'json',
          success : function(json) {
          	var element = [];
          	var num = 0;
  			$.each(json, function(index, element){
  				num++;
  			});
  			if(num > 0){
  				$('#notiLb').show();
  				$('#notiLb').text(num);		
			}
          }
      });

	$('#switchLb').click(function() {
		if(document.getElementById('myonoffswitch').checked){
		    $('#home').hide();
		    $('#profile').show();
		}
		else {
		    $('#profile').hide();
			$('#home').show();	
			
		}
	  });

	$('#massageIcon').click(function(){
		$('#msgdiv').toggle();
		$('#msgLb').hide();
		$('#msgLb').text('0');
		$('#msgdiv table').empty();
		$.ajax({
            type : "POST",
            url : "UserMassage.jsp",
            data : "userName=" + logInUser ,
            dataType: 'json',
            success : function(json) {
            	var element = [];
    			$.each(json, function(index, element){ 
    			       $('#msgdiv table').append('<tr><td><h4>' + element.from + ':</h4><p>'+ element.content +'</p></td>');
    			});
            }
        });
	});
	
	
	$('#notificationIcon').click(function(){
		$('#notidiv').toggle();
		$('#notiLb').hide();
		$('#notiLb').text('0');
		$('#notidiv ul').empty();
		$.ajax({
            type : "POST",
            url : "UserNotis.jsp",
            data : "userName=" + logInUser ,
            dataType: 'json',
            success : function(json) {
            	var element = [];
    			$.each(json, function(index, element){ 
    				$('#notidiv ul').append('<li>' + element.name +' '+ element.content +'</li>');
    			});
            }
        });
	});
	
	$.ajax({
        type : "POST",
        url : "UserOnlineFriends.jsp",
        data : "userName=" + logInUser ,
        success : function(data) {
        	$('#friends').append(data);
        }
    });
	
	setInterval(function(){
		if($('#friends ul').children().length >= 0){
		$('#friends ul').remove();
		}
		$.ajax({
	        type : "POST",
	        url : "UserOnlineFriends.jsp",
	        data : "userName=" + logInUser ,
	        success : function(data) {
	        	$('#friends').append(data);
	        }
	    });}, 10000);
	
	$.ajax({
        type : "POST",
        url : "UserFriendsList.jsp",
        data : "userName=" + logInUser ,
        success : function(data) {
        	$('#profilefriends').append(data);
        }
    });

		
	$.ajax({
        type : "POST",
        url : "UserPostsObj.jsp",
        data : "userName=" + logInUser ,
        dataType: 'json',
        success : function(json) {
      	  var element = [];
      	  var post = "";
      	  $.each(json, function(i, element){ //each post
      		post += '<div class="posts">' +
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
			$('#homePost').append(post);
        }
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
		        data : "userName=" + logInUser+"&toTheUser=" + logInUser+"&content=" + $('#postText').val() ,
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
		        	$('#homePost').prepend(post);
					$('#postText').val("");	
		        }
		    });
							
		}
		else{
			alert("Please enter post!");
		}
		
	});
	
	$('#nav6lo').click(function(){	
		sessionStorage.clear();
		$.ajax({
	          type : "POST",
	          url : "UserLogOut.jsp",
	          data : "userName=" + logInUser ,
	          success : function() {
 
	          }
	      });
	});
	
	$("form#picForm").submit(function() {
        var formData = new FormData($(this)[0]);

        $.ajax({
            url: 'SaveUserImage.jsp‬',
            type: 'POST',
            data: formData,
            async: false,
            success: function(data) {
                alert(data);
            },
            cache: false,
            contentType: false,
            processData: false
        });

        return false;
    });
	
	$('#pictureRequest').click(function() {
		$('#pictureRequest').val("");
	  });
	
	$('#pictureRequest').change(function() {
		
		  alert( $('#pictureRequest').val());
		var reader = new FileReader();
		reader.onload = function (e) {
		    $('#pp').attr('src', e.target.result);
		  }

		reader.readAsDataURL(this.files[0]);    
	});
	
	}else{
		$('#htmlBody').empty();
		$('#htmlBody').append('<h1>  Sorry You Must Be A Registered User To See This Page Content !! <a href="FormLogInValidation.html"> Back To LogIn</a></h1>');
	}
	
	
});

$(document).mouseup(function (e){
		    var container = $('#notidiv');
		    var container1 = $('#notidiv h3');
		    var container2 = $('#notidiv ul');
		    var container3 = $('#notidiv li');
		    var container4 = $('#notificationIcon');
		    var container5 = $('#notificationIcon img');
		    var container6 = $('#notificationIcon label');
		    if (!container.is(e.target) && !container1.is(e.target) && !container2.is(e.target) && !container3.is(e.target)
		    		&& !container4.is(e.target) && !container5.is(e.target) && !container6.is(e.target)){
		        container.hide();
		    }
});

$(document).mouseup(function (e){
    var container = $('#msgdiv');
    var container1 = $('#msgdiv h3');
    var container2 = $('#msgdiv table');
    var container3 = $('#msgdiv tr');
    var container4 = $('#msgdiv td');
    var container5 = $('#msgdiv h4');
    var container6 = $('#msgdiv p');
    var container7 = $('#massageIcon');
    var container8 = $('#massageIcon img');
    var container9 = $('#massageIcon label');
    if (!container.is(e.target) && !container1.is(e.target) && !container2.is(e.target) && !container3.is(e.target) && !container4.is(e.target)
    		&& !container5.is(e.target) && !container6.is(e.target) && !container7.is(e.target) && !container8.is(e.target) && !container9.is(e.target)){
        container.hide();
    }
});
function now(){
	
	var current_date = new Date();
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

</script>
</head>
<body id="htmlBody" class="frameBody">
	<div id="wrapper" class="bwrapper">
			<nav id="main-menu">
			<div id="n1">
				<a class="nav1" href="MainPage.jsp" rel="toggle"><img alt="" src="pics/Facebooklogoicon.png"></a>
				</div>
				<div class="onoffswitch">
                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch" checked="checked">
                <label id="switchLb" class="onoffswitch-label" for="myonoffswitch">
                   <span id="switch" class="onoffswitch-inner"></span>
                   <span class="onoffswitch-switch"></span>
                 </label>
                 </div>
				<div id="n4">
				<a id="massageIcon" class="nav4" href="#" rel="toggle"><img alt="" src="pics/blackenv.png"><label id="msgLb" class="message_bubble"></label></a>
				<div id="msgdiv" class="msgdiv1"><h3>Messages</h3><table class="msgtable"></table></div>
				</div>
				<div id="n5">
				<a id="notificationIcon" class="nav5" href="#" rel="toggle"><img alt="" src="pics/globeicon1.png"><label id="notiLb" class="noti_bubble"></label></a>
				<div id="notidiv" class="notidiv1"><h3>Notifications</h3><ul class="notiol"></ul></div>
				</div>
				<div id="n6">
				<label id="loginame" class="lin"></label><a id="nav6lo" class="nav6" href="FormLogInValidation.html" rel="toggle">Logout</a>
				</div>
			</nav>
		<div id="friends">
			<h2>Online friends <img alt="" src="pics/usericon.png"></h2>
			<div class="bs-example">
            <input id="inputFriends" type="text" class="typeahead tt-query" autocomplete="off" spellcheck="false" placeholder="Search For Friends">
            </div>
		</div>
		
		<div id="home">
		<div class="homeBody">
		 <label class="bodyLabel">What's on your mind? </label>
		 <input id="postText" name="file" class="bodyText" type="text"><input class="bodyButton" id="post_input" type="button" value="Post"/>
		 </div> 
         <div id="homePost" class="homePosts">
         </div>
		</div>
		
		<div id="profile">
		<div id="profilepics" class="propics">
		</div> 
		<label id="proNamelb" class="proName"></label><form id="picForm" action="upload" method="post" enctype="multipart/form-data"><input accept="image/*" class="requestBtn" id="pictureRequest" type="file" value="Choose Picture..."/><input type="submit" value="send"/></form>
		<div id="profilefriends" class="profriends">
		<h2 class="loft">List of friends</h2>

		</div>
		</div>
		</div>
			<footer id="footerf" class="foot"> Copyright © Aviad Ben Hayun And Itamar Frenkel </footer>
			

</body>
</html>