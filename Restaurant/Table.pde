public class Table extends Furniture{

  private int seats;
  private ArrayList<Chair> chairs;
  
  public Table(int x){
    super(20,"woodTable.gif",40,40);
    seats = x;
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
