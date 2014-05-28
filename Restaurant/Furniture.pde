public class Furniture extends Clickable{
  
  private int price;
  
  public Furniture(int price, String gif, int w, int h){
    super(gif,w,h);
    this.price = price;
  }
  
  public int getPrice(){
    return price;
  }
  
  public void setPrice(int x){
    price = x;
  }
  
      
}
