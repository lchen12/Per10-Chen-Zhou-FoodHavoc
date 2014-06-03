public class Table extends Furniture {

  private int seats;
  private int maxSeats;
  private ArrayList<Chair> chairs;

  ///CONSTRUCTOR FOR NEW TABLE
  public Table(int ms) {
    super(20, "woodTable.gif", 100, 100);
    maxSeats = ms;
    seats = 0;
    chairs = new ArrayList<Chair>();
  }

  //////CONSTRUCTOR FOR ALREADY-PURCHASED TABLE
  public Table(int x, int y, int ms, int s) {
    super(20, "woodTable.gif", 100, 100, x, y);
    maxSeats = ms;
    seats = s;
    chairs = new ArrayList<Chair>();
    for (int i = 0; i < s; i++) {
      addChair();
    }
  }

  public void display() {
    super.display();
    if (chairs!=null) {
      for (Chair c : chairs) {
        c.display();
      }
    }
  }

  public int getSeats() {
    return seats;
  }

  public int getMaxSeats() {
    return maxSeats;
  }



  public boolean addChair() {
    if (chairs.size() < maxSeats/2) {
      chairs.add(new Chair(getX()-50, getY()+50*(chairs.size()%(maxSeats/2)), "faceRight"));
      seats++;
      return true;
    } else if (chairs.size() < maxSeats) {
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
    }
  }

  public String toString() {
    return "table";
  }
}

