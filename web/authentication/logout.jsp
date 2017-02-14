<%@page import="server.authentication.Authentication" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="server.authentication.Authentication" scope="session"/>
<%
  auth.logout();
  session.invalidate();
  response.sendRedirect("login.jsp");
%>