package appengineblog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.List;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.prospectivesearch.ProspectiveSearchPb.SubscribeRequest;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

public class SubServlet extends HttpServlet {
	
	static {

	    ObjectifyService.register(Subscriber.class);

	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
        
        User user = userService.getCurrentUser();
        
        Subscriber subscriber = new Subscriber(user);
        
        ofy().save().entity(subscriber).now();
        
        resp.sendRedirect("/LandingPage.jsp");
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
        
        User user = userService.getCurrentUser();
        
        List<Subscriber> subscribers = ofy().load().type(Subscriber.class).list();
        
        for(Subscriber sub: subscribers) {
        	
        	if(sub.getUser().equals(user)) {
        		ofy().delete().entity(sub).now();
        	}
        }
        
        resp.sendRedirect("/LandingPage.jsp");
	}
}
