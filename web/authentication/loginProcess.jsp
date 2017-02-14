<%@page import="server.authentication.Authentication" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="server.authentication.Authentication" scope="session"/>
<jsp:setProperty name="auth" property="username"/>
<%
  String username=auth.getUsername();
  String password=request.getParameter("password");
  /*if(auth.isloggedIn()) {
    //LOGOUT
    auth.reset();
    request.setAttribute("loginmessage", "Successfully logged out.");
    session.invalidate();
    request.getRequestDispatcher("./login.jsp").forward(request, response); //response.sendRedirect("login.jsp");
    
  } else*/
  if(username!=null && password!=null) {

    if(auth.login(username, password)) {
      //session.setAttribute("username", username);
      //session.setAttribute("password", password);
      //session.setAttribute("authentication", "TRUE");
      
      // NAVIGATE TO INDEX
      response.sendRedirect("../index.jsp");
    } else {
      request.setAttribute("loginmessage", "Login unsuccessful");
      request.getRequestDispatcher("./login.jsp").forward(request, response); //response.sendRedirect("login.jsp");
    }
  } else {
    request.setAttribute("loginmessage", "Login unsuccessful");
    response.sendRedirect("login.jsp");
  }
  
%>