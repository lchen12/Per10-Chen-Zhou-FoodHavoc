public class Party extends Clickable {

  private ArrayList<Customer> customers;
  private ArrayList<Menu> menus;
  private ArrayList<Food> food;
  private int size, patience, maxPatience, timeSpent; ///timeSpent keeps track of how long customer has left to order, eat, etc...
  private double speed;
  private String type, state; //STATES: "WAITING" "ORDERING" "WAITINGFORFOOD" "EATING" "DONE"
  private Table table;
  private boolean ready;
  private ThoughtBubble thoughtBubble;

  public Party(Random rand, int max, int x, int y, String type, Player p) {
    super(x, y);
    size = rand.nextInt(max)+1;
    customers = new ArrayList<Customer>();
    menus = new ArrayList<Menu>();
    food = new ArrayList<Food>();
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
    this.type = type;
    maxPatience = (int)(customers.get(0).getPatience()*p.getPatienceFactor());
    patience = maxPatience;
    speed = customers.get(0).getSpeed()*p.getCustomerSlowFactor();
    state = "waiting";
    table = null;
    timeSpent = (int)speed;
    ready = true;
    thoughtBubble = new ThoughtBubble(getX()+getW()/2, getY()-10);
  }

  public void display() {
    if (state!=null && state.equals("done")) { ///if party finishes eating, leaves with empty plates in table
      for (int i = 0; i < size; i++) {
        Plate p = new Plate(0, 0);
        if (i < table.getMaxSeats()/2) {
          p.setLocation(table.getX()+table.getW()/8, getY()+25*(i%(table.getMaxSeats()/2)));
        } else if (i < table.getMaxSeats()) {
          p.setLocation(table.getX()+table.getW()/8, getY()+25*(i%(table.getMaxSeats()/2)));
        }
        p.display();
      }
      return;
    } else {
      for (int i = 0; i < size; i++) {
        customers.get(i).display();
      }
      if (menus!=null) {
        for (int i = 0; i < menus.size (); i++) {
          menus.get(i).display();
        }
      }
      if (food!=null) {
        for (int i = 0; i < food.size (); i++) {
          food.get(i).display();
        }
      }
      if (ready && (state.equals("ordering") || state.equals("eating"))) { ///a thoughtBubble appears, showing that customers are waiting to be called on
        thoughtBubble.display();
      }
      text("Patience: "+patience, getX(), getY()-10);
    }
  }
  
  public ArrayList<Customer> getCustomers(){
    return customers;
  }

  ///this function is for the party with old people
  public void setCustomers(ArrayList<Customer> c) {
    customers = c;
  }

  public void setSize(int s) {
    size = s;
  }

  public int getSize() {
    return size;
  }

  public boolean isReady() {
    return ready;
  }

  public int getPatience() {
    return patience;
  }

  public int getMaxPatience() {
    return maxPatience;
  }

  public void setMaxPatience(int p) {
    maxPatience = p;
  }
  
  public void setPatience(int p) {
    if (p <= maxPatience) {
      patience = p;
    } else {
      patience = maxPatience;
    }
  }
  
  public void setSpeed(double s){
    speed = s;
  }

  public void addPatience() {
    patience = getPatience() + maxPatience/5;
    if (patience > maxPatience) {
      patience = maxPatience;
    }
  }

  public String getState() {
    return state;
  }

  public void decrease() {
    if (timeSpent>=speed && !state.equals("done")) {  ///if customer is ready and waiting, i.e. isn't ordering or eating or finished eating, then decrease patience.
      patience-=2;
    }
  }

  public void setState(String s) {
    state = s;
    if (s.equals("waiting") || s.equals("waitingForFood") || s.equals("done")) {
      timeSpent = (int)speed; //so that their patience won't decrease
      ready = true; //so that they can be clicked on
    } else {
      timeSpent = 0; ///reset the time spent doing something
      ready = false;
      if (s.equals("eating")) {
        for (int i = 0; i < size; i++) {
          Food f = new Food(0, 0);
          if (i < table.getMaxSeats()/2) {
            f.setLocation(table.getX()+table.getW()/8, getY()+25*(i%(table.getMaxSeats()/2)));
          } else if (i < table.getMaxSeats()) {
            f.setLocation(table.getX()+table.getW()/8, getY()+25*(i%(table.getMaxSeats()/2)));
          }
          food.add(f);
        }
      }
    }
  }


  public void setLocation(Table t) {
    super.setLocation(t.getX(), t.getY());
    table = t;
    for (int i = 0; i < size; i++) {
      if (i < t.getMaxSeats()/2) {
        customers.get(i).setLocation(t.getX()-table.getW()/5, getY()+25*(i%(t.getMaxSeats()/2)));
      } else if (i < t.getMaxSeats()) {
        customers.get(i).setLocation(t.getX()+table.getW()/5, getY()+25*(i%(t.getMaxSeats()/2)));
      }
    }
    thoughtBubble.setLocation(t.getX(), t.getY()-45);
  }

  public void addMenus() {
    for (int i = 0; i < size; i++) {
      Menu m = new Menu(0, 0, table.getOrderNumber());
      if (i < table.getMaxSeats()/2) {
        m.setLocation(table.getX()+table.getW()/8, getY()+25*(i%(table.getMaxSeats()/2)));
      } else if (i < table.getMaxSeats()) {
        m.setLocation(table.getX()+table.getW()/8, getY()+25*(i%(table.getMaxSeats()/2)));
      }
      menus.add(m);
    }
  }

  public void removeMenus() {
    menus = new ArrayList<Menu>();
  }

  public String toString() {
    String result = "";
    for (int i = 0; i < size; i++) {
      result+= customers.get(i).toString()+", ";
    }
    return result;
  }

  public Table getTable() {
    return table;
  }

  public void addTable(Table t) {
    table = t;
    /////////set width and height of party to that of table
    size(t.getW(), t.getH());
  }

  ///increases timeSpent, until it reaches speed..
  public void increaseTime() {
    if (timeSpent < speed && (state.equals("ordering") || state.equals("eating"))) {
      timeSpent++;
    } else {
      ready = true;
    }
  }

  public int getTimeSpent() {
    return timeSpent;
  }

  public void setTimeSpent(int t) {
    timeSpent = t;
  }
}

