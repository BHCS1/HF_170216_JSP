<%-- 
    Document   : removeProcess
    Created on : 2017.02.14., 19:42:24
    Author     : ferenc
--%>

<%@page import="jsp.CreateEmployeeBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="create" class="jsp.CreateEmployeeBean" scope="session"/>

<%
  CreateEmployeeBean bean = (CreateEmployeeBean)session.getAttribute("create");
  if (bean != null) {
    bean = new CreateEmployeeBean();
    session.setAttribute("create",bean);
    response.sendRedirect(request.getContextPath()+"/index.jsp");
  }
%>