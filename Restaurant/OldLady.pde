public class OldLady extends Customer {

  public OldLady() {
    super("oldlady.gif", 65, 84, 120, 10);
  }

  public void decrease() {
    setPatience(getPatience()-4);
  }
  public String toString() {
    return "OldLady";
  }
}

