public class Button extends Clickable {

  public Button() {
    super("play.gif", 100, 200, 500, 500);
  }

  public Button(String gif, int x, int y) {
    super(gif, 200, 100, x, y);
  }
}

