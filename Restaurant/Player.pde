public class Player{
  private int level,money,goal,profit,x,y,speed;
  private String gender;
  private PImage person, dome1, dome2, menu1, menu2, dishes1, dishes2;
  
  ///DEFAULT CONSTRUCTOR
  public Player(String gender){
    if (gender.equals("female")){
      person = loadImage("waitress.gif");
    }else if (gender.equals("male")){
      person = loadImage("waiter.gif");
    }
    this.gender = gender;
    person.resize(200,300);
    level = 1;
    money = 100;
    goal = 100;
    profit = 0;
    x = 0;
    y = 0;
    speed = 0;
  }
  
  ///CONSTRUCTOR USED FOR ALREADY-EXISTING PLAYERS
  public Player(String gender, int l, int m, int g, int s){
    if (gender.equals("female")){
      person = loadImage("waitress.gif");
    }else if (gender.equals("male")){
      person = loadImage("waiter.gif");
    }
    this.gender = gender;
    person.resize(200,300);
    level = l;
    money = m;
    goal = g;
    profit = 0;
    x = 0;
    y = 0;
    speed = s;
  }
    
  public void display() {
    image(person, x, y);
  }
  
  public void move(){
  }
  
  public String getGender(){
    return gender;
  }
  
  public int getLevel(){
    return level;
  }  
  public int getMoney(){
    return money;
  }  
  public int getGoal(){
    return goal;
  }
  public int getProfit(){
    return profit;
  }
  public int getX(){
    return x;
  }
  public int getY(){
    return y;
  }
  public int getSpeed(){
    return speed;
  }
  public void level(){
    level++;
  }
  public boolean addMoney(int m){
    if (money+m < 0){
      return false;
    }
    money+=m;
    return true;
  }
  
}
