

<%@page import="model.Employee"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="change" class="jsp.ChangeSalary" scope="session"/>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Employee's salary change</title>
  </head>
  <body>
    <%String value=""; 
      if (request.getParameter("emp_id")==null)
      ;
      else 
      value = request.getParameter("emp_id");%>
    <br><br> 
    <p align="center">
    <h3><p align="center">Employee's name: <%= change.getName(value) %> </h3> 
    <h3><p align="center">Current salary: $ <%= change.getSalary() %></h3>
    <form method=get>
      <h3><p align="center">New salary <input type=text name=newsalary></h3>
    <p align="center"><input type=submit value="Change">
    </form>
    <h3><p align="center">Please select a salary from $<%= change.getMinMaxSalary()[0] %> to $<%= change.getMinMaxSalary()[1] %></h3>
    <h3><p align="center"><% if (request.getParameter("newsalary")!=null) {%>
      <%= change.getMessages(request.getParameter("newsalary")) %></p></h3>
      <% }%>
    
  </body>
</html>
