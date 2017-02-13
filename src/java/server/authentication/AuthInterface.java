package server.authentication;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.TreeSet;

public interface AuthInterface {
  boolean login(String user, String pass, String filePath);
  boolean hasPermission(String user, String permission);
  TreeSet getPerissions(String user);
}
