public class TextBox{
  
  private PFont f;
  private String txt;
  private int red, green, blue, x,y,w,h;
  
  public TextBox(String t, int r, int g, int b, int x, int y, int w, int h){
    f = createFont("Arial",30);
    set(t);
    red = r;
    green = g;
    blue = b;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  ////DEFAULT CONSTRUCTOR
  public TextBox(String t, int x, int y){
    f = createFont("Arial",20);
    set(t);
    red = 255;
    green = 255;
    blue = 255;
    this.x = x;
    this.y = y;
    w = 100;
    h = 50;
    display();
  }
  
  public void display(){
    clear();
    textFont(f);
    fill(0);
    text(txt,x+15,y+37);
  }    
  
  public void set(String t){
    txt = t;
    display();
  }
  
  public void add(String t){
    txt += t;
    display();
  }
  
  public void clear(){
    fill(red, green, blue);
    rect(x,y,w,h,7);
  }
  
  public void setLocation(int x, int y){
    this.x = x;
    this.y = y;
  }
  
}
