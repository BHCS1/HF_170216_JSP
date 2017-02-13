package jsp;

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

public class Authentication {
  InputSource xmlUsers = new InputSource("WEB-INF/users.xml");
  XPath xPath = XPathFactory.newInstance().newXPath();
  MessageDigest md = null;
  
  public boolean login(String user, String pass, String filePath) {
    xmlUsers = new InputSource(filePath);
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

  public boolean hasPermission(String user, String permission) {
    boolean hasPermission = false;
    try {
      Node userNode = (Node)xPath.evaluate("/root/users/user[@name='"+user+"']", xmlUsers, XPathConstants.NODE);
      String role = userNode.getAttributes().getNamedItem("role").getNodeValue();
      hasPermission = (boolean)xPath.evaluate("boolean(/root/roles/role[@name='"+role+"']/permission[@name='"+permission+"'])", xmlUsers, XPathConstants.BOOLEAN);
    } catch (XPathExpressionException ex) {
      ex.printStackTrace();
    }
    
    return hasPermission;
    
  }
  
  public TreeSet getPerissions(String user) {
    TreeSet<String> permissions = new TreeSet();
    try {
      Node userNode = (Node)xPath.evaluate("/root/users/user[@name='"+user+"']", xmlUsers, XPathConstants.NODE);
      String role = userNode.getAttributes().getNamedItem("role").getNodeValue();
      Element userElement = (Element)xPath.evaluate("/root/roles/role[@name='"+role+"']", xmlUsers, XPathConstants.NODE);
      NodeList permissionLista = userElement.getElementsByTagName("permission");
      for (int i = 0; i < permissionLista.getLength(); i++) {
        permissions.add(((Element)permissionLista.item(i)).getAttribute("name"));
      }
    } catch (XPathExpressionException ex) {
      System.out.println();
      ex.printStackTrace();
    }
    return permissions;
  }
  
}
