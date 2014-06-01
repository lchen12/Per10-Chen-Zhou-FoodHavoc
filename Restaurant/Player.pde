public class Player{
  private int level,money,goal,profit;
  private float x,y,speed;
  
  public Player(){
    level = 1;
    money = 100;
    goal = 100;
    profit = 0;
    x = 0;
    y = 0;
    speed = 0;
  }
  
  public void move(){
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
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public float getSpeed(){
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
