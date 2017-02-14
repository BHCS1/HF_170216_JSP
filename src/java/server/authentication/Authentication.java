package server.authentication;

import java.io.InputStreamReader;
import java.io.Reader;
import java.io.Serializable;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.TreeSet;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class Authentication implements Serializable{
  InputSource xmlUsers = new InputSource(getClass().getResource("users.xml").toString());
  XPath xPath = XPathFactory.newInstance().newXPath();
  MessageDigest md = null;
  
  private boolean loggedIn = false;
  private String username = null;

  public Authentication() {
  }
  
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

  public boolean login(String user, String pass) {
    try {
      md = MessageDigest.getInstance("MD5");
    } catch(NoSuchAlgorithmException e) {
      e.printStackTrace();
    }

    md.update(pass.getBytes());
    byte[] mdBytes = md.digest();
       
    String passEncrypted = Base64.getEncoder().encodeToString(mdBytes);

    boolean validAuth = false;
    try {
      validAuth = (boolean)xPath.evaluate("boolean(/root/users/user[@name='"+user+"'][@pass='"+passEncrypted+"'])", xmlUsers, XPathConstants.BOOLEAN);
      if (validAuth) {
        setLoggedIn(true);
        setUsername(user);
      }
    } catch (XPathExpressionException ex) {
      ex.printStackTrace();
    }
    
    return validAuth;
  }

  public boolean hasPermission(String permission) throws XPathExpressionException, Exception {
    boolean hasPermission = false;
    
//    try {
      Node userNode = (Node)xPath.evaluate("/root/users/user[@name='"+username+"']", xmlUsers, XPathConstants.NODE);
      String role = userNode.getAttributes().getNamedItem("role").getNodeValue();
      hasPermission = (boolean)xPath.evaluate("boolean(/root/roles/role[@name='"+role+"']/permission[@name='"+permission+"'])", xmlUsers, XPathConstants.BOOLEAN);
  //  } catch (XPathExpressionException ex) {
    //  ex.printStackTrace();
    //}
    
    return hasPermission;
    
  }
  
}
