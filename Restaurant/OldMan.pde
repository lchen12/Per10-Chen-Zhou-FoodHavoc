public class OldMan extends Customer{

    public OldMan(){
       super("oldman.gif",250,600);
    }
    /*
    public void setSpeed(){
        speed=10;
    }
    */
    public void decrease(){
        setPatience(getPatience()-4);
        }
        
}
