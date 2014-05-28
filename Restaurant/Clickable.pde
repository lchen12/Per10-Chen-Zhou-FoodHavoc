public class Clickable{
  
  private int x, y, width, height;
  private PImage img;
  private boolean isOver;
  
  public Clickable(String gif, int w, int h){
    img = loadImage(gif);
    img.resize(w,h);
    image(img,mouseX,mouseY);
    width = w;
    height = h;
    x = mouseX;
    y = mouseY;
  }
  
  public boolean over(){
    if (mouseX >= x && mouseX <= x+width &&
        mouseY >= y && mouseY <= y+height){
          isOver = true;
          System.out.println("true");
          return true;
        }else{
          isOver = false;
          System.out.println("false");
          return false;
        }
  }
  
  public void delete(){
    //??????????
  }
  
  public void size(int w, int h){
    img.resize(w,h);
  }
  
}
