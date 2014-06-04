public class OldMan extends Customer {

  public OldMan() {
    super("oldman.gif", 80, 84);
  }
  /*
    public void setSpeed(){
   speed=10;
   }
   */
  public void decrease() {
    setPatience(getPatience()-4);
  }
  public String toString() {
    return "OldMan";
  }
}

