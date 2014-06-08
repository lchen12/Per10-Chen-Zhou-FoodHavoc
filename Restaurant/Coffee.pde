public class Coffee extends Clickable {
  
  public Coffee() {
    super("coffee.gif", 20, 25);
  }

  public Coffee(int x, int y) {
    super("coffee.gif", 20, 25, x, y);
  }
  
  public String toString() {
    return "Coffee";
  }
}

