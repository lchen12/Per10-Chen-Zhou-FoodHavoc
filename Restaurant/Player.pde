public class Player{
  private int level,money,goal,profit;
  private float x,y,speed;
  
  public Player(){
    level = 1;
    money = 10;
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
  public void addMoney(int m) throws Exception{
    if (money+m < 0){
      throw new Exception("Cannot purchase item because too little mula.");
    }
    money+=m;
  }
  
}
