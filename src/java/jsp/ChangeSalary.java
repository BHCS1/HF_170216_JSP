package jsp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Employee;

public class ChangeSalary extends model.Employee  {
  private ArrayList<Employee> employee; 
  private int index;
  private int newSalary;
  int[] salaryMinMax= new int[2];
  private int id;

  public ChangeSalary() throws ClassNotFoundException, SQLException{
    this.employee = Employee.getAll();
  }
  
public String getName(String idValue) {
  int i=0;
  if (idValue==null)
    id=100;
  int id = Integer.parseInt(idValue);
  while (i<employee.size() && id!=employee.get(i).getID() )
    i++;
  this.index=i;
  return employee.get(i).getName();
}
  @Override
  public int getSalary() {
  return employee.get(index).getSalary();
  }
  
  public int[] getMinMaxSalary (){
    int actualSalary=employee.get(index).getSalary();
    int departmentMaxSalaryChange=0;
    try {
      departmentMaxSalaryChange = (int)((employee.get(index).getDepartment().getSumSalary())*0.03);
    } catch (SQLException ex) {
      ;
    } catch (ClassNotFoundException ex) {
      ;
    }
    int employeeMaxSalaryChange= (int) Math.round(actualSalary*0.05);
    salaryMinMax[0]=actualSalary-(Math.min(departmentMaxSalaryChange,employeeMaxSalaryChange));
    salaryMinMax[1]=actualSalary+(Math.min(departmentMaxSalaryChange,employeeMaxSalaryChange));
    return salaryMinMax;
  }
  
  public boolean typedSalaryValueCheck(){
    if (newSalary<salaryMinMax[0] || newSalary>salaryMinMax[1])
      return false;
    return true;
  }
  
  public String getMessages(String inputSalary )  {
    try{
    this.newSalary = Integer.parseInt(inputSalary);
    }
    catch (NumberFormatException ex){
      return "Please type a valid number!";
    }
    if (newSalary==employee.get(index).getSalary())
      return "Same salary, please type a new salary!";
    
    if (!typedSalaryValueCheck())
      return "Wrong salary, please type a new salary!";
    
    return "ok";
  }
    
}
