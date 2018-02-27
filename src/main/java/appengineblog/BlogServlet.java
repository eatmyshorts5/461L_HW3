package appengineblog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.*;
import javax.swing.plaf.synth.Region;

import com.google.appengine.api.datastore.DatastoreService;

import com.google.appengine.api.datastore.DatastoreServiceFactory;

import com.google.appengine.api.datastore.Entity;

import com.google.appengine.api.datastore.Key;

import com.google.appengine.api.datastore.KeyFactory;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;

import static com.googlecode.objectify.ObjectifyService.ofy;

import appengineblog.BlogPost;

public class BlogServlet extends HttpServlet {
	
	static {

	    ObjectifyService.register(BlogPost.class);

	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		/*UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if(user == null){
			resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
		}*/
		 //String guestbookName = req.getParameter("guestbookName");

	        //Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

	        //String content = req.getParameter("content");

	        UserService userService = UserServiceFactory.getUserService();
	        User user = userService.getCurrentUser();
	        //BlogPost bpost = new BlogPost(user, req.getParameter("title").toString(), req.getParameter("post").toString());
	        
	        String bloggerName = req.getParameter("bloggerName");
	        
	        System.out.println(bloggerName);
	        
	        Key bloggerKey = KeyFactory.createKey("Blogger", bloggerName);
	        
	        String title = req.getParameter("title");
	        
	        String post = req.getParameter("post");
	        
	        Date date = new Date();
	        
	        Entity blogpost = new Entity("BlogPost", bloggerKey);
	        
	        blogpost.setProperty("user", user);
	        
	        blogpost.setProperty("date", date);
	        
	        blogpost.setProperty("title", title);
	        
	        blogpost.setProperty("post", post);
	        
	        ofy().save().entity(blogpost).now();
	        
	        resp.sendRedirect("/LandingPage.jsp");
	   
	}
}