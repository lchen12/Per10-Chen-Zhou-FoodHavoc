public class Chair extends Furniture {

  public Chair() {
    super(10, "orangeChair1.gif", 54, 75);
  }

  ///to add chairs to table, need 2 types of chairs: one facing left, one facing right
  public Chair(int x, int y, String orientation) {
    //if (orientation.equals("faceLeft")) {
    super(10, "orangeChair1.gif", 54, 75, x, y);
    if (orientation.equals("faceRight")) {
      setImage("orangeChair2.gif");
    }
  }

  public String toString() {
    return "chair";
  }
}

