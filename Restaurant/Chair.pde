public class Chair extends Furniture {

  private boolean occupied;

  public Chair() {
    super(10, "orangeChair1.gif", 54, 75);
    occupied = false;
  }

  ///to add chairs to table, need 2 types of chairs: one facing left, one facing right
  public Chair(int x, int y, String orientation) {
    //if (orientation.equals("faceLeft")) {
    super(10, "orangeChair1.gif", 54, 75, x, y);
    if (orientation.equals("faceRight")) {
      setImage("orangeChair2.gif");
    }
    occupied = false;
  }

  public void occupied() {
    occupied = true;
  }

  public void unoccupied() {
    occupied = false;
  }
  public String toString() {
    return "chair";
  }
}

