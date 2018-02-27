package appengineblog;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.*;





@SuppressWarnings("serial")
public class EmailServlet extends HttpServlet {

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
	// Recipient's email ID needs to be mentioned.
    String to = "chandaarka@yahoo.com";

    // Sender's email ID needs to be mentioned
    String from = "chandaarka@yahoo.com";

    // Assuming you are sending email from localhost
    String host = "localhost";

    // Get system properties
    //Properties properties = System.getProperties();

    // Setup mail server
    //properties.setProperty("mail.smtp.host", host);
    Properties props = new Properties();
    // Get the default Session object.
    Session session = Session.getDefaultInstance(props, null);

    try {
       // Create a default MimeMessage object.
       MimeMessage message = new MimeMessage(session);

       // Set From: header field of the header.
       message.setFrom(new InternetAddress(from));

       // Set To: header field of the header.
       message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

       // Set Subject: header field
       message.setSubject("This is the Subject Line!");

       // Now set the actual message
       message.setText("This is actual message");

       // Send message
       Transport.send(message);
       System.out.println("Sent message successfully....");
    } catch (MessagingException mex) {
       mex.printStackTrace();
    }
}

@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
{
	doGet(req, resp);
}

}