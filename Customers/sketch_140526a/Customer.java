public class Customer{
    protected int patience,speed;
    
    
    public Customer(){
      patience = 100;
      
    }
    
    public int getPatience(){
        return patience;
    }
    
    public void increase(){
      patience=patience+10;
        
    }
    
    
    
    public void decrease(){
      patience=patience-10;
    }
    
    public void setSpeed(){
        speed=10;
    }
    
    public int getSpeed(){
        return speed;
    }
    
    
    
}

    
        
    
    
    
   
