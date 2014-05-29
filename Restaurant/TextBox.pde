public class TextBox{
  
  private PFont f;
  private String s;
  
  public TextBox(String t){
    f = createFont("Arial",30);
    set(t);
  }
  
  public void display(){
    clear();
    textFont(f);
    fill(0);
    text(s,25,45);
  }    
  
  public void set(String t){
    s = t;
    display();
  }
  
  public void clear(){
    fill(204,102,0);
    rect(0,0,displayWidth,50,7);
  }
  
}
