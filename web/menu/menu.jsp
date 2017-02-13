<%-- 
    Document   : menu.jsp
    Created on : 2017.02.13., 15:45:51
    Author     : ferenc
--%>

<%@page import="jsp.AuthBean, model.Employee" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>
<ul>
    <%
    if(auth.isLogedin()) {
      out.print("<li><a href=\"/HF_170216_JSP/index.jsp\">Home</a></li>");
      if(auth.hasPermission("show_diagrams")) {
        out.print("<li><a href=\"#\">Show diagrams</a></li>");
      }
      if(auth.hasPermission("create_employee")) {
        out.print("<li><a href=\"/HF_170216_JSP/createemployee/createemployee.jsp\">Create new employee</a></li>");
      }
      out.print("<li style=\"float:right\"><a class=\"active\" href=\"/HF_170216_JSP/authentication/loginProcess.jsp\">Logout</a></li>");
    }
    %>
</ul>
