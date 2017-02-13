package server.authentication;

public interface AuthInterface {
  boolean login(String user, String pass);
  boolean hasPermission(String user, String permission);
}
