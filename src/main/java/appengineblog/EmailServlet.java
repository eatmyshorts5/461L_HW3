package appengineblog;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.sendgrid.Content;
import com.sendgrid.Email;
import com.sendgrid.Mail;
import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;




@SuppressWarnings("serial")
public class EmailServlet extends HttpServlet {

public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
{
	Email from = new Email("test@example.com");
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
    }
}

@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
{
	doGet(req, resp);
}

}