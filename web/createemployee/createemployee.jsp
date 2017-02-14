<%-- 
    Document   : createemployee
    Created on : 2017.02.13., 13:58:28
    Author     : ferenc
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="jsp.Step"%>
<%@page import="jsp.CreateEmployeeBean"%>
<%@page import="jsp.AuthBean, model.Employee" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="auth" class="jsp.AuthBean" scope="session"/>
<jsp:useBean id="create" class="jsp.CreateEmployeeBean" scope="session"/>
<jsp:useBean id="emp" class="model.Employee" scope="session"/>

<jsp:setProperty name="create" property="firstName" param="firstname"/>
<jsp:setProperty name="create" property="lastName"/>
<jsp:setProperty name="create" property="email"/>
<jsp:setProperty name="create" property="phoneNumber"/>

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
    if(auth.isLogedin()) {
      if(auth.hasPermission("create_employee")) {
        
        /*// CANCEL
        if(index==-1) {
          create.remove();
          response.sendRedirect("../index.jsp");
        }
        
        // UPDATE
        if(index==STEPS_NUMBER) {
          create.remove();
          response.sendRedirect("../index.jsp");
        }
        
        // ha az elozo oldal adatai nem jok, visszanavigaljuk
        if(index-1>=0 && index<STEPS_NUMBER-1) {
          if(!steps.get(index-1).checking()) {
            create.setCurrentstep(String.valueOf(index-1));
            response.sendRedirect("createemployee.jsp");
          }
        }*/
        
        ArrayList<Step> steps=create.getSteps();
        final int STEPS_NUMBER=create.getSTEPS_NUMBER();
        
        int index=create.getCurrentstep();
        
        if(request.getParameter("cancel")!=null) {
          response.sendRedirect("../index.jsp");
        }
        
        if(request.getParameter("finish")!=null) {
          //create.save();
        }
        
        if(request.getParameter("back")!=null) {
          index--;
        }
        
        if(request.getParameter("next")!=null) {
          if(steps.get(index).checking()) {
            index++;
          }
        }
        
        create.setCurrentstep(index);

        %>
        <div>
          <div class="tabs">
          <%
            for (int i = 0; i < STEPS_NUMBER; i++) {
                out.print("<label class=\""+(index==i?"active":"")+"\">");
                out.print((i+1)+". "+steps.get(i).getTitle());
                out.print("</label>");
            }
            %>
          </div>
          
          <div>
            <%= create.getSb().toString() %>
          </div>
        
          <form action="createemployee.jsp" method="post">
            <%
              if(index==0) {
                out.print("<div>"
                        + "New employee's first name and last name without any digit character</p>"
                        + "<p>Select the department and the job title</p>"
                        + "<p>Set the employee's salary between the given limits</p>");
              }
              
              out.print("<button name=\"cancel\" value=\""+(-1)+"\" class=\"btn\" type=\"submit\" >Cancel</button>");
              out.print("<button name=\"back\" value=\""+(index-1)+"\" class=\"btn\" type=\"submit\" "+( (index > 0 && (STEPS_NUMBER > 1) )?"enabled":"disabled" )+" >Back</button>");
              out.print("<button name=\"next\" value=\""+(index+1)+"\" class=\"btn\" type=\"submit\" "+( (index < (STEPS_NUMBER - 1) && (STEPS_NUMBER > 1))?"enabled":"disabled" )+">Next</button>");
              out.print("<button name=\"currentstep\" value=\""+(index+1)+"\" class=\"btn\" type=\"submit\" "+( (index==STEPS_NUMBER-1)?"enabled":"disabled" )+" >Finish</button>");
            %>
          </form>
        </div>
        <%
      } else {
        out.print("Premission danied.");
      }
    }
    else {
      response.sendRedirect("/HF_170216_JSP/index.jsp");
    }
    %>
  </body>
</html>
