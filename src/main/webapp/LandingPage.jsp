<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="appengineblog.Blogger" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ page import="static com.googlecode.objectify.ObjectifyService.ofy" %>

<%@ page import="java.util.Collections" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script src="https://apis.google.com/js/platform.js" async defer></script>
		<title>Exam Results</title>
	</head>
	
	<body>
		<h1>
			THE BLOG!!!!!!
			<a style = "align:left" href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
		</h1>
	</body>





</html>