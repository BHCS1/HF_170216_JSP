<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="jsp.AuthBean, model.Department" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/menu/menu.css" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/c3.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.17/d3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/c3.min.js"></script>
  </head>
  <body>
    <% if(!auth.isloggedIn()) {
      response.sendRedirect(request.getContextPath()+"/authentication/login.jsp");
    } else {
      %>
    <jsp:include page="/menu/menu.jsp"></jsp:include>
      <%
    }%>
    
    <div>
        
        <div id="chart1"></div>
    </div>
    
    <script type="text/javascript">
    var chart = c3.generate({
        bindto: '#chart1',
        data: {
            type: 'pie',
            columns: [
            <%
                HashMap mp = Department.getDepartmentSalaries();

                Iterator it = mp.entrySet().iterator();
                while (it.hasNext()) {
                    Map.Entry pair = (Map.Entry)it.next();
                    out.print("['"+(pair.getKey()==null?"Without Department":pair.getKey()) + "', " + pair.getValue()+"],");
                }

            %>
          ]
        }
    });
    </script>
  </body>
</html>
