public class Chef extends Furniture {
  
  private int orderNumber;
  private double timeCook;
  
  public Chef(int x, int y, int o, double t) {
    super(0, "chef.gif", 80, 130, x, y);
    timeCook = t; //takes (timeCook* timeInterval from main) seconds for chef to make food
    orderNumber = o;
  }
  
  public void display() {
    super.display();
  }
  
  public int getOrderNumber() {
    return orderNumber;
  }
  
  public void decreaseTime(){
    timeCook--;
  }
  
  public double getTime(){
    return timeCook;
  }
  
  public String toString() {
    return "Chef";
  }
  
}

