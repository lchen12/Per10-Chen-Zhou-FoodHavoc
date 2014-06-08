//party for the 2 old people
public class OldParty extends Party {

  public OldParty(Random rand, int max, int x, int y, Player p) {
    super(rand, max, x, y, "YoungLady", p);
    ArrayList<Customer> c = new ArrayList<Customer>();
    OldLady ol = new OldLady();
    ol.setLocation(x, y);
    c.add(ol);
    OldMan om = new OldMan();
    om.setLocation(x+20, y);
    c.add(om);
    int size = rand.nextInt(max)+1;
    if (size<=2) {
      setSize(2);
      size(ol.getW()+om.getW(), om.getH());
    } else {
      setSize(4);
      OldLady ol2 = new OldLady();
      ol2.setLocation(x-20, y);
      c.add(ol);
      OldMan om2 = new OldMan();
      om2.setLocation(x+40, y);
      c.add(om2);
      size(2*getW(), getH());
    }
    setCustomers(c);
    setMaxPatience((int)(customers.get(0).getPatience()*p.getPatienceFactor()));
    setPatience(getMaxPatience());
    //setSpeed(customers.get(0).getSpeed()*p.getCustomerSpeedFactor());
  }
}

