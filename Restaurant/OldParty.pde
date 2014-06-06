public class OldParty extends Party {

  private ArrayList<Customer> customers;
  private int size;

  public OldParty(Random rand, int max, int x, int y) {
    super(rand, max, x, y, "YoungLady");
    customers = new ArrayList<Customer>();
    OldLady ol = new OldLady();
    ol.setLocation(x, y);
    customers.add(ol);
    OldMan om = new OldMan();
    om.setLocation(x+20, y);
    customers.add(om);
    if (max<=2){
      size = 2;
      size(ol.getW()+om.getW(), om.getH());
    } else {
      size = 4;
      OldLady ol2 = new OldLady();
      ol2.setLocation(x-20, y);
      customers.add(ol);
      OldMan om2 = new OldMan();
      om2.setLocation(x+40, y);
      customers.add(om2);
      size(2*getW(), getH());
    }
  }

  public void display() {
    for (int i = 0; i < size; i++) {
      customers.get(i).display();
    }
  }
}

