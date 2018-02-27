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
		<link rel="stylesheet" href="test.css">
		<script src="https://apis.google.com/js/platform.js" async defer></script>
		<title>A BRAND NEW BLOG</title>
	</head>
	
	<body>
	
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
	    
		<div class="transbox">
		<h1>
			<p class="headtitle">THE BLOG!!!!!!</p>
<% 
			if(user != null){
	    	
	    		pageContext.setAttribute("user", user);
	
%>
			<p class="signin">Signed in as ${fn:escapeXml(user.nickname)}
			<br>
			Click here to <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a></p>
<% 
			} else {
%>
			<p class="signin">
			Please <a style = "align:right" href="<%=userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
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
	
	int sizer = 5;
	
	if(posts.size() < 5){
		sizer = posts.size();
	}
	
	int hold = 0;
	
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
		%>	
			<div id="title<%Integer.toString(hold);%>" class="title">${fn:escapeXml(post_title)}</div>
			<div id="head<%Integer.toString(hold);%>">by ${fn:escapeXml(post_user)}, posted on ${fn:escapeXml(post_date)}</div>
			<br>
			<div id="post<%Integer.toString(hold);%>">${fn:escapeXml(post_content)}</div>
			<br>
			<%hold += 1;
		}
	}%>
		<form action="/postspage.jsp" method="get">
			<input type="submit" value="View All">
		</form><br><br>
<% 
		if(user != null){
%>
		<form name="formarea" action="appengineblog" method="post">
			<input type="text" name="title">
			<br>
			<textarea name="post" rows="4" cols="50">
				 
			</textarea><br>
			<input type="submit" value="Post">
			<input type="hidden" name="bloggerName" value="${fn:escapeXml(bloggerName)}"/>
		</form>
		<br>
<%		
		if(subscribed == false){%>
			<form name="subarea" action="subscribe" method="post">
				<input type="submit" value="Subscribe">
			</form>
		<% 
		} else {
		%>
			<form name="unsubarea" action="subscribe" method="get">
				<input type="submit" value="Unsubscribe">
			</form>
<% 		}
		} else {%>
			Please <a href="<%=userService.createLoginURL(request.getRequestURI()) %>">Sign in</a> to post
		<%}
%>
		</div>
<!--  	<input type="submit" value="subscribe" href=-->
			
	</body>





</html>