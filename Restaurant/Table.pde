public class Table extends Furniture {

  //private PFont f;
  private boolean occupied;
  private int seats, maxSeats, orderNumber, widthWithChairs, realH;
  private ArrayList<Chair> chairs;

  ///CONSTRUCTOR FOR NEW TABLE
  public Table(int ms) {
    super(20, "woodTable.gif", 100, 100);
    widthWithChairs = 100;
    maxSeats = ms;
    seats = 0;
    chairs = new ArrayList<Chair>();
    occupied = false;
    orderNumber = 0;
    realH = 100;
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
    realH = 75+25*(ms/4);
    //f = createFont("Arial", 10);
  }

  public void display() {
    if (chairs!=null) {
      for (int i = 0; i < chairs.size (); i++) {
        if (i < maxSeats/2) {
          chairs.get(i).setLocation(getX()-50+2*(i%(maxSeats/2)), getY()+25*(i%(maxSeats/2)));
        } else if (i < maxSeats) {
          chairs.get(i).setLocation(getX()+90+2*(i%(maxSeats/2)), getY()+25*(i%(maxSeats/2)));
        }
        chairs.get(i).display();
      }
    }
    super.display();
    for (int i = 1; i < maxSeats/4; i++){
      PImage img = loadImage("woodTable.gif");
      img.resize(100,100);
      image(img, getX()+i*5, getY()+i*25);
    }
    ////////make a small white square with ordernumber on it
    if (orderNumber!=0) {      
      fill(255, 255, 255);
      rect(getX()+getW()/4, getY(), 25, 25);
      //textFont(f);
      fill(50);
      //textSize(100);
      text(orderNumber, getX()+getW()/4+8, getY()+getY()/20);
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

  public boolean isOccupied() {
    return occupied;
  }

  public int getW() {
    return widthWithChairs;
  }
  
  public int getH() {
    return realH;
  }

  public boolean canAddChair() {
    return chairs.size() < maxSeats;
  }

  public boolean addChair() {
    if (chairs.size() < maxSeats/2) {
      if (chairs.size() == 0) {
        widthWithChairs+=50;
      }
      chairs.add(new Chair(getX()-50+2*(chairs.size()%(maxSeats/2)), getY()+25*(chairs.size()%(maxSeats/2)), "faceRight"));
      seats++;
      return true;
    } else if (chairs.size() < maxSeats) {
      if (chairs.size() == maxSeats/2) {
        widthWithChairs+=50;
      }
      chairs.add(new Chair(getX()+90+2*(chairs.size()%(maxSeats/2)), getY()+25*(chairs.size()%(maxSeats/2)), "faceLeft"));
      seats++;
      return true;
    } else {
      //text("Table has reached maximum capacity. Cannot add anymore chairs.", 0, 0);
      return false;
    }
  }

  public void removeChair() {
    if (chairs.size()>0) {
      chairs.remove(0);
      seats--;
    }
  }
  
  public void expand(){
    maxSeats += 4;
    realH += 25;
  }

  public String toString() {
    return "table";
  }
}

