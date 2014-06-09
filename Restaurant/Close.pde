public class Close extends Furniture {

  public Close(){
    super(20, "close.gif", 36, 50);
  }

  public Close(int x,int y){
    super(20, "close.gif", 36, 50, x, y);
  }
  public String toString() {
    return "close";
  }
}

