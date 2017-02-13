<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>
<jsp:setProperty name="auth" property="username"/><!-- param="username"/>-->
<jsp:setProperty name="auth" property="username"/><!-- param="username"/>-->

<%
  
  String username=auth.getUsername();//request.getParameter("username");
  String password=request.getParameter("password");
  
  if(auth.isLogedin()) {//authAttr!=null) {
    
    //LOGOUT
    auth.reset();
    request.setAttribute("loginmessage", "Successfully logged out.");
    session.invalidate();
    request.getRequestDispatcher("./login.jsp").forward(request, response); //response.sendRedirect("login.jsp");
    
  } else if(!auth.isLogedin()/*authAttr==null*/ && username!=null && password!=null) {

    boolean status=auth.login(username, password, application.getRealPath("/") + "WEB-INF/users.xml");
    
    if(status) {
      
      //session.setAttribute("username", username);
      //session.setAttribute("password", password);
      //session.setAttribute("authentication", "TRUE");
      auth.setLoggedin(status);
      
      // NAVIGATE TO INDEX
      response.sendRedirect("../index.jsp");
      
    } else {
      request.setAttribute("loginmessage", "Login unsuccessful.");
      request.getRequestDispatcher("./login.jsp").forward(request, response); //response.sendRedirect("login.jsp");
    } // if status
  } else {
    response.sendRedirect("login.jsp");
  }// if
  
%>