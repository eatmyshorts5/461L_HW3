package appengineblog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.*;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import appengineblog.BlogPost;

public class BlogServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		/*UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if(user == null){
			resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
		}*/
		 //String guestbookName = req.getParameter("guestbookName");

	        //Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

	        //String content = req.getParameter("content");

	        Date date = new Date();
	        UserService userService = UserServiceFactory.getUserService();
	        User user = userService.getCurrentUser();
	        BlogPost bpost = new BlogPost(user, req.getParameter("title").toString(), req.getParameter("post").toString());
	        
	        //ofy().save().entity(bpost).now();
	}
}