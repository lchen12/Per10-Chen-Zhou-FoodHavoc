public class Table extends Furniture {

  //private PFont f;
  private boolean occupied;
  private int seats, maxSeats, orderNumber, widthWithChairs;
  private ArrayList<Chair> chairs;

  ///CONSTRUCTOR FOR NEW TABLE
  public Table(int ms) {
    super(20, "woodTable.gif", 100, 100);
    maxSeats = ms;
    seats = 0;
    chairs = new ArrayList<Chair>();
    occupied = false;
    orderNumber = 0;
    //f = createFont("Arial", 10);
  }

  //////CONSTRUCTOR FOR ALREADY-PURCHASED TABLE
  public Table(int x, int y, int ms, int s) {
    super(20, "woodTable.gif", 100, 100, x, y);
    widthWithChairs = 100;
    maxSeats = ms;
    seats = 0;
    chairs = new ArrayList<Chair>();
    for (int i = 0; i < s; i++) {
      addChair();
    }
    occupied = false;
    orderNumber = 0;
    //f = createFont("Arial", 10);
  }

  public void display() {
    super.display();
    if (chairs!=null) {
      for (Chair c : chairs) {
        c.display();
      }
    }
    ////////make a small white square with ordernumber on it
    if (orderNumber!=0){      
      fill(255,255,255);
      rect(getX()+getW()/4, getY(), 25,25);
      //textFont(f);
      fill(50);
      //textSize(100);
      text(orderNumber,getX()+getW()/4+8, getY()+getY()/20);
    }
  }

  public int getSeats() {
    return seats;
  }

  public int getOrderNumber() {
    return orderNumber;
  }

  public void setOrderNumber(int o) {
    orderNumber = o;
  }

  public int getMaxSeats() {
    return maxSeats;
  }

  public void occupy() {
    occupied = true;
  }

  public void unoccupy() {
    occupied = false;
  }
  
  public boolean isOccupied(){
    return occupied;
  }
  
  public int getW(){
    return widthWithChairs;
  }

  public boolean addChair() {
    if (chairs.size() < maxSeats/2) {
      if (chairs.size() == 0){
        setLocation(getX()-50,getY());
        widthWithChairs+=50;
      }
      chairs.add(new Chair(getX()-50, getY()+50*(chairs.size()%(maxSeats/2)), "faceRight"));
      seats++;
      return true;
    } else if (chairs.size() < maxSeats) {
      if (chairs.size() == maxSeats/2){
        widthWithChairs+=50;
      }
      chairs.add(new Chair(getX()+75, getY()+50*(chairs.size()%(maxSeats/2)), "faceLeft"));
      seats++;
      return true;
    } else {
      text("Table has reached maximum capacity. Cannot add anymore chairs.", 0, 0);
      return false;
    }
  }

  public void removeChair() {
    if (chairs.size()>0) {
      chairs.remove(0);
      seats--;
    }
  }

  public String toString() {
    return "table";
  }
}

