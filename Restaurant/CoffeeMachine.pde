public class CoffeeMachine extends Furniture {
  
  private int timeSpent, speed;
  private boolean ready;
  private ThoughtBubble thoughtBubble;

  public CoffeeMachine() {
    super(20, "coffeeMachine.gif", 36, 50);
    timeSpent = 0;
    speed = 5;
    ready = false;
    thoughtBubble = new ThoughtBubble(getX()+getW()/2, getY()-10);
  }

  public CoffeeMachine(int x, int y) {
    super(20, "coffeeMachine.gif", 36, 50, x, y);
    timeSpent = 0;
    speed = 3;
    ready = false;
    thoughtBubble = new ThoughtBubble(getX()+getW()/2, getY()-10);
  }
  
  public void display(){
    super.display();
    if (ready){
      thoughtBubble.setLocation(getX()+getW()/2, getY()-10);
      thoughtBubble.display();
    }
  }      
  
  public void setSpeed(int s){
    speed = s;
  }
  
  public boolean isReady(){
    return ready;
  }
  
  public void increaseTime(){
    if (timeSpent < speed){
      timeSpent++;
    }else{
      ready = true;
    }
  }
  
  public void reset(){
    timeSpent = 0;
    ready = false;
  }
  
  public String toString() {
    return "coffeeMachine";
  }
}

