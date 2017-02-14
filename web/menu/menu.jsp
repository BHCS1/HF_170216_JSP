<%-- 
    Document   : menu.jsp
    Created on : 2017.02.13., 15:45:51
    Author     : ferenc
--%>

<%@page import="server.authentication.Authentication, model.Employee" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="server.authentication.Authentication" scope="session"/>
<ul>
    <li>Hello <%=auth.getUsername()%></li>
    <li><a href="index.jsp">Home</a></li>
    <% if(auth.hasPermission("show_diagrams")) { %>
    <li><a href="#">Show diagrams</a></li>
    <% } %>
    <% if(auth.hasPermission("create_employee")) { %>
    <li><a href="createemployee/createemployee.jsp">Create new employee</a></li>
    <% } %>

    <li style="float:right;"><a class="active" href="authentication/logout.jsp">Logout</a></li>
</ul>
