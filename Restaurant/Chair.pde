class Chair extends Furniture{
  
  boolean occupied;
  
  Chair(){
    super(10,"orangeChair.gif",36,50);
    occupied = false;
  }
  
  void occupied(){
    occupied = true;
  }
  
  void unoccupied(){
    occupied = false;
  }
        
}
