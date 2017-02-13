package jsp;

import java.io.Serializable;
import java.rmi.RemoteException;
import java.util.TreeSet;
import server.authentication.Authentication;

public class AuthBean implements Serializable {
  
  private String username = null;
  private TreeSet permissions;
  private boolean loggedin=false;

  public AuthBean() {
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public TreeSet getPermissions() {
    return permissions;
  }

  public void setPermissions(TreeSet permissions) {
    this.permissions = permissions;
  }
  
  public void addPermission(String permission) {
    this.permissions.add(permission);
  }
  
  public void removePermission(String permission) {
    this.permissions.remove(permission);
  }
  
  public void setPermissions() {
    if (username != null) {
      this.permissions = new Authentication().getPerissions(username);
    }
  }
  
  public boolean login(String user, String pass) throws RemoteException {
    //trycatch kellene
    boolean validAuth = new Authentication().login(user, pass);
    if (validAuth) {
      username = user;
      setPermissions();
    }
    return validAuth;
  }
  
  public boolean isLogedin() {
    return this.loggedin;//username != null;
  }

  public void setLoggedin(boolean loggedin) {
    this.loggedin = loggedin;
  }
  
  public boolean hasPermission(String permission) {
    return permissions != null && permissions.contains(permission);
  }
  
  public void reset() {
    username = null;
    permissions = null;
    loggedin = false;
  }
  
  /*public static void main(String[] args) throws RemoteException {
    // for test
    AuthBean bean = new AuthBean();
    bean.login("HR1", "hr1");
    System.out.println(bean.isLogedin());
    System.out.println(bean.hasPermission("salary_change"));
    System.out.println(bean.hasPermission("create_employee"));
    System.out.println(bean.getPermissions());
//    bean.reset();
    bean.login("HR2", "hr2");
    System.out.println(bean.isLogedin());
    System.out.println(bean.hasPermission("salary_change"));
    System.out.println(bean.hasPermission("create_employee"));
    System.out.println(bean.getPermissions());
//    bean.reset();
    bean.login("HR3", "hr3");
    System.out.println(bean.isLogedin());
    System.out.println(bean.hasPermission("salary_change"));
    System.out.println(bean.hasPermission("create_employee"));
    System.out.println(bean.getPermissions());
  }*/
  
}