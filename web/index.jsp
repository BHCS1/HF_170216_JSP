<%@page import="model.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@page import="server.authentication.Authentication" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="server.authentication.Authentication" scope="session"/>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/menu/menu.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/index.css" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
  </head>
  <body>
    <% if(!auth.isloggedIn()) {
      response.sendRedirect(request.getContextPath()+"/authentication/login.jsp");
    } else {
      ArrayList<Employee> employeeList = Employee.getAll();
      %>
    <jsp:include page="/menu/menu.jsp"></jsp:include>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Department</th>
                <th>Salary</th>
                <th>Change</th>
            </tr>
        </thead>
    <% for (int i = 0; i < employeeList.size(); i++) {%>
      <tr>
          <td class="name" title="Name"><%= employeeList.get(i).getFirstName() %> <%= employeeList.get(i).getLastName() %></td>
          <td class="dep" title="Department"><%= employeeList.get(i).getDepartmentName() %></td>
          <td class="salary" title="Salary"><%= employeeList.get(i).getSalary() %>$</td>
          <td class="change" onclick="window.location='/changesalary.jsp?emp_id=<%= employeeList.get(i).getID() %>'" title="Click to change salary">Change salary</td>
      </tr>
    <% } %>
    </table>
      <%
    }%>
  </body>
</html>
