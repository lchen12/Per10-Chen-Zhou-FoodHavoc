ArrayList<Furniture> f;

void setup() {
  size(1000, 700);
  background(255);
  f = new ArrayList<Furniture>();
  Text t = new Text("FOOD HAVOC");
}

void draw() {
  if (mousePressed) {
    Furniture chair = new Table(4);
    f.add(chair);
  }
}
