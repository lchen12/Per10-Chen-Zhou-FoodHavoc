public class Party extends Clickable {

  private ArrayList<Customer> options;
  private ArrayList<Customer> customers;
  private int size;

  public Party(Random rand, int max, int x, int y) {
    super(x, y);
    size = rand.nextInt(max)+1;
    options = new ArrayList<Customer>();
    customers = new ArrayList<Customer>();
    options.add(new OldLady());
    options.add(new OldMan());
    options.add(new RichMan());
    options.add(new YoungLady());
    options.add(new FoodCritic());    
    for (int i = 0; i < size; i++) {
      int picker = rand.nextInt(options.size());
      customers.add(options.get(picker));
      customers.get(i).setLocation(x+i*20, y);
    }
  }

  public void display() {
    for (int i = 0; i < size; i++) {
      customers.get(i).display();
    }
  }

  public int getSize() {
    return size;
  }
}

