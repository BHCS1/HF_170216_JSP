<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>
<%
  auth.logout();
  session.invalidate();
  response.sendRedirect("login.jsp");
%>