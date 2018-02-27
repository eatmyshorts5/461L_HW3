package appengineblog;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Subscriber {
	@Id Long id;
	User user;
	
	private Subscriber() {}
	
	public Subscriber(User user)
	{
		this.user = user;
	}

	public String getEmail() {
		return user.getEmail();
	}
	
	public User getUser() {
		return user;
	}
	
	public Long getId() {
		return id;
	}

}
