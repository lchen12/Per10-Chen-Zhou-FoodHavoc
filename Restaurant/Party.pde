public class Party extends Clickable {

  private ArrayList<Customer> customers;
  private int size;

  public Party(Random rand, int max, int x, int y, String type) {
    super(x, y);
    size = rand.nextInt(max)+1;
    customers = new ArrayList<Customer>();
    if (type.equals("CollegeKid")) {
      for (int i = 0; i < size; i++) {
        CollegeKid a = new CollegeKid();
        a.setLocation(x+i*20, y);
        customers.add(a);
        size(getW()+a.getW(), 120);
      }
    } else if (type.equals("YoungLady")) {
      for (int i = 0; i < size; i++) {
        YoungLady a = new YoungLady();
        a.setLocation(x+i*20, y);
        customers.add(a);
        size(getW()+a.getW(), 120);
      }
    } else if (type.equals("FoodCritic")) {
      for (int i = 0; i < size; i++) {
        FoodCritic a = new FoodCritic();
        a.setLocation(x+i*20, y);
        customers.add(a);
        size(getW()+a.getW(), 120);
      }
    } else if (type.equals("RichMan")) {
      for (int i = 0; i < size; i++) {
        RichMan a = new RichMan();
        a.setLocation(x+i*20, y);
        customers.add(a);
        size(getW()+a.getW(), 120);
      }
    }
  }

  public void display() {
    for (int i = 0; i < size; i++) {
      customers.get(i).display();
    }
  }

  public int getSize() {
    return size;
  }

  public void setLocation(Table t) {
    super.setLocation(t.getX(), t.getY());
    for (int i = 0; i < size; i++) {
      if (i < t.getMaxSeats()/2) {
        customers.get(i).setLocation(t.getX()-50, getY()+50*(i%(t.getMaxSeats()/2)));
      } else if (i < t.getMaxSeats()) {
        customers.get(i).setLocation(t.getX()+75, getY()+50*(i%(t.getMaxSeats()/2)));
      }
    }
  }

  public String toString() {
    String result = "";
    for (int i = 0; i < size; i++) {
      result+= customers.get(i).toString()+", ";
    }
    return result;
  }
}

