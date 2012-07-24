<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>


<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" >
$(document).ready(function()
{
$(".account").click(function()
{
var X=$(this).attr('id');

if(X==1)
{
$(".submenu").hide();
$(this).attr('id', '0');	
}
else
{

$(".submenu").show();
$(this).attr('id', '1');
}
	
});

//Mouseup textarea false
$(".submenu").mouseup(function()
{
return false
});
$(".account").mouseup(function()
{
return false
});


//Textarea without editing.
$(document).mouseup(function()
{
$(".submenu").hide();
$(".account").attr('id', '');
});
	
});
	
	</script>
<style>
body
{
background-color:#e4e8ec;
font-family:arial;
}

div.dropdown {
color: #555;
margin: 3px -22px 0 0;
width: 143px;
position: relative;
height: 17px;
text-align:left;
}
div.submenu
{
background: #fff;
position: absolute;
top: -12px;
left: -20px;
z-index: 100;
width: 135px;
display: none;
margin-left: 10px;
padding: 40px 0 5px;
border-radius: 6px;
box-shadow: 0 2px 8px rgba(0, 0, 0, 0.45);
}

.dropdown  li a {
   
    color: #555555;
    display: block;
    font-family: arial;
    font-weight: bold;
    padding: 6px 15px;
  cursor: pointer;
text-decoration:none;
}

.dropdown li a:hover{
    background:#155FB0;
    color: #FFFFFF;
    text-decoration: none;
    
}
a.account {
font-size: 11px;
line-height: 16px;
color: #555;
position: absolute;
z-index: 110;
display: block;
padding: 11px 0 0 20px;
height: 28px;
width: 121px;
margin: -11px 0 0 -10px;
text-decoration: none;
background: url(icons/arrow.png) 116px 17px no-repeat;
cursor:pointer;
}
.root
{
list-style:none;
margin:0px;
padding:0px;
font-size: 11px;
padding: 11px 0 0 0px;
border-top:1px solid #dedede;
	
	
}

</style>





<html>
  <head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />

	<title>Eakout Quotes - Punch in your favorite quotes, see the famous, infamous or whatever others are eaking about.</title>
	<meta name="description" content="Quotes of any kind to to search, add your own, and share."/> 
	<meta property="title" content="Punch in your favorite quotes, see the famous, infamous or whatever others are eaking about." /> 

  </head>

  <body>

<%
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
%>
<p>Hello, <%= user.getNickname() %>! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to include your name with greetings you post.</p>
<%
    }
%>

<%
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key quoteKey = KeyFactory.createKey("Quote", guestbookName);
    // Run an ancestor query to ensure we see the most up-to-date
    // view of the Greetings belonging to the selected Guestbook.
    Query query = new Query("Quote", quoteKey).addSort("date", Query.SortDirection.DESCENDING);
    List<Entity> quotes = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
    if (quotes.isEmpty()) {
        %>
        <p>Eak Quotes '<%= guestbookName %>' has no messages.</p>
        <%
    } else {
        %>
        <p>Messages in Eak '<%= guestbookName %>'.</p>
        <%
        for (Entity quote : quotes) {
            if (quote.getProperty("user") == null) {
                %>
                <p>An anonymous person wrote:</p>
                <%
            } else {
                %>
                <p><b><%= ((User) quote.getProperty("user")).getNickname() %></b> wrote:</p>
                <%
            }
            %>
            <blockquote><%= quote.getProperty("content") %></blockquote>
            <%
        }
    }
%>

	<div style='margin:50px'>
	
	<div class="dropdown">
	<a class="account" >
	<span>My Account</span>
	</a>
	<div class="submenu" style="display: none; ">

	  <ul class="root">
<li >
	      <a href="#Dashboard" >Dashboard</a>
	    </li>

	    
	    <li >
	      <a href="#Profile" >Profile</a>
	    </li>
	   <li >

	      <a href="#settings">Settings</a>
	    </li>
	   

	    <li>
	      <a href="#feedback">Send Feedback</a>
	    </li>



	    <li>
	      <a href="#signout">Sign Out</a>
	    </li>
	  </ul>
	</div>
	</div>
	
	</div>







    <form action="/sign" method="post">
      <div><textarea name="content" rows="3" cols="60"></textarea></div>
		<div>
         <select name="lstDropDown_A" id="lstDropDown_A" style="" onKeyDown="fnKeyDownHandler_A(this, event);" onKeyUp="fnKeyUpHandler_A(this, event); return false;" onKeyPress = "return fnKeyPressHandler_A(this, event);"  onChange="fnChangeHandler_A(this);" onFocus="fnFocusHandler_A(this);">
              <option value="" style="font-family:Courier,monospace;color:#ff0000;background-color:#ffff00;">--?--</option> <!-- This is the Editable Option -->
              <option>Editable Dropdown</option>
              <option>Combobox</option>
              <option>Left Aligned</option>
              <option>VARIABLE WIDTH</option>
              <option>Left To Right Flow</option>
            </select>
		</div>
	
      <div><input type="submit" value="Post Quote" /></div>
      <input type="hidden" name="guestbookName" value="<%= guestbookName %>"/>
    </form>

  </body>
</html>