public class Customer extends Clickable {
  
  private int patience;
  private double speed;
  
  public Customer(String gif, int w, int h, int p, double s) {
    super(gif, w, h);
    patience = p;
    speed = 10;
  }

  public int getPatience() {
    return patience;
  }

  public void setPatience(int p) {
    patience = p;
  }

  public void increase() {
    patience=patience+10;
  }

  public void decrease() {
    patience=patience-10;
  }

  public void setSpeed(double s) {
    speed=s;
  }

  public double getSpeed() {
    return speed;
  }
  
}







