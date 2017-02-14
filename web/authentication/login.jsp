<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/authentication/login.css" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
  </head>
  <body>
    <%
    String loginMessage=(String)request.getAttribute("loginmessage");
    
    if(!auth.isloggedIn()) {%>
    <div class="wrapper">
      <form class="form-signin" action="${pageContext.request.contextPath}/authentication/loginProcess.jsp" method="post">       
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
        response.sendRedirect(request.getContextPath()+"/index.jsp");
       }
    %>
  </body>
</html>
