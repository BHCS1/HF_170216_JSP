/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jsp;

/**
 *
 * @author ferenc
 */
public abstract class Step {
  private String title=null;
  
  public Step(String title) {
    this.title=title;
  }

  public String getTitle() {
    return title;
  }
  
  public abstract boolean checking();
}
