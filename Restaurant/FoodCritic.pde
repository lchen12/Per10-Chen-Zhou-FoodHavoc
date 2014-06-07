public class FoodCritic extends Customer {
  private int fee;

  public FoodCritic() {
    super("critic.gif", 100, 100, 80, 6);
  }


  public void giveFee() {
    if (getPatience()<=80) {
      fee=200;
    }
  }
  public String toString() {
    return "FoodCritic";
  }
}

