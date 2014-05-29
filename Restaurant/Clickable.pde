public class Clickable{
  
  private int x, y, width, height;
  private PImage img;
  //private boolean isOver;
  
  public Clickable(String gif, int w, int h){
    img = loadImage(gif);
    img.resize(w,h);
    width = w;
    height = h;
    x = mouseX - width/2;
    y = mouseY - height/2;
    display();
  }
  
  public void display(){
    image(img,x,y);
  }
  
  public boolean over(){
    if (mouseX >= x && mouseX <= x+width &&
        mouseY >= y && mouseY <= y+height){
          //isOver = true;
          return true;
        }else{
          //isOver = false;
          return false;
        }
  }
  
  public void size(int w, int h){
    img.resize(w,h);
  }
  
}
