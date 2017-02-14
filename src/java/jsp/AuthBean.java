package jsp;

import server.authentication.Authentication;

public class AuthBean extends Authentication {
  
  private boolean loggedIn = false;
  private String username = null;

  public boolean isloggedIn() {
    return loggedIn;
  }

  public void setLoggedIn(boolean loggedIn) {
    this.loggedIn = loggedIn;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }
  
  public void logout() {
    setLoggedIn(false);
    setUsername(null);
  }

  @Override
  public boolean login(String user, String pass) {
    boolean validAuth = super.login(user, pass);
    if (validAuth) {
      setLoggedIn(true);
      setUsername(user);
    }

    return validAuth;
  }

  public boolean hasPermission(String permission) {
    return super.hasPermission(getUsername(), permission);
  }
  
  
}
