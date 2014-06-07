////////////REMEMBER TO ADD COFFEE FEATURE
///////////////ALSO ADD CHAIN FEATURE

public class Player {
  private int level, money, goal, profit, x, y, speed, w, h, hold; //hold = # of items player is holding; can't be more than 2
  private String gender;
  private ArrayList<ServingDome> domes;
  private ArrayList<Menu> menus;
  private ArrayList<Food> food;
  private PImage person;

  ///DEFAULT CONSTRUCTOR
  public Player(String gender) {
    if (gender.equals("female")) {
      person = loadImage("waitress.gif");
    } else if (gender.equals("male")) {
      person = loadImage("waiter.gif");
    }
    this.gender = gender;
    w = 90;
    h = 140;
    person.resize(w, h);
    level = 1;
    money = 100;
    goal = 500;
    profit = 0;
    x = displayWidth/6;
    y = displayHeight/6;
    speed = 3;
    domes = new ArrayList<ServingDome>();
    menus = new ArrayList<Menu>();
    food = new ArrayList<Food>();
  }

  ///CONSTRUCTOR USED FOR ALREADY-EXISTING PLAYERS
  public Player(String gender, int l, int m, int g, int s) {
    if (gender.equals("female")) {
      person = loadImage("waitress.gif");
    } else if (gender.equals("male")) {
      person = loadImage("waiter.gif");
    }
    this.gender = gender;
    w = 90;
    h = 140;
    person.resize(w, h);
    level = l;
    money = m;
    goal = g;
    profit = 0;
    x = displayWidth/6;
    y = displayHeight/6;
    speed = s;
    domes = new ArrayList<ServingDome>();
    menus = new ArrayList<Menu>();
    food = new ArrayList<Food>();
  }

  public void display() {
    image(person, x, y);
    boolean leftHandEmpty = true;
    boolean rightHandEmpty = true;
    for (int i = 0; i < domes.size (); i++) {
      if (leftHandEmpty) { //then put on left hand
        domes.get(i).setLocation(x, y);
        leftHandEmpty = false;
      } else if (rightHandEmpty) { //then put on right hand
        domes.get(i).setLocation(x+w, y);
        rightHandEmpty = false;
      }
    }
    for (int i = 0; i < menus.size (); i++) {
      if (leftHandEmpty) { //then put on left hand
        menus.get(i).setLocation(x, y);
        leftHandEmpty = false;
      } else if (rightHandEmpty) { //then put on right hand
        menus.get(i).setLocation(x+w/2, y);
        rightHandEmpty = false;
      }
    }
    for (int i = 0; i < food.size (); i++) {
      if (leftHandEmpty) { //then put on left hand
        food.get(i).setLocation(x, y);
        leftHandEmpty = false;
      } else if (rightHandEmpty) { //then put on right hand
        food.get(i).setLocation(x+w/2, y);
        rightHandEmpty = false;
      }
    }
  }

  public boolean holdItem(Clickable c) { ///adds item to player's hand
    if (hold>=2) { //if holding 2 or more items, don't do anything
      return false;
    } else {
      if (c.toString().equals("ServingDome")) {
        if (domes.size()<2) {
          domes.add((ServingDome)c);
          return true;
        }
      } else if (c.toString().equals("Menu")) {
        if (menus.size()<2) {
          menus.add((Menu)c);
          return true;
        }
      } else if (c.toString().equals("Food")) {
        if (food.size()<2) {
          food.add((Food)c);
          return true;
        }
      }
      return false;
    }
  }

  ///checks to see if the waiter has the dome with the right order number
  public boolean checkOrderNumber(int o) {
    for (int i = 0; i < domes.size (); i++) {
      if (domes.get(i).getOrderNumber()==o) {
        return true;
      }
    }
    return false;
  }

  public void removeDome(int o) {
    for (int i = 0; i < domes.size (); i++) {
      if (domes.get(i).getOrderNumber()==o) {
        domes.remove(i);
        return;
      }
    }
  }
  
  public ServingDome getDome(int o) {
    for (int i = 0; i < domes.size (); i++) {
      if (domes.get(i).getOrderNumber()==o) {
        return domes.get(i);
      }
    }
    return null;
  }

  public boolean move(Clickable c) {
    int approx = 10;
    if (Math.abs(x-(c.getX())) <= approx && Math.abs(y-(c.getY())) <= approx) {
      return true;
    } else {      
      if (Math.abs(x-(c.getX()))>approx && x < c.getX() ) {
        x+=speed;
      } else if (Math.abs(x-(c.getX()))>approx && x > c.getX()) {
        x-=speed;
      }
      if (Math.abs(y-(c.getY())) > approx && y < c.getY()) {
        y+=speed;
      } else if (Math.abs(y-(c.getY())) > approx && y > c.getY()) {
        y-=speed;
      }
      return false;
    }
  }

  public String getGender() {
    return gender;
  }

  public int getLevel() {
    return level;
  }  
  public int getMoney() {
    return money;
  }  
  public int getGoal() {
    return goal;
  }
  public void setGoal(int g) {
    goal = g;
  }
  public int getProfit() {
    return profit;
  }
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public void setLocation(int a, int b) {
    x = a;
    y = b;
  }
  public int getSpeed() {
    return speed;
  }
  public void level() {
    level++;
    goal+=level*100;
  }
  public boolean addMoney(int m) {
    if (money+m < 0) {
      return false;
    }
    money+=m;
    return true;
  }
  public boolean addProfit(int p) {
    if (profit+p < 0) {
      return false;
    }
    profit+=p;
    return true;
  }
}

