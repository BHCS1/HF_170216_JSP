<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Employee"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="change" class="jsp.ChangeSalary" scope="session"/>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<jsp:include page="/layout/head.jsp"></jsp:include>

<%String value = request.getParameter("emp_id");
  if (!auth.isloggedIn() || !auth.hasPermission("salary_change") || change.getName(value)==null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
  }
  String newSalary = request.getParameter("newsalary");
  String[] message = null;
  if (newSalary!=null) {
    message = change.getMessages(newSalary);
  }
  %>
<div class="page-header">
  <h1>Change Salary</h1>
</div>
  
<h2><%= change.getName(value) %></h2>
<% if (message == null || !message[0].equals("success")) { %>
<form method=post>
  <% }%>
  <div class="panel panel-default">
    <div class="panel-heading">New Salary</div>

    <div class="panel-body">
      <h3><p align="center">Please select a salary from $<%= change.getMinMaxSalary()[0] %> to $<%= change.getMinMaxSalary()[1] %></h3>
      
      <div class="input-group input-group-lg">
        <span class="input-group-addon">$</span>
        
        <input type="text" class="form-control" name="newsalary" placeholder="Salary" title="Only digits." value="<%= request.getParameter("newsalary")==null?change.getSalary():request.getParameter("newsalary") %>">
        <% if (message == null || !message[0].equals("success")) { %>
        <span class="input-group-btn">
          <button class="btn btn-default" type="submit">
            Change
          </button>
        </span>
        <% }%>
      </div>
      
    </div>
  </div>
      
  <% if (message != null) { %>  
  <div class="alert alert-<%= message[0] %>" role="alert">
    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
    <%= message[1] %>
  </div>
  <% }%>
     <% if (message == null || !message[0].equals("success")) { %> 
</form>
      <% }%>
