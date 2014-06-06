public class CollegeKid extends Customer {
  int kids;
  //ArrayList<Kids> Kids;

  public CollegeKid() {
    super("collegekid.gif", 80, 80);
    //kids = new ArrayList<Kids>();
  }
  /*
  public void addkid(){
   if (kids.size() < kids){
   kids.add(new Kids());
   }else{
   text("Kids has reached maximum capacity. Cannot add anymore kids.", 0,0);
   }
   }
   public void setSpeed(){
   speed=4;
   }
   */
  public String toString() {
    return "CollegeKid";
  }
}

