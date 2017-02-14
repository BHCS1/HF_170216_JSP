package server.authentication;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Node;
import org.xml.sax.InputSource;

public class Authentication {
  InputSource xmlUsers = new InputSource(Authentication.class.getResource("users.xml").toString());
  XPath xPath = XPathFactory.newInstance().newXPath();
  MessageDigest md = null;
  

  public Authentication() {
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
    } catch (XPathExpressionException ex) {
      ex.printStackTrace();
    }
    
    return validAuth;
  }

  public boolean hasPermission(String username, String permission) {
    boolean hasPermission = false;
    if(username==null)
      return false;
    try {
      Node userNode = (Node)xPath.evaluate("/root/users/user[@name='"+username+"']", xmlUsers, XPathConstants.NODE);
      String role = userNode.getAttributes().getNamedItem("role").getNodeValue();
      hasPermission = (boolean)xPath.evaluate("boolean(/root/roles/role[@name='"+role+"']/permission[@name='"+permission+"'])", xmlUsers, XPathConstants.BOOLEAN);
    } catch (XPathExpressionException ex) {
      ex.printStackTrace();
    }
    
    return hasPermission;
    
  }
  
}
