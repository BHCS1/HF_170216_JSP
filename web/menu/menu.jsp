<%@page import="jsp.AuthBean, model.Employee" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<!-- Fixed navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">HF_170216_JSP</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <% if (auth.isloggedIn()) { %>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
            <% if(auth.hasPermission("show_diagrams")) { %>
            <li><a href="${pageContext.request.contextPath}/diagrams.jsp">Show Charts</a></li>
            <% } %>
            <% if(auth.hasPermission("create_employee")) { %>
            <li><a href="${pageContext.request.contextPath}/createemployee/createemployee.jsp">Create New Employee</a></li>
            <% } %>
        <% } %>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <% if (auth.isloggedIn()) { %>
            <li><a>Hello <%=auth.getUsername()%></a></li>
            <li><a href="${pageContext.request.contextPath}/authentication/logout.jsp">Logout</a></li>
        <% } %>
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</nav>
