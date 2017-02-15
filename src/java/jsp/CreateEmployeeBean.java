/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jsp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.Employee;
import model.Job;

/**
 *
 * @author ferenc
 */
public class CreateEmployeeBean extends model.Employee {
  private ArrayList<Step> steps=new ArrayList<>();
  private int currentstep=0;
  private final int STEPS_NUMBER;
  private final Employee THIS_EMP;
  
  private ArrayList<String> alerts=new ArrayList<>();

  public CreateEmployeeBean() {
    THIS_EMP=this;
    
    this.setDepartmentId(-1);
    this.setFirstName("");
    this.setLastName("");
    this.setEmail("");
    this.setPhoneNumber("");
    this.setJobId("");
    this.setSalary(0);
    
    steps.add(new Step("Instructions") {
      public boolean checking() {
        alerts.clear();
        return true;
      }
    });
    
    steps.add(new Step("Personal Details") {
      public boolean checking() {
        alerts.clear();
        
        if (getFirstName()==null) {
          alerts.add("Missing firstname.");
        }
        else if(!getFirstName().matches(("[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+"))) {
          alerts.add("Invalid firstname. Only upper or lowercase.");
        }
        
        if (getLastName()==null) {
          alerts.add("Missing lastname.");
        } else if(!getLastName().matches(("[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+"))) {
          alerts.add("Invalid lastname. Only upper or lowercase.");
        }

        if (getEmail()==null) {
          alerts.add("Missing email address.");
        }
        else {
          /*letters (upper or lowercase)
            numbers (0-9)
            underscore (_)
            point (.)*/
          final Pattern VALID_EMAIL_ADDRESS_REGEX = Pattern.compile("^[a-zA-Z0-9_.]*$", Pattern.CASE_INSENSITIVE);//Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
          Matcher matcher = VALID_EMAIL_ADDRESS_REGEX .matcher(getEmail());
          if(!matcher.find()) {
            alerts.add("Invalid email address! Acceptable: upper or lowercase, numberer (0-9), underscore (_), point (.).");
          }
          else {
            try {
              if(Employee.emailExists(getEmail()))
                alerts.add("Existing email, please type another email address!");
            }
            catch (SQLException ex) {
              alerts.add("Querying data failed!");
            }
            catch(ClassNotFoundException ex) {
              alerts.add("Most probably misssing ojdbc driver!");
            }
          }
        }
        
        return alerts.size()<=0;
      }
    });
    
    steps.add(new Step("Department & Job") {
      @Override
      public boolean checking() {
        alerts.clear();
        
        boolean depValid=getDepartmentId()!=-1;
        
        if(!depValid)
          alerts.add("Select a department.");
        
        boolean jobValid=getJob()!=null;
        
        if(!jobValid)
          alerts.add("Select a job.");
        
        return (depValid & jobValid);
      }
    });
    
    steps.add(new Step("Salary") {
      @Override
      public boolean checking() {
        alerts.clear();
        
        Job currentJob=getJob();
        int minSalary=currentJob.getMinSalary();
        int maxSalary=currentJob.getMaxSalary();
        int currentSalary=getSalary();
        
        boolean minValid=(currentSalary>=minSalary);
        boolean maxVal=(currentSalary<=maxSalary);
        
        if(!minValid) {
          alerts.add("Too low.");
          setSalary(minSalary);
        }
        
        if(!maxVal) {
          alerts.add("Too high.");
          setSalary(maxSalary);
        }
        
        if(!minValid || !maxVal)
          alerts.add("Attention! Salary received value automatically.");
        
        return (minValid & maxVal);
      }
    });
    
    steps.add(new Step("Summary") {
      @Override
      public boolean checking() {
        alerts.clear();
        return true;
      }
    });
    
    this.STEPS_NUMBER=steps.size();
  }

  public ArrayList<String> getAlerts() {
    return alerts;
  }
  

  public int getSTEPS_NUMBER() {
    return STEPS_NUMBER;
  }

  public ArrayList<Step> getSteps() {
    return steps;
  }
  
  public Step getStep(int i) {
    return steps.get(i);
  }

  public int getCurrentstep() {
    return currentstep;
  }

  public void setCurrentstep(int currentstep) {
    this.currentstep = currentstep;
  }
}
