public class RichMan extends Customer {
  private int tip;

  public RichMan() {
    super("richman.gif", 70, 85, 90, 7);
  }


  public void giveTip() {
    if (getPatience()>=80) {
      tip=100;
    }
  }
  
  
  public String toString() {
    return "RichMan";
  }
}

