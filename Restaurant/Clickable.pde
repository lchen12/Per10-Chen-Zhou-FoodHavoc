public class Clickable {

  private int x, y, w, h;
  private PImage img;
  private boolean clicked;

  public Clickable(String gif, int w, int h) {
    img = loadImage(gif);
    img.resize(w, h);
    this.w = w;
    this.h = h;
    x = mouseX - w/2;
    y = mouseY - h/2;
    display();
  }

  public Clickable(String gif, int w, int h, int x, int y) {
    img = loadImage(gif);
    img.resize(w, h);
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    display();
  }

  /////////CONSTRUCTOR ONLY FOR PARTY CLASS
  public Clickable(int x, int y) {
    img = null;
    this.x = x;
    this.y = y;
    display();
  }

  public void display() {
    image(img, x, y);
  }

  public boolean over() {
    if (mouseX >= x && mouseX <= x+w &&
      mouseY >= y && mouseY <= y+h) {
      //isOver = true;
      return true;
    } else {
      //isOver = false;
      return false;
    }
  }

  public boolean isClicked() {
    return clicked;
  }

  public void click() {
    clicked = true;
  }

  public void unclick() {
    clicked = false;
  }

  public void size(int w, int h) {
    this.w = w;
    this.h = h;
    if (img!=null){
      img.resize(w, h);
    }
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }
  public int getW() {
    return w;
  }

  public int getH() {
    return h;
  }

  public void setImage(String gif) {
    img = loadImage(gif);
    img.resize(w, h);
  }

  public void setLocation(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

