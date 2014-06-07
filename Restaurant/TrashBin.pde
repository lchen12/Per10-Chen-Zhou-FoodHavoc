public class TrashBin extends Furniture {

  public TrashBin() {
    super(40, "trashBin.gif", 80, 100);
  }

  public TrashBin(int x, int y) {
    super(40, "trashBin.gif", 80, 100, x, y);
    print("hi");
  }
  public String toString() {
    return "trashBin";
  }
}

