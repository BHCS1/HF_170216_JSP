

<%@page import="model.Employee"%>
<%@page import="java.util.ArrayList"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Employee's salary change</title>
  </head>
  <body>
    <% int id=0; 
      if (request.getParameter("emp_id")!=null)
      id = Integer.parseInt(request.getParameter("emp_id"));
      ArrayList<Employee> employee = Employee.getAll(); 
      int i =0;
      
      while (i<employee.size() && employee.get(i).getID()!=id)
        i++;
    %>
    <br><br> 
    <p align="center">
    <h3><p align="center">Employee's name: <%= employee.get(i).getName() %> </h3> 
    <h3><p align="center">Current salary: $<%= employee.get(i).getSalary() %> </h3>
    <form method=get>
      <h3><p align="center">New salary <input type=text name=newsalary></h3>
    <p align="center"><input type=submit value="Change">
    </form>
    <% int departmentMaxSalaryChange =(int)((employee.get(i).getDepartment().getSumSalary())*0.03); 
     int employeeMaxSalaryChange= (int)(employee.get(i).getSalary()*0.05);
     int salaryMin=(employee.get(i).getSalary())-(Math.min(departmentMaxSalaryChange,employeeMaxSalaryChange));
     int salaryMax=(employee.get(i).getSalary())+(Math.min(departmentMaxSalaryChange,employeeMaxSalaryChange));
     %>
    <h3><p align="center">Please select a salary from $ <%=salaryMin%> to $ <%=salaryMax%></h3>
    <% try{ 
      Integer.parseInt(request.getParameter("newsalary")); 
    if (request.getParameter("newsalary")!=null && Integer.parseInt(request.getParameter("newsalary"))>salaryMax)  {%>
    <h4><p align="center"> Wrong salary, too high! Please type again!</p></h4>
    <% }else if (request.getParameter("newsalary")!=null && Integer.parseInt(request.getParameter("newsalary"))<salaryMin) {%>
    <h4><p align="center"> Wrong salary, too low! Please type again!</p></h4>
    <% }else if (request.getParameter("newsalary")!=null && Integer.parseInt(request.getParameter("newsalary"))==employee.get(i).getSalary()) {%>
    <h4><p align="center"> Wrong salary, same! Please type again!</p></h4>
    <% }
    }
    catch (NumberFormatException e){ %>
    <h4><p align="center"> Please type a new salary!</p></h4>
    <%} %>
  </body>
</html>
