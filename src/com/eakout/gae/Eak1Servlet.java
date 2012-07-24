package com.eakout.gae;

import java.io.IOException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.util.Date;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class Eak1Servlet extends HttpServlet {
    private static final Logger log =
            Logger.getLogger(Eak1Servlet.class.getName());

/*	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");
	}  */

    @Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	            throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        // We have one entity group per Guestbook with all Greetings residing
        // in the same entity group as the Guestbook to which they belong.
        // This lets us run an ancestor query to retrieve all Greetings for a
        // given Guestbook. However, the write rate to each Guestbook should be
        // limited to ~1/second.
        String guestbookName = req.getParameter("guestbookName");
        Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);
        String content = req.getParameter("content");
        Date date = new Date();

        /*Entity greeting = new Entity("Greeting", guestbookKey);
        greeting.setProperty("user", user);
        greeting.setProperty("date", date);
        greeting.setProperty("content", content);

        DatastoreService datastore =
                DatastoreServiceFactory.getDatastoreService();
        datastore.put(greeting);
*/
        
        Entity quote = new Entity("Greeting", guestbookKey);
        quote.setProperty("user", user);
        quote.setProperty("date", date);
        quote.setProperty("category", date);
        quote.setProperty("content", content);

        DatastoreService datastore =
                DatastoreServiceFactory.getDatastoreService();
        datastore.put(quote);
        
        resp.sendRedirect("/guestbook.jsp?guestbookName="
                + guestbookName);
    }

}
