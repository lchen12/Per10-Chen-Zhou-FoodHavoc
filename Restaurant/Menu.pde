public class Menu extends Furniture {

  private int orderNumber;
  
  public Menu(int x, int y, int o) {
    super(0, "menu.gif", 17, 25, x, y);
    orderNumber = o;
  }
  
  public void display() {
    super.display();
    if (orderNumber!=0){
      text(orderNumber,getX()+getW()/2, getY()+getH());
    }
  }
  
  public int getOrderNumber() {
    return orderNumber;
  }

  public String toString() {
    return "Menu";
  }
  
}

