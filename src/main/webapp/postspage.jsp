<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
		<link rel="stylesheet" href="hw3_prac.css">
		<script src="https://apis.google.com/js/platform.js" async defer></script>
		<title>The Blog</title>
	</head>
	
	<body class="background1">
	
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
	    
	<div class="transbox" style="">
		<h1>
			<img id="headpic" class="headerpic" style="visibility:visible" src="tenor.gif">
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
		<a href="<%=userService.createLoginURL(request.getRequestURI()) %>"><img id="signimg" src="btn_google_signin_dark_pressed_web.png"></a>
		</p>
		<%}%>
		</h1>
	</div>
		
	<div class="transbox">	
		<%
	ObjectifyService.register(BlogPost.class);
	
	List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();   
	
	Collections.sort(posts);
	Collections.reverse(posts);
	
	int hold = 0;
	
	for (BlogPost post : posts){
		pageContext.setAttribute("post_content", post.getPost());
		pageContext.setAttribute("post_title", post.getTitle());
		pageContext.setAttribute("post_date", post.getDate());
		if(post.getUser() == null){
			pageContext.setAttribute("post_user", "Anonymous");
		} else {
			pageContext.setAttribute("post_user", post.getUser().getNickname());
		}
	%>	
		<div id="title<%Integer.toString(hold);%>" class="title">${fn:escapeXml(post_title)}</div><br>
		<div id="head<%Integer.toString(hold);%>" class="posthead">by ${fn:escapeXml(post_user)}, posted on ${fn:escapeXml(post_date)}</div>
		<br><br>
		<div id="post<%Integer.toString(hold);%>" class="post"><pre style="white-space: pre-wrap;">${fn:escapeXml(post_content)}</pre></div>
		<br>
		<br><div id="colorstrip"></div><br><br>
		<%hold += 1;
	}%>
	<br><br>	
	
	<% 
		if(user != null){		
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
<% 			}
		} 
%>
	<br><br>
	<form action="/LandingPage.jsp" method="get">
			<input type="submit" class="butt" value="Home">
	</form>
	
	<script>
		var headlink = document.getElementById("headlink");
		headlink.style.marginLeft = (document.documentElement.scrollWidth * 0.425 - headlink.offsetWidth)+"px";
	</script>
	</div>
	</body>





</html>