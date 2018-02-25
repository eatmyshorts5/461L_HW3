package appengineblog;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class BlogPost implements Comparable<BlogPost>{
	@Parent Key<Blogger> bloggerName;
		@Id Long id;
		@Index User user;
		@Index String title;
		@Index String post;
		@Index Date date;
		
		private BlogPost() {
			
		}
		
		public BlogPost(User user, String title, String post) {
			this.user = user;
			this.title = title;
			this.post = post;
			date = new Date();
		}
		
		public User getUser() {
			return user;
		}
		
		public String getTitle() {
			return title;
		}
		
		public String getPost() {
			return post;
		}
		
		@Override
	    public int compareTo(BlogPost other) {
	        if (date.after(other.date)) {
	            return 1;
	        } else if (date.before(other.date)) {
	            return -1;
	        }
	        return 0;
	    }
	

}
