public class DishWasher extends Furniture{
  
  public DishWasher(){
    super(40,"dishWasher.gif",100,100);
  }
  
  public DishWasher(int x, int y){
    super(40,"dishWasher.gif",100,100,x,y);
  }
  public String toString(){
    return "dishwasher";
  }
  
}
