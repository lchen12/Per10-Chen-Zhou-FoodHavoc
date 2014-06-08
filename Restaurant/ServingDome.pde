public class ServingDome extends Clickable {

  private int orderNumber;
  
  public ServingDome(int x, int y, int o) {
    super("servingDome.gif", 50, 25, x, y);
    orderNumber = o;
  }
  
  public void display() {
    super.display();
    text(orderNumber,getX()+getW()/2, getY()+getH());
  }
  
  public int getOrderNumber() {
    return orderNumber;
  }

  public String toString() {
    return "ServingDome";
  }
  
}

