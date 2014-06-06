public class Player {
  private int level, money, goal, profit, x, y, speed, w, h;
  private String gender;
  private PImage person, dome1, dome2, menu1, menu2, dishes1, dishes2;

  ///DEFAULT CONSTRUCTOR
  public Player(String gender) {
    if (gender.equals("female")) {
      person = loadImage("waitress.gif");
    } else if (gender.equals("male")) {
      person = loadImage("waiter.gif");
    }
    this.gender = gender;
    w = 100;
    h = 150;
    person.resize(w, h);
    level = 1;
    money = 100;
    goal = 100;
    profit = 0;
    x = 0;
    y = 100;
    speed = 3;
  }

  ///CONSTRUCTOR USED FOR ALREADY-EXISTING PLAYERS
  public Player(String gender, int l, int m, int g, int s) {
    if (gender.equals("female")) {
      person = loadImage("waitress.gif");
    } else if (gender.equals("male")) {
      person = loadImage("waiter.gif");
    }
    this.gender = gender;
    person.resize(200, 300);
    level = l;
    money = m;
    goal = g;
    profit = 0;
    x = 0;
    y = 100;
    speed = s;
  }

  public void display() {
    image(person, x, y);
  }

  public boolean move(Clickable c) {
    if (Math.abs(x-(c.getX()+w)) <= 5 && Math.abs(y-(c.getY()+h)) <= 5) {
      return true;
    } else {      
      if (Math.abs(x-(c.getX()+w))>5 && x < c.getX()-w ) {
        x+=speed;
      } else if (Math.abs(x-(c.getX()+w))>5 && x > c.getX()-w) {
        x-=speed;
      }
      if (Math.abs(y-(c.getY()+h)) > 5 && y < c.getY()-h) {
        y+=speed;
      } else if (Math.abs(y-(c.getY()+h)) > 5 && y > c.getY()-h) {
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
  public int getProfit() {
    return profit;
  }
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public int getSpeed() {
    return speed;
  }
  public void level() {
    level++;
  }
  public boolean addMoney(int m) {
    if (money+m < 0) {
      return false;
    }
    money+=m;
    return true;
  }
}

