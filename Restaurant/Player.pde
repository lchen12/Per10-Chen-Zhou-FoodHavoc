public class Player {
  private int level, money, goal, profit, x, y, speed, w, h, hold, streakNum, updateTime, updateTimeMax; //hold = # of items player is holding; can't be more than 2
  private String gender, streakType, updateProfit;
  private ArrayList<ServingDome> domes;
  private ArrayList<Menu> menus;
  private ArrayList<Plate> plates;
  private ArrayList<Coffee> coffee;
  private boolean hasCoffee;

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
    plates = new ArrayList<Plate>();
    coffee = new ArrayList<Coffee>();
    hasCoffee = false;
    hold = 0;
    streakNum = 0;
    streakType = "";
    updateProfit = ""; ///////tells player how much profit or tips player has earned
    updateTime = 0; //////time elapsed since update has popped up
    updateTimeMax = 2;
  }

  ///CONSTRUCTOR USED FOR ALREADY-EXISTING PLAYERS
  public Player(String gender, int l, int m, int s) {
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
    goal = 500+factorial(level)*100;
    profit = 0;
    x = displayWidth/6;
    y = displayHeight/6;
    speed = s;
    domes = new ArrayList<ServingDome>();
    menus = new ArrayList<Menu>();
    plates = new ArrayList<Plate>();
    coffee = new ArrayList<Coffee>();
    hasCoffee = false;
    hold = 0;
    streakNum = 0;
    streakType = "";
    updateProfit = ""; ///////tells player how much profit or tips player has earned
    updateTime = 0; //////time elapsed since update has popped up
    updateTimeMax = 2;
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
        menus.get(i).setLocation(x+w, y);
        rightHandEmpty = false;
      }
    }
    for (int i = 0; i < plates.size (); i++) {
      if (leftHandEmpty) { //then put on left hand
        plates.get(i).setLocation(x, y);
        leftHandEmpty = false;
      } else if (rightHandEmpty) { //then put on right hand
        plates.get(i).setLocation(x+w, y);
        rightHandEmpty = false;
      }
      plates.get(i).display();
    }
    for (int i = 0; i < coffee.size (); i++) {
      if (leftHandEmpty) { //then put on left hand
        coffee.get(i).setLocation(x, y);
        leftHandEmpty = false;
      } else if (rightHandEmpty) { //then put on right hand
        coffee.get(i).setLocation(x+w, y);
        rightHandEmpty = false;
      }
      coffee.get(i).display();
    }
    if (updateTime<updateTimeMax) {
      text(updateProfit, x, y+h+20);
    }
  }

  public boolean holdItem(Clickable c) { ///adds item to player's hand
    if (hold>1) { //if holding 2 or more items, don't do anything
      return false;
    } else {
      if (c.toString().equals("ServingDome")) {
        if (domes.size()<2) {
          domes.add((ServingDome)c);
        }
      } else if (c.toString().equals("Menu")) {
        if (menus.size()<2) {
          menus.add((Menu)c);
        }
      } else if (c.toString().equals("Plate")) {
        if (plates.size()<2) {
          plates.add((Plate)c);
        }
      } else if (c.toString().equals("Coffee")) {
        if (coffee.size()<2) {
          coffee.add((Coffee)c);
        }
        hasCoffee = true;
      }
      hold++;
      return true;
    }
  }

  public int getHold() {
    return hold;
  }

  ///checks to see if the waiter has the dome with the right order number
  public boolean checkDomeOrderNumber(int o) {
    for (int i = 0; i < domes.size (); i++) {
      if (domes.get(i).getOrderNumber()==o) {
        return true;
      }
    }
    return false;
  }

  public void removeOrderNumber(int o) { ///when a customer runs out of patience and leaves, remove all menus/domes with order number
    removeDome(o);
    for (int i = 0; i < menus.size (); i++) {
      if (menus.get(i).getOrderNumber()==o) {
        menus.remove(i);
        hold--;
      }
    }
  }

  public void removeDome(int o) {
    for (int i = 0; i < domes.size (); i++) {
      if (domes.get(i).getOrderNumber()==o) {
        domes.remove(i);
        hold--;
        return;
      }
    }
  }

  public Menu removeMenu() {
    for (int i = 0; i < menus.size (); i++) {
      Menu m = menus.get(i);
      menus.remove(i);
      hold--;
      return m;
    }
    return null;
  }

  public Coffee removeCoffee() {
    for (int i = 0; i < coffee.size (); i++) {
      Coffee c = coffee.get(i);
      coffee.remove(i);
      hold--;
      if (coffee.size()==0) {
        hasCoffee = false;
      }
      return c;
    }
    return null;
  }

  public boolean hasCoffee() {
    return hasCoffee;
  }

  public Plate removePlate() {
    for (int i = 0; i < plates.size (); i++) {
      Plate pl = plates.get(i);
      plates.remove(i);
      hold--;
      return pl;
    }
    return null;
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
    goal = 500+factorial(level)*100;
    speed++;
  }
  public int factorial(int n) {
    if (n == 1) {
      return n;
    } else {
      return n * factorial(n-1);
    }
  }
  public boolean addMoney(int m) {
    if (money+m < 0) {
      return false;
    }
    money+=m;
    return true;
  }
  public void resetProfit() {
    profit = 0;
  }
  public void addProfit(int p) {    
    profit+=p;
  }
  public void addProfit(String s) {    
    int p = 0; ///how much profit to add, based on the type of service acted
    setStreak(s);
    if (s.equals("ordering")) {
      p = 20;
      updateProfit(20);
    } else if (s.equals("waitingForFood")) {
      p = 30;
      updateProfit(30);
    } else if (s.equals("eating")) {
      p = 50;
      updateProfit(50);
    } else if (s.equals("done")) {
      p = 40;
      updateProfit(40);
    }
    profit+=p*streakNum;
    println(streakType+", "+streakNum);
  }
  public void setStreak(String s) {
    if (streakType.equals(s)) {
      streakNum++;
    } else {
      streakType = s;
      streakNum=1;
    }
  }

  public void updateProfit(int p) {
    updateTime = 0;
    updateProfit = "Profit: "+p+"x"+streakNum;
  }
  public void updateTips(int t) {
    updateProfit+= "\nTips: $"+t;
  }

  public void updateTime() {
    if (updateTime < updateTimeMax) {
      updateTime++;
    }
  }
}

