<%@page import="model.Job"%>
<%@page import="model.Department"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jsp.Step"%>
<%@page import="jsp.CreateEmployeeBean"%>
<%@page import="jsp.AuthBean" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>
<jsp:useBean id="create" class="jsp.CreateEmployeeBean" scope="session"/>

<jsp:setProperty name="create" property="firstName"/>
<jsp:setProperty name="create" property="lastName"/>
<jsp:setProperty name="create" property="email"/>
<jsp:setProperty name="create" property="phoneNumber"/>
<jsp:setProperty name="create" property="departmentId"/>
<jsp:setProperty name="create" property="jobId"/>
<jsp:setProperty name="create" property="salary"/>


<jsp:include page="/layout/head.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/HF_170216_JSP/createemployee/createemployee.css" />

<% if(!auth.isloggedIn() || !auth.hasPermission("create_employee")) {
  response.sendRedirect(request.getContextPath()+"/authentication/login.jsp");
  return;
} %>

<div class="page-header">
  <h1>Create New Employee</h1>
</div>

<%
    ArrayList<Step> steps=create.getSteps();
    ArrayList<String> errors=create.getErrors();
    final int STEPS_NUMBER=create.getSTEPS_NUMBER();

    int index=create.getCurrentstep();

    if(request.getParameter("finish")!=null) {

    create.setHireDate(new java.sql.Date(new java.util.Date().getTime()));

    int managerId=create.getDepartment().getManagerId();
    create.setManagerId(managerId);
    out.print(":"+managerId+":");
    //int i=create.save();
%>
    <script type="text/javascript" language="JavaScript">
      window.onload = function() {
        var returnVal=<%= 2 %>;
        if(var!=-1) {
          alert("New employee created.");
        }
    </script>
<%
    //response.sendRedirect("${pageContext.request.contextPath}/createemployee/removeAttribute.jsp");
    }

    if(request.getParameter("back")!=null) {
      errors.clear();
      index--;
      create.setCurrentstep(index);
    }

    if(request.getParameter("next")!=null) {
      if(steps.get(index).checking()) {
        index++;
        create.setCurrentstep(index);
      }
      else {
%>
      <script type="text/javascript" language="JavaScript">
        window.onload = function() {
          window.scrollTo(0,document.body.scrollHeight);
        };
      </script>
<%
      }
    }
%>
    <div class="panel">
      <div class="tabs">
      <% for (int i = 0; i < STEPS_NUMBER; i++) { %>
            <label class="<%= (index==i?"active":"") %>">
            <%= ( (i+1) + ". " + steps.get(i).getTitle() ) %>
            </label>
      <% } %>
      </div>

      <form action="${pageContext.request.contextPath}/createemployee/createemployee.jsp" method="post">
        
        <div class="content" style="display:<%= (index==0)?"visibility":"none" %>">
          New employee's first name and last name without any digit character</p>
          <p>Select the department and the job title</p>
          <p>Set the employee's salary between the given limits</p>
        </div>

        <div class="content" style="display:<%= (index==1)?"visibility":"none" %>">
          <input type="text" name="firstName" placeholder="Firstname" pattern="[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+" title="Only Hungarian characters" autofocus="" value="<%= create.getFirstName()%>">
          <input type="text" name="lastName" placeholder="Lastname" pattern="[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+" title="Only Hungarian characters" value="<%= create.getLastName()%>">
          <input type="text" name="email" placeholder="Email address" value="<%= create.getEmail() %>">
          <input type="text" name="phoneNumber" placeholder="Phone number" pattern="[0-9]{7,10}" title="A minimum of seven and a maximum of 10 digits." value="<%= create.getPhoneNumber()%>">
        </div>

        <div class="content" style="display:<%= (index==2)?"visibility":"none" %>">
          <h3 class="list-head">Department</h3>
          <ul>
          <%
            ArrayList<Department> departments=Department.getAll();
            for (int i = 0; i < departments.size(); i++) {

              Department currDep=departments.get(i);
              int sessDepId=create.getDepartmentId(); %>

              <li>
                <input type="radio" class="content" name="departmentId" value="<%= (currDep.getId()) %>" <%= ( (currDep.getId()==sessDepId)?"checked":"" ) %>>
                <%= currDep.getName() %>
              </li>
          <% } %>
          </ul>
        </div> 

        <div class="content" style="display:<%= (index==2)?"visibility":"none"%>">
          <h3 class="list-head">Job</h3>
          <ul>
          <%
            for (Job job : Job.getAll()) {
              boolean adjusted = ( create.getJob()!=null && job.equals( create.getJob() ) ); %>
              <li>
                <input type="radio" class="content" name="jobId" value="<%= (job.getId()) %>" <%= ( adjusted?"checked":"" ) %>>
                <%= job.getTitle() %>
              </li>
          <% } %>
          </ul>
        </div>

        <div class="content" style="display:<%= (index==3)?"visibility":"none"%>">
          <%
            int minSalary=0, maxSalary=0;
            if(create.getJob()!=null) {
            minSalary=create.getJob().getMinSalary();
            maxSalary=create.getJob().getMaxSalary();
          %>
          <h3 calss="list-head">Determination salary (between $<%= minSalary %> and $<%= maxSalary %>)</h3>
          <% } %>
          <input type="number" name="salary" placeholder="Salary" pattern="/[0-9]/" title="Only digits." value="<%= create.getSalary()==0?"":create.getSalary() %>">
        </div>
        
        <div class="content" style="display:<%= (index==4)?"visibility":"none"%>">
          <h3>Name: <%= create.getFirstName() %> <%= create.getFirstName() %></h3>
          <h3>Email: <%= create.getEmail() %></h3>
          <h3>Phone: <%= create.getPhoneNumber()%></h3>
          <% Department dep=create.getDepartment(); %>
          <h3>Department: <%= (dep!=null?dep.getName():null) %></h3>
          <% Job job=create.getJob(); %>
          <h3>Job: <%= (job!=null?job.getTitle():null) %></h3>
          <h3>Salary: $<%= create.getSalary() %></h3>
        </div>
        
        <% if(errors.size()>0) { %>
        <div id="err" class="err">
          <%= String.join("<br>", errors) %>
        </div>
        <% } %>

        <script type="text/javascript" language="JavaScript">
          function cancel() {
            if(confirm("Distrupt the operation?") === true) {
              window.location = 'removeAttribute.jsp';
            }
          };
        </script>
        
        <div class="buttons">
          <button onclick="cancel()" class="btn" type="button">
            Cancel
          </button>
          <button name="back" class="btn" type="submit" <%= ( (index > 0 && (STEPS_NUMBER > 1) )?"enabled":"disabled" ) %> >
            Back
          </button>
          <button id="next" name="next" class="btn" type="submit" <%= ( (index < (STEPS_NUMBER - 1) && (STEPS_NUMBER > 1))?"enabled":"disabled" ) %>>
            Next
          </button>
          <button name="finish" class="btn" type="submit" <%= ( (index==STEPS_NUMBER-1)?"enabled":"disabled" ) %>>
            Finish
          </button>
        </div>
            
      </form>
    </div>
<jsp:include page="/layout/foot.jsp"></jsp:include>  