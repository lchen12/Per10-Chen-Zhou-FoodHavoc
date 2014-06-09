public class Close extends Clickable {

  public Close(){
    super("close.gif", 400, 300);
  }

  public Close(int x,int y){
    super("close.gif", 400, 300, x, y);
  }
  public String toString() {
    return "close";
  }
}
