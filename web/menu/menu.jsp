<%@page import="jsp.AuthBean, model.Employee" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>
<ul class="menu">
    <li>Hello <%=auth.getUsername()%></li>
    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
    <% if(auth.hasPermission("show_diagrams")) { %>
    <li><a href="${pageContext.request.contextPath}/diagrams.jsp">Show diagrams</a></li>
    <% } %>
    <% if(auth.hasPermission("create_employee")) { %>
    <li><a href="${pageContext.request.contextPath}/createemployee/createemployee.jsp">Create new employee</a></li>
    <% } %>

    <li style="float:right;"><a class="active" href="${pageContext.request.contextPath}/authentication/logout.jsp">Logout</a></li>
</ul>