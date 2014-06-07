import java.util.*;

public class Food extends Furniture {

  private Random rand;

  public Food(int x, int y) {
    super(0, "food.gif", 30, 25, x, y);
    rand = new Random();
    int picker = rand.nextInt(4); //0,1,2,3. if 0, use food.gif
    if (picker==1){
      setImage("food1.gif");
    }else if (picker==2){
      setImage("food2.gif");
    }else if (picker==3){
      setImage("food3.gif");
    }
  }

  public String toString() {
    return "Food";
  }
}

