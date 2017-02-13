/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jsp;

import java.util.ArrayList;
import model.Employee;

/**
 *
 * @author ferenc
 */
public class CreateEmployeeBean extends model.Employee {
  private ArrayList<Step> steps=new ArrayList<>();
  private String currentstep="0";
  private final int STEPS_NUMBER;
  private final Employee THIS_EMP;

  public CreateEmployeeBean() {
    THIS_EMP=this;
    
    steps.add(new Step("Instructions") {
      public boolean checking() {
        return true;
      }
    });
    
    steps.add(new Step("Personal Details") {
      public boolean checking() {
        int i=0;

//        String email = tfEmail.getText();
//        String phoneNumber = (String)ftfPhone.getValue();
//        String fName = tfFirstName.getText();
//        String lName = tfLastName.getText();
        String fName=THIS_EMP.getFirstName();
        String lName=THIS_EMP.getFirstName();
        String email=THIS_EMP.getEmail();
        String phoneNumber=THIS_EMP.getPhoneNumber();
        if(fName==null || lName==null || email==null || phoneNumber==null)
          return false;
        
        StringBuilder sb=new StringBuilder();
        
        if (fName.matches(("[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+"))) {
          i++;
          fName=fName.substring(0, 1).toUpperCase() + fName.substring(1);
        }
        else
          sb.append("Firstname contains digit or null, try again!");
        
        if (lName.matches(("[a-zA-Z|á|é|í|ö|ó|ú|ü|ű|Á|É|Í|Ö|Ó|Ú|Ű|Ü]+"))) {
          i++;
          lName=lName.substring(0, 1).toUpperCase() + lName.substring(1);
        }
        else
          sb.append("Lastname contains digit or null, try again!");

//        try {
//          if (emailValidate(email)){
//            i++;
//            if (!Controller.getServer().emailExists(email) ) {
//              i++;
//              employee.setEmail(email);
//            }
//            else {
//              JOptionPane.showMessageDialog(this, "Existing email, please type another email address!", "Information Message", JOptionPane.INFORMATION_MESSAGE);
//            }
//          }
//          else
//            JOptionPane.showMessageDialog(this, "Not a valid email, please try again!", "Information Message", JOptionPane.INFORMATION_MESSAGE);
//
//        } catch (SQLException ex) {
//            JOptionPane.showMessageDialog(null, "Querying data failed!", "Error", JOptionPane.ERROR_MESSAGE);
//            System.out.println(ex.getMessage());
//        } catch (ClassNotFoundException ex) {
//            JOptionPane.showMessageDialog(null, "Most probably misssing ojdbc driver!", "Error", JOptionPane.ERROR_MESSAGE);
//            System.out.println(ex.getMessage());
//        } catch (RemoteException ex) {
//            JOptionPane.showMessageDialog(null, "Remote connection failed!", "Error", JOptionPane.ERROR_MESSAGE);
//            System.out.println(ex.getMessage());
//        }

        if (phoneNumber!= null){
          i++;
          THIS_EMP.setPhoneNumber(phoneNumber);
        }
        else
          sb.append("Lastname contains digit or null, try again!");

        return i==5;//(i==5)?"VALID":sb.toString();
      }
    });
    
    steps.add(new Step("Summary") {
      @Override
      public boolean checking() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
      }
    });
    
    this.STEPS_NUMBER=steps.size();
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

  public String getCurrentstep() {
    return currentstep;
  }

  public void setCurrentstep(String currentstep) {
    this.currentstep = currentstep;
  }
  
  public void remove() {
    this.currentstep="0";
  }
}
