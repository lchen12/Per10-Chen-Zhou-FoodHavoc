public class Table extends Furniture{

  private int seats;
  private ArrayList<Chair> chairs;
  
  public Table(int s){
    super(20,"woodTable.gif",100,100);
    seats = s;
    chairs = new ArrayList<Chair>();
  }

  public Table(int s, int x, int y){
    super(20,"woodTable.gif",100,100,x,y);
    seats = s;
    chairs = new ArrayList<Chair>();
  }

  public void addChair(){
    if (chairs.size() < seats){
      chairs.add(new Chair());
    }else{
      text("Table has reached maximum capacity. Cannot add anymore chairs.", 0,0);
    }
  }
}
