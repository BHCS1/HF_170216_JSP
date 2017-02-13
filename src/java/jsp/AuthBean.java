package jsp;

import java.io.Serializable;
import java.util.TreeSet;

public class AuthBean implements Serializable {
  
  private String username = null;
  private TreeSet permissions;
  private boolean loggedin=false;
  private Authentication authentication = null;

  public Authentication getAuthentication() {
    if (authentication == null)
      authentication = new Authentication();
    return authentication;
  }

  public void setAuthentication(Authentication authentication) {
    this.authentication = authentication;
  }

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
  
  private void setPermissions() {
    if (username != null) {
      this.permissions = getAuthentication().getPerissions(username);
    }
  }
  
  public boolean login(String user, String pass, String filePath) {
    //trycatch kellene
    boolean validAuth = getAuthentication().login(user, pass, filePath);
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
  
}