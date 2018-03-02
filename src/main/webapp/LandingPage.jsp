<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="appengineblog.*" %> 

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="appengineblog.BlogPost" %>

<%@ page import="appengineblog.Subscriber" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ page import="static com.googlecode.objectify.ObjectifyService.ofy" %>

<%@ page import="java.util.Collections" %>

<%@ page import="java.lang.Integer" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		<script type="text/javascript" src="hw3_prac.js"></script>
		<link rel="stylesheet" href="hw3_prac.css">
		<%--<meta name="google-signin-client_id" content="909316987604-dc065603r3u64qfmdmm96aubrkltoo7f.apps.googleusercontent.com">--%><meta name="google-signin-client_id" content="909316987604-dc065603r3u64qfmdmm96aubrkltoo7f.apps.googleusercontent.com">
		<link rel="stylesheet" href="test.css">
		<script src="https://apis.google.com/js/platform.js" async defer></script>
		<title>The Blog</title>
	</head>
	
	<body id="ohyeah" class="background">
	
	
	<script>
    function onSuccess(googleUser) {
      console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
      userService.createLoginURL(request.getRequestURI());
    }
    function onFailure(error) {
      console.log(error);
    }
    function renderButton() {
      gapi.signin2.render('my-signin2', {
        'scope': 'profile email',
        'width': 240,
        'height': 50,
        'longtitle': true,
        'theme': 'dark',
        'onsuccess': onSuccess,
        'onfailure': onFailure
      });
    }
  </script>

  <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
	
	
	
<%

	    String bloggerName = request.getParameter("bloggerName");
	
	    if (bloggerName == null) {
	
	        bloggerName = "default";
	
	    }
	    
	
	    pageContext.setAttribute("bloggerName", bloggerName);
	    
	    UserService userService = UserServiceFactory.getUserService();

	    User user = userService.getCurrentUser();
	    
	    ObjectifyService.register(Subscriber.class);
	    
	    boolean subscribed = false;
	    
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
        
		
		
        for(Subscriber sub: subscribers) {
        	
        	System.out.println(sub.getUser().getEmail());
        	
        	if(sub.getUser().equals(user)) {
        		subscribed = true;
        	}
        }
%>
	    
	    <div id="fullscreen" class="fullscreen-bg">
			<video id="thevid" class="fullscreen-bg__video">
				<source src="static4.mp4" type="video/mp4">
			</video>
			<video id="thevid2" class="fullscreen-bg__video">
				<source src="space.mp4" type="video/mp4">
			</video>
			<p class="meme" id="thisisdumb">
	    		Dedicated to:<br> Colin Maxfield<br><br>
	    		1992-2018<br><br>
	    		"He was alright" -Mahatma Gandhi<br><br>
	    		<form id="restart" action="/LandingPage.jsp" method="get">
					<input type="submit" class="butt" id="restart1" value="Let's try that again....">
				</form>
			</p>
		</div>

	    
	    
		<input type="range" min="-1" max="85" value="-1" class="overslider" id="myRange"> 
  		<input type="range" min="-1" max="150" value="0" class="verticalslide" id="myRange2">

	    
	    
		<div id="thebox">
		<h1>
			<img id="headpic" class="headerpic" src="tenor.gif">
		
			<a href="LandingPage.jsp" id="headlink" class="headtitle">THE BLOG</a></p>
<% 
			if(user != null){
	    		pageContext.setAttribute("user", user);
	
%>
			<input type="hidden" name="logged in?" id="loginval" value="false">
			<p class="signin">Signed in as ${fn:escapeXml(user.nickname)}
			<br>
			Click here to <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a></p>
<% 
			} else {
%>
			<input type="hidden" name="logged in?" id="loginval" value="true">	
			<p class="signin">
			<a href="<%=userService.createLoginURL(request.getRequestURI()) %>"><img id="signimg"></a>
			</p>
			<%}%>
		</h1>
		</div>
		
		<div id="thebox2">
		<%
	ObjectifyService.register(BlogPost.class); 
		
	//Run this comment block if you want to delete all posts
	/*List<Key<BlogPost>> keys = ObjectifyService.ofy().load().type(BlogPost.class).keys().list();
	
	ofy().delete().keys(keys).now();*/
	
	List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();  
	
	Collections.sort(posts);
	Collections.reverse(posts);
		
	pageContext.setAttribute("numposts", Integer.toString(posts.size()));
	
	int sizer = 5;
	
	if(posts.size() < 5){
		sizer = posts.size();
	}
	
	int hold = 0;
	String holder;
	
	if(posts.isEmpty()){
		
		
	} else {
		for(int i = 0; i < sizer; i++){
			BlogPost post = posts.get(i);
			pageContext.setAttribute("post_content", post.getPost());
			pageContext.setAttribute("post_title", post.getTitle());
			pageContext.setAttribute("post_date", post.getDate());
			if(post.getUser() == null){
				pageContext.setAttribute("post_user", "Anonymous");
			} else {
				pageContext.setAttribute("post_user", post.getUser().getNickname());
			}
			holder = Integer.toString(hold);
			pageContext.setAttribute("holder", holder);
		%>	
			<div id="title${fn:escapeXml(holder)}">${fn:escapeXml(post_title)}</div><br>
			<div id="head${fn:escapeXml(holder)}">by ${fn:escapeXml(post_user)}, posted on ${fn:escapeXml(post_date)}</div>
			<br><br>
			<div><pre id="post${fn:escapeXml(holder)}" class="post1">${fn:escapeXml(post_content)}</pre></div>
			<br>
			<br><div id="colorstrip"></div><br><br>
			
			<%hold += 1;
		}
	}%>
		<form action="/postspage.jsp" method="get">
			<input type="submit" class="butt" value="View All">
		</form><br><br>
<% 
		if(user != null){
		
%>		<p id="posterhead">Post a Blog<p>
		<form id="formarea" action="appengineblog" method="post" style="margin-top: 50px; margin-bottom: 25px">
			<label>
				<p id="Error"></p>
			</label>
			<label>
				Title<br>
				<input type="text" name="title" id="titlefield" size="50" placeholder="Enter Title Here">
			</label>
			<div style="vertical-align: middle">
				<label>
					Post<br>
					<textarea name="post" id="postfield" rows="20" cols="90" placeholder="Enter Post Here"></textarea>
				</label>
			</div>
			<label>
				<input type="button" class="butt" value="Post" onclick="checkerror()">
			</label>
			<input type="hidden" name="bloggerName" value="${fn:escapeXml(bloggerName)}"/>
		</form>
		<br>
<%		
		if(subscribed == false){%>
			<form name="subarea" action="subscribe" method="post">
				<input type="submit" class="butt" value="Subscribe">
			</form>
		<% 
		} else {
		%>
			<form name="unsubarea" action="subscribe" method="get">
				<input type="submit" class="butt" value="Unsubscribe">
			</form>
<% 		}
		} else {%>
			Please <a href="<%=userService.createLoginURL(request.getRequestURI()) %>">Sign in</a> to post
		<%}
%>
		<input type="hidden" name="number of posts" id="postnum" value="${fn:escapeXml(numposts)}">
		</div>

  	<input type="range" min="0" max="200" value="0" class="downslide" id="myRange3">
  	<input type="range" min="0" max="100" value="100" class="verticalslide" id="myRange4">
  	
  	<form id="hiddenform" action="/LandingPage.jsp" method="get">
		<input type="hidden">
	</form>
  	
  	<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>

			
</body>





</html>