<%@page import="java.text.DecimalFormat"%>
<%@page import="model.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<% 
  if (!auth.isloggedIn()) {
    response.sendRedirect(request.getContextPath() + "/authentication/login.jsp");
    return;
  }
  ArrayList<Employee> employeeList = Employee.getAll();
 
%>

<jsp:include page="/layout/head.jsp"></jsp:include>  

<div class="page-header">
    <h1>Employees</h1>
</div>

<table class="table table-striped table-hover table-condensed">
    <thead>
        <tr>
            <th>Name</th>
            <th>Department</th>
            <th>Salary</th>
            <% if(auth.hasPermission("salary_change")) { %>
            <th>Change</th>
            <% } %>
        </tr>
    </thead>
    <tbody>
        <% for (int i = 0; i < employeeList.size(); i++) {%>
        <tr>
            <td class="name" title="Name"><%= employeeList.get(i).getFirstName()%> <%= employeeList.get(i).getLastName()%></td>
            <td class="dep" title="Department"><%= employeeList.get(i).getDepartmentName()%></td>
            <td class="salary" title="Salary">$<%= DecimalFormat.getInstance().format(employeeList.get(i).getSalary())%></td>
            <% if(auth.hasPermission("salary_change")) { %>
            <td class="change col-xs-2"><a class="btn btn-primary btn-xs" href="${pageContext.request.contextPath}/changesalary.jsp?emp_id=<%= employeeList.get(i).getID()%>" title="Click to change salary">Change salary</a></td>
            <% } %>
        </tr>
        <% } %>
    </tbody>
</table>

<jsp:include page="/layout/foot.jsp"></jsp:include>  