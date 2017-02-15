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

<% if(!auth.isloggedIn() || !auth.hasPermission("create_employee")) {
  response.sendRedirect(request.getContextPath()+"/authentication/login.jsp");
  return;
} %>
      
<style>
  .nav-tabs {
    float: left;
  }
  
  .nav-tabs a {
    pointer-events: none;
  }
  
  .input-group {
    padding: 10px;
  }
  
  .input-group input {
    width: 1300px;
  }
  
  .panel-body .list li {
    width: 25%;
    list-style-type: none;
    float: left;
  }
</style>
      
<div class="page-header">
  <h1>Create New Employee</h1>
</div>

<%
    ArrayList<Step> steps=create.getSteps();
    ArrayList<String> alerts=create.getAlerts();
    final int STEPS_NUMBER=create.getSTEPS_NUMBER();

    int index=create.getCurrentstep();

    if(request.getParameter("finish")!=null) {
      create.setHireDate(new java.sql.Date(new java.util.Date().getTime()));

      int managerId=create.getDepartment().getManagerId();
      create.setManagerId(managerId==0?100:managerId);

      int returnVal=create.save();
%>
      <script type="text/javascript" language="JavaScript">
        window.onload = function() {
          var returnVal=<%= returnVal %>;
          if(returnVal!==-1) {
            alert("Employee added to the database.\nAfter approval will be navigated to home page.");
          }
          else {
            alert("Request failed.");
          }
          window.location = 'removeAttribute.jsp';
          return;
        };
      </script>
<%
    //response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    if(request.getParameter("back")!=null) {
      alerts.clear();
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
      
      <!-- Tabs -->
      <div class="panel panel-body">
      <% for (int i = 0; i < STEPS_NUMBER; i++) { %>
      <ul class="nav nav-tabs">
        <li role="presentation" class="<%= (index==i?"active":"") %>">
          <a href="#">
            <%= ( (i+1) + ". " + steps.get(i).getTitle() ) %>
          </a>
        </li>
      </ul>
      <% } %>
      </div>
      
      <div class="progress">
        <% double completed= index / ((STEPS_NUMBER-1)/100.0); %>
        <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="<%= STEPS_NUMBER %>" style="width: <%= (int)completed %>%">
          <span class="sr-only"><%= (int)completed %>% Complete (success)</span>
        </div>
      </div>

      <form action="${pageContext.request.contextPath}/createemployee/createemployee.jsp" method="post">
        
        <div class="panel panel-default" style="display:<%= (index==0)?"visibility":"none" %>">
          <div class="panel-heading">Instructions</div>
          <div class="panel-body">
            New employee's first name and last name without any digit character</p>
            <p>Select the department and the job title</p>
            <p>Set the employee's salary between the given limits</p>
          </div>
        </div>

        <div class="panel panel-default" style="display:<%= (index==1)?"visibility":"none" %>">
          <div class="panel-heading">Personal Details</div>
          <div class="panel-body">
            <div class="form-group" style="display:<%= (index==1)?"visibility":"none" %>">
              <div class="input-group input-group-lg">
                <span class="input-group-addon">Firstname</span>
                <input type="text" class="form-control" name="firstName" placeholder="" pattern="[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+" title="Only upper or lowercase" value="<%= create.getFirstName()==null?"":create.getFirstName() %>">
              </div>

              <div class="input-group input-group-lg">
                <span class="input-group-addon">Lastname</span>
                <input type="text" class="form-control" name="lastName" placeholder="" pattern="[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+" title="Only upper or lowercase" value="<%= create.getLastName()==null?"":create.getLastName() %>">
              </div>

              <div class="input-group input-group-lg">
                <span class="input-group-addon">Email address</span>
                <input type="text" class="form-control" name="email" placeholder="" pattern="^[a-zA-Z0-9_.]*$" title="Acceptable characters: a-Z, 0-9, _, ." aria-describedby="basic-addon2" value="<%= create.getEmail()==null?"":create.getEmail() %>">
                <span class="input-group-addon" id="basic-addon2">@company.com</span>
              </div>

              <div class="input-group input-group-lg">
                <span class="input-group-addon">Phone number</span>
                <input type="text" class="form-control" name="phoneNumber" placeholder="" pattern="[0-9]{7,10}" title="A minimum of seven and a maximum of 10 digits." value="<%= create.getPhoneNumber()==null?"":create.getPhoneNumber() %>">
              </div>
            </div>
          </div>
        </div>

        <div class="panel panel-default" style="display:<%= (index==2)?"visibility":"none" %>">
          <div class="panel-heading">Department</div>
          <div class="panel-body">
            <ul class="list">
            <%
              for (Department dept : create.getDepartments()) {
                boolean adjusted=( dept.getId()==create.getDepartmentId() ); %>
                <li>
                  <input type="radio" class="content" name="departmentId" value="<%= (dept.getId()) %>" <%= ( adjusted?"checked":"" ) %>>
                  <%= dept.getName() %>
                </li>
            <% } %>
            </ul>
          </div>
        </div> 

        <div class="panel panel-default" style="display:<%= (index==2)?"visibility":"none"%>">
          <div class="panel-heading">Job</div>
          <div class="panel-body">
            <ul class="list">
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
        </div>

        <div class="panel panel-default" style="display:<%= (index==3)?"visibility":"none"%>">
          <div class="panel-heading">Salary</div>
          
          <div class="panel-body">
            <%
              int minSalary=0, maxSalary=0;
              if(create.getJob()!=null) {
              minSalary=create.getJob().getMinSalary();
              maxSalary=create.getJob().getMaxSalary();
            %>
            Determination salary (between $<%= minSalary %> and $<%= maxSalary %>)
            <% } %>
            <div class="input-group input-group-lg">
              <span class="input-group-addon">$</span>
              <input type="number" class="form-control" name="salary" placeholder="Salary" pattern="/[0-9]/" title="Only digits." value="<%= create.getSalary()==0?"":create.getSalary() %>">
            </div>
          </div>
        </div>
        
        <div class="panel panel-default" style="display:<%= (index==4)?"visibility":"none"%>">
          <div class="panel-heading">Summary</div>
          <div class="panel-body">
            <h3>Name: <%= create.getFirstName() %> <%= create.getLastName() %></h3>
            <h3>Email: <%= create.getEmail() %></h3>
            <h3>Phone: <%= create.getPhoneNumber()%></h3>
            <% Department dep=create.getDepartment(); %>
            <h3>Department: <%= (dep!=null?dep.getName():null) %></h3>
            <% Job job=create.getJob(); %>
            <h3>Job: <%= (job!=null?job.getTitle():null) %></h3>
            <h3>Salary: $<%= create.getSalary() %></h3>
          </div>
        </div>
        
        <% if(alerts.size()>0) {
          for (int i = 0; i < alerts.size(); i++) { %>
          <div class="alert alert-danger" role="alert">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <span class="sr-only">Error:</span>
            <%= alerts.get(i).toString() %>
          </div>
          <% }
        } %>

        <script type="text/javascript" language="JavaScript">
          function cancel() {
            if(confirm("Are you sure you cancel the operation?") === true) {
              window.location = 'removeAttribute.jsp';
              return;
            }
          };
        </script>
        
        <div class="bt-group  btn-group-lg" role="group" area-label="4">
          <button onclick="cancel()" class="btn btn-default" type="button">
            Cancel
          </button>
          <button name="back" class="btn btn-default" type="submit" <%= ( (index > 0 && (STEPS_NUMBER > 1) )?"enabled":"disabled" ) %> >
            Back
          </button>
          <button id="next" name="next" class="btn btn-default" type="submit" <%= ( (index < (STEPS_NUMBER - 1) && (STEPS_NUMBER > 1))?"enabled":"disabled" ) %>>
            Next
          </button>
          <button name="finish" class="btn btn-default" type="submit" <%= ( (index==STEPS_NUMBER-1)?"enabled":"disabled" ) %>>
            Finish
          </button>
        </div>
            
      </form>
    </div>
<jsp:include page="/layout/foot.jsp"></jsp:include>  