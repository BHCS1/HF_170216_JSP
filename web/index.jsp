<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="/HF_170216_JSP/style.css" />
    <link rel="stylesheet" type="text/css" href="/HF_170216_JSP/menu/menu.css" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
  </head>
  <body>
    <% if(!auth.isLogedin()) {
      response.sendRedirect("/HF_170216_JSP/authentication/login.jsp");
    } else {
      %>
    <jsp:include page="/menu/menu.jsp"></jsp:include>
      <%
    }%>
  </body>
</html>
