public class richman extends Customer{
    private int tip;
    
    public richman(){
       super();
    }
    
    public void setSpeed(){
        speed=7;
    }
    
    public void giveTip(){
        if(patience>=80){
            tip=100;
        }
    }
      
}
    
