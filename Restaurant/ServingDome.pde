public class ServingDome extends Furniture {

  private int orderNumber;
  
  public ServingDome(int x, int y, int o) {
    super(0, "servingDome.gif", 50, 25, x, y);
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

