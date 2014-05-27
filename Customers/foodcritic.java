public class foodcritic extends Customer{
    private int fee;
    
    public foodcritic(){
       super();
    }
    
    public void setSpeed(){
        speed=6;
    }
    
    public void giveFee(){
        if(patience<=80){
            fee=200;
        }
    }
      
}
