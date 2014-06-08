public class OrderHolder extends Furniture {

  public OrderHolder() {
    super(15, "orderHolder.gif", 75, 75);
  }

  public OrderHolder(int x, int y) {
    super(25, "orderHolder.gif", 75, 75, x, y);
  }
  
  public String toString() {
    return "orderHolder";
  }
  
}

