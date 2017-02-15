<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<%
  if (auth.isloggedIn()) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
  }
  String loginMessage = (String) request.getAttribute("loginmessage");
%>

<jsp:include page="/layout/head.jsp"></jsp:include>  

<div class="col-xs-4 col-xs-offset-4">
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">Login</h3>
    </div>
    <div class="panel-body">
        <form action="loginProcess.jsp" method="post">       
            <div class="form-group">        
                <input type="text" class="form-control" name="username" placeholder="Username" required="" autofocus="" value="${param.username}"/>
            </div>
            <div class="form-group">        
                <input type="password" class="form-control" name="password" placeholder="Password" required=""/>
            </div>
            <% if (loginMessage != null) { %>
            <div class="alert alert-danger" role="alert"><%=loginMessage%></div>
            <% } %>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
    </div>
</div>
</div>
<jsp:include page="/layout/foot.jsp"></jsp:include>  