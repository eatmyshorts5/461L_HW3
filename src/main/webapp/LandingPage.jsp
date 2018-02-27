<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="appengineblog.BlogPost" %>

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
%>
	    
	
		<h1>
			THE BLOG!!!!!!
<% 
			if(user != null){
	    	
	    		pageContext.setAttribute("user", user);
	
%>
			<p>Signed in as ${fn:escapeXml(user.nickname)}
			<br>
			Click here to <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a>
<% 
			} else {
%>
			<p>Hello Guest<br>
			Please <a style = "align:left" href="<%=userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
			<%}%>
		</h1>
		
		<p>${fn:escapeXml(bloggerName)}</p>
		
		<%
	ObjectifyService.register(BlogPost.class);
	
	List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();   
	
	Collections.sort(posts);
	
	int hold = 0;
	
	
	
	for (BlogPost post : posts){
		pageContext.setAttribute("post_content", post.getPost());
		pageContext.setAttribute("post_title", post.getTitle());
	%>	
		<div id="title<%Integer.toString(hold);%>" class="title">${fn:escapeXml(post_title)}</div>
		<div id="post<%Integer.toString(hold);%>">${fn:escapeXml(post_content)}</div>
		<br>
		<%hold += 1;
	}%>
		
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
<% 
		} else {
			
			
		}
%>
		
	</body>





</html>