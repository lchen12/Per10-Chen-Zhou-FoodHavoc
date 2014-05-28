public class Chair extends Furniture{
  
  private boolean occupied;
  
  public Chair(){
    super(10,"orangeChair.gif",36,50);
    occupied = false;
  }
  
  public void occupied(){
    occupied = true;
  }
  
  public void unoccupied(){
    occupied = false;
  }
        
}
