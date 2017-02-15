<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>
<jsp:setProperty name="auth" property="username"/>
<%
  String username=auth.getUsername();
  String password=request.getParameter("password");
  if(username!=null && password!=null) {
    if(auth.login(username, password)) {
      response.sendRedirect(request.getContextPath() + "/index.jsp");
    } else {
      request.setAttribute("loginmessage", "Login unsuccessful");
      request.getRequestDispatcher("login.jsp").forward(request, response); //response.sendRedirect("login.jsp");
    }
  } else {
    request.setAttribute("loginmessage", "Login unsuccessful");
    response.sendRedirect("login.jsp");
  }
  
%>