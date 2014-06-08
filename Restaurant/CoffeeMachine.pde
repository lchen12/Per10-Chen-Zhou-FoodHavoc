public class CoffeeMachine extends Furniture {

  public CoffeeMachine() {
    super(20, "coffeeMachine.gif", 36, 50);
  }

  public CoffeeMachine(int x, int y) {
    super(20, "coffeeMachine.gif", 36, 50, x, y);
  }
  public String toString() {
    return "coffeeMachine";
  }
}

