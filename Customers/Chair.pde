public class Chair extends Furniture{
  
  private boolean occupied;
  
  public Chair(){
    super(10,"orangeChair.gif",54,75);
    occupied = false;
  }
  
  public Chair(int x, int y){
    super(10,"orangeChair.gif",54,75,x,y);
    occupied = false;
  }
  
  public void occupied(){
    occupied = true;
  }
  
  public void unoccupied(){
    occupied = false;
  }
  
  public String toString(){
    return "chair";
  }
        
}
