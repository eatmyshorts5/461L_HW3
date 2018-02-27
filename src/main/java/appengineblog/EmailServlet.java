package appengineblog;
import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.*;


import com.googlecode.objectify.ObjectifyService;


@SuppressWarnings("serial")
public class EmailServlet extends HttpServlet {
	
	static
	{
		ObjectifyService.register(Subscriber.class);
		ObjectifyService.register(BlogPost.class);
	}

public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
{
	/*Email from = new Email("test@example.com");
    String subject = "Sending with SendGrid is Fun";
    Email to = new Email("test@example.com");
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
    }*/
	
	List<Subscriber> subscribers = ofy().load().type(Subscriber.class).list();
	
	// Recipient's email ID needs to be mentioned.
    //String to = "chandaarka@yahoo.com";

    // Sender's email ID needs to be mentioned
    String from = "arka.chanda2752@gmail.com";

    // Assuming you are sending email from localhost
    String host = "localhost";

    // Get system properties
    //Properties properties = System.getProperties();

    // Setup mail server
    //properties.setProperty("mail.smtp.host", host);
    Properties props = new Properties();
    // Get the default Session object.
    Session session = Session.getDefaultInstance(props, null);
    for(Subscriber sub :  subscribers){
		String to = sub.getUser().getEmail();
    try {
       // Create a default MimeMessage object.
       MimeMessage message = new MimeMessage(session);

       // Set From: header field of the header.
       message.setFrom(new InternetAddress(from));

       // Set To: header field of the header.
       message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

       // Set Subject: header field
       message.setSubject("New Blog Posts!! :)");
       String mes = null;
       // Now set the actual message
       List<BlogPost> posts = ofy().load().type(BlogPost.class).list();
       Date yes = new Date();
       long current = yes.getTime();
       for(BlogPost meme : posts){
    	   if((current - meme.getDate().getTime()) < 86400000)
    	   {
    		   mes = mes + meme.getPost() + "/n/n";
    	   }
       }
       if(mes.equals(null)){return;}
       message.setText(mes); 

       // Send message
       Transport.send(message);
       System.out.println("Sent message successfully....");
    } catch (MessagingException mex) {
       mex.printStackTrace();
    }
    }
}

@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
{
	doGet(req, resp);
}

}