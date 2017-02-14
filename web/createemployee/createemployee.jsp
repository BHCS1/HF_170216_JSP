<%-- 
    Document   : createemployee
    Created on : 2017.02.13., 13:58:28
    Author     : ferenc
--%>

<%@page import="model.Job"%>
<%@page import="model.Department"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jsp.Step"%>
<%@page import="jsp.CreateEmployeeBean"%>
<%@page import="server.authentication.Authentication" contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean id="auth" class="server.authentication.Authentication" scope="session"/>
<jsp:useBean id="create" class="jsp.CreateEmployeeBean" scope="session"/>

<jsp:setProperty name="create" property="firstName"/>
<jsp:setProperty name="create" property="lastName"/>
<jsp:setProperty name="create" property="email"/>
<jsp:setProperty name="create" property="phoneNumber"/>
<jsp:setProperty name="create" property="departmentId"/>
<jsp:setProperty name="create" property="jobId"/>
<jsp:setProperty name="create" property="salary"/>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create new employee</title>
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
    <link rel="stylesheet" type="text/css" href="/HF_170216_JSP/style.css" />
    <link rel="stylesheet" type="text/css" href="/HF_170216_JSP/menu/menu.css" />
    <link rel="stylesheet" type="text/css" href="/HF_170216_JSP/createemployee/createemployee.css" />
  </head>
  <body>
    <jsp:include page="../menu/menu.jsp"></jsp:include>
    <%
    if(auth.isloggedIn()) {
      if(auth.hasPermission("create_employee")) {
        
        ArrayList<Step> steps=create.getSteps();
        ArrayList<String> errors=create.getErrors();
        final int STEPS_NUMBER=create.getSTEPS_NUMBER();
        
        int index=create.getCurrentstep();
        
        if(request.getParameter("finish")!=null) {
          
          create.setHireDate(new java.sql.Date(new java.util.Date().getTime()));
          create.setManagerId(100);
          
          int i=create.save();
          
          response.sendRedirect("./removeAttribute.jsp");
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
        }
        

        %>
        <div class="panel">
          <div class="tabs">
          <%
            for (int i = 0; i < STEPS_NUMBER; i++) {
                out.print("<label class=\""+(index==i?"active":"")+"\">");
                out.print((i+1)+". "+steps.get(i).getTitle());
                out.print("</label>");
            }
            %>
          </div>
        
          <form action="createemployee.jsp" method="post">
            <div class="content" style="display:<%= (index==0)?"visibility":"none"%>">
              New employee's first name and last name without any digit character</p>
              <p>Select the department and the job title</p>
              <p>Set the employee's salary between the given limits</p>
            </div>

            <div class="content" style="display:<%= (index==1)?"visibility":"none"%>">
              <input type="text" name="firstName" placeholder="Firstname" pattern="[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+" title="Only Hungarian characters" autofocus="" value="<%= create.getFirstName()%>">
              <input type="text" name="lastName" placeholder="Lastname" pattern="[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+" title="Only Hungarian characters" value="<%= create.getLastName()%>">
              <input type="text" name="email" placeholder="Email address" value="<%= create.getEmail() %>">
              <input type="text" name="phoneNumber" placeholder="Phone number" pattern="[0-9]{7,10}" title="A minimum of seven and a maximum of 10 digits." value="<%= create.getPhoneNumber()%>">
            </div>
            
            <div class="content" style="display:<%= (index==2)?"visibility":"none"%>">
              <h3 class="list-head">Department</h3>
              <ul>
              <%
                ArrayList<Department> departments=Department.getAll();
                for (int i = 0; i < departments.size(); i++) {
                  
                  Department currDep=departments.get(i);
                  int sessDepId=create.getDepartmentId();
                  
                  out.print("<li><input type=\"radio\" class=\"content\" name=\"departmentId\" value=\""+(currDep.getId())+"\""+( (currDep.getId()==sessDepId)?"checked":"" )+">"+currDep.getName()+"</li>");
                }
              %>
              </ul>
            </div> 
            
            <div class="content" style="display:<%= (index==2)?"visibility":"none"%>">
              <h3 class="list-head">Job</h3>
              <ul>
              <%
                ArrayList<Job> jobs=Job.getAll();
                String sessDepId=null;
                
                Job selectedJob=null;
                
                for (Job j:jobs) {
                  
                  Job currJob=j;
                  sessDepId=create.getJobId();
                  
                  boolean current = (currJob.getId().equals(j.getId()));
                  if(current) {
                    selectedJob=j;
                  }
                  
                  out.print("<li><input type=\"radio\" class=\"content\" name=\"jobId\" value=\""+(currJob.getId())+"\""+( current?"checked":"" )+">"+j.getTitle()+"</li>");
                }
              %>
              </ul>
            </div>
              
            <div class="content" style="display:<%= (index==3)?"visibility":"none"%>">
                <%
                  create.setJob(selectedJob);
                  int minSalary=selectedJob.getMinSalary();
                  int maxSalary=selectedJob.getMaxSalary();
                %>
              <h3 calss="list-head">$<%= minSalary %> - $<%= maxSalary %></h3>
              <input type="text" name="salary" placeholder="Salary" value="<%= create.getSalary()%>">
            </div>
            
            <div class="content" style="display:<%= (index==4)?"visibility":"none"%>">
              <h3>Name: <%= create.getFirstName() %> <%= create.getFirstName() %></h3>
              <h3>Email: <%= create.getEmail() %></h3>
              <h3>Phone: <%= create.getPhoneNumber()%></h3>
              <h3>Department: <%= create.getDepartmentId() %></h3>
              <h3>Job: <%= create.getJobId() %></h3>
              <h3>Salary: <%= create.getSalary() %></h3>
            </div>
      
            
              <%
                if(errors.size()>0) {
                  %>
                  <div class="err"><%= String.join("<br>", errors) %></div>
                  <%
                }
              %>
            
            <script type="text/javascript" language="JavaScript">
              function cancel()
              {
                if(confirm("Distrupt the operation?") === true) {
                  window.location = 'removeAttribute.jsp';
                }
              }
            </script>
                <%
              out.print(create.getCurrentstep());
              out.print("<div class=\"buttons\">");
              out.print("<button onclick=\"cancel()\" class=\"btn\" type=\"button\" >Cancel</button>");
              out.print("<button name=\"back\" class=\"btn\" type=\"submit\" "+( (index > 0 && (STEPS_NUMBER > 1) )?"enabled":"disabled" )+" >Back</button>");
              out.print("<button name=\"next\" class=\"btn\" type=\"submit\" "+( (index < (STEPS_NUMBER - 1) && (STEPS_NUMBER > 1))?"enabled":"disabled" )+">Next</button>");
              out.print("<button name=\"finish\" class=\"btn\" type=\"submit\" "+( (index==STEPS_NUMBER-1)?"enabled":"disabled" )+" >Finish</button>");
              out.print("</div>");
                %>
          </form>
        </div>
        <%
      } else {
        out.print("Premission danied.");
      }
    }
    else {
      response.sendRedirect("../index.jsp");
    }
    %>
  </body>
</html>
