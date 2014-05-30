public class OldLady extends Customer{

    public OldLady(){
       super("oldlady.gif",400,500);
       setSpeed(10);
    }
    
    
    public void decrease(){
        setPatience(getPatience()-4);
        }
        
    }

