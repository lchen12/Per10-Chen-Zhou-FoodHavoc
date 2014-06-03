public class OldLady extends Customer {

  public OldLady() {
    super("oldlady.gif", 82, 114);
    setSpeed(10);
  }


  public void decrease() {
    setPatience(getPatience()-4);
  }
}

