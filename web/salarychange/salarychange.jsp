<%-- 
    Document   : salarychange
    Created on : 2017.02.13., 23:11:54
    Author     : krampycsek
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <br><br>
    <p align="center">
    <h3><p align="center">Employee's name: </h3> 
    <h3><p align="center">Current salary: </h3>
    
    <form method=get>
      <h3><p align="center">New salary <input type=text name=newsalary></h3>
    <p align="center"><input type=submit value="Change">
    </form>
    <h3><p align="center">Please select a new salary from $ [min] to $ [max]</h3>
  </body>
</html>
