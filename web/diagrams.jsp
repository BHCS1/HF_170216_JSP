<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="jsp.AuthBean, model.Department" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>

<jsp:include page="/layout/head.jsp"></jsp:include>  

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/c3.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.17/d3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/c3.min.js"></script>

<% if(!auth.isloggedIn() || !auth.hasPermission("show_diagrams")) {
  response.sendRedirect(request.getContextPath()+"/authentication/login.jsp");
  return;
} %>

<div class="page-header">
    <h1>Charts</h1>
</div>

<h2>Salaries Summary by Departments</h2>
<div id="chart1"></div>
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

<jsp:include page="/layout/foot.jsp"></jsp:include>  
