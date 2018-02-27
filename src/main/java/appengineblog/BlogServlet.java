package appengineblog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;
import com.sendgrid.Content;
import com.sendgrid.Email;
import com.sendgrid.Mail;
import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;

public class BlogServlet extends HttpServlet {
	
	static {

	    ObjectifyService.register(BlogPost.class);

	}
	
	private static final Logger _logger = Logger.getLogger(BlogServlet.class.getName());
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
			try {
			_logger.info("Cron Job has been executed");
			//Put your logic here
			//BEGIN
			
			Email from = new Email("test@example.com");
		    String subject = "Sending with SendGrid is Fun";
		    Email to = new Email("chandaarka@yahoo.com");
		    Content content = new Content("text/plain", "and easy to do anywhere, even with Java");
		    Mail mail = new Mail(from, subject, to, content);
		    
		    SendGrid sg = new SendGrid(System.getenv("SENDGRID_API_KEY"));
		    Request request = new Request();
		    try {
		      request.setMethod(Method.POST);
		      request.setEndpoint("mail/send");
		      request.setBody(mail.build());
		      Response response = sg.api(request);
		      System.out.println(response.getStatusCode());
		      System.out.println(response.getBody());
		      System.out.println(response.getHeaders());
		    } catch (IOException ex) {
		      throw ex;
		    }
		    
			//END
			}
			catch (Exception ex) {
			//Log any exceptions in your Cron Job
			}
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
	
	public void doRedirect(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		
	}
	
}