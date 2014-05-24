class Table extends Furniture{

  int seats;
  ArrayList<Chair> chairs;
  
  Table(int x){
    super(20,"woodTable.gif",40,40);
    seats = x;
    chairs = new ArrayList<Chair>();
  }

  void addChair(){
    if (chairs.size() < seats){
      chairs.add(new Chair());
    }else{
      text("Table has reached maximum capacity. Cannot add anymore chairs.", 0,0);
    }
  }
}
