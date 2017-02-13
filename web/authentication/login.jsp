<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="/HF_170216_JSP/style.css" />
    <link rel="stylesheet" type="text/css" href="./login.css" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
  </head>
  <body>
    <%
    String loginMessage=(String)request.getAttribute("loginmessage");
    //request.removeAttribute("loginmessage");
    
    if(!auth.isLogedin()) {%>
    <div class="wrapper">
      <form class="form-signin" action="loginProcess.jsp" method="post">       
        <h2 class="form-signin-heading">Please login</h2>
        <input type="text" class="form-control" name="username" placeholder="Username" required="" autofocus="" value="${param.username}"/>
        <input type="password" class="form-control" name="password" placeholder="Password" required=""/>
        <div class="message">
          <% if(loginMessage!=null) {
            out.print(loginMessage);
          } %>
        </div>
        <button class="btn" type="submit">Login</button>
      </form>
    </div>
    
    <% } else { 
    response.sendRedirect("../index.jsp");
    %>
    
    <!--<form action="loginProcess.jsp" method="post">
      <button class="btn btn-lg btn-primary btn-block" type="submit">Logout</button>
    </form>-->
    
    
    <% } %>
  </body>
</html>
