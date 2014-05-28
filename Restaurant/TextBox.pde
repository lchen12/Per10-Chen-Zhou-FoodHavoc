public class TextBox{
  
  private PFont f;
  
  public TextBox(String t){
    clear(); //makes a rectangle
    f = createFont("Arial",30);
    set(t);
  }
  
  public void set(String t){
    clear();
    textFont(f);
    fill(0);
    text(t,25,45);
  }
  
  public void clear(){
    fill(204,102,0);
    rect(0,0,displayWidth,50,7);
  }
  
}
