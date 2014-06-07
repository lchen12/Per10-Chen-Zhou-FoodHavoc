public class OrderHolder extends Furniture {

  public OrderHolder() {
    super(15, "orderHolder.gif", 100, 100);
  }

  public OrderHolder(int x, int y) {
    super(25, "orderHolder.gif", 100, 100, x, y);
  }
  
  public String toString() {
    return "orderHolder";
  }
  
}

