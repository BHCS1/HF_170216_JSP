<%@page import="server.authentication.Authentication" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="server.authentication.Authentication" scope="session"/>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/menu/menu.css" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
  </head>
  <body>
    <% if(!auth.isloggedIn()) {
      response.sendRedirect(request.getContextPath()+"/authentication/login.jsp");
    } else {
      %>
    <jsp:include page="/menu/menu.jsp"></jsp:include>
      <%
    }%>
  </body>
</html>
