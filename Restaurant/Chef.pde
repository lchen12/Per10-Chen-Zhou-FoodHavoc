public class Chef extends Furniture {
  
  private int timeCook, orderNumber;
  
  public Chef(int x, int y, int o) {
    super(0, "chef.gif", 80, 130, x, y);
    timeCook = 2; //takes (timeCook* timeInterval from main) seconds for chef to make food
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
  
  public int getTime(){
    return timeCook;
  }
  
  public String toString() {
    return "Chef";
  }
  
}

