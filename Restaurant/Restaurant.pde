ArrayList<Clickable> f;
TextBox t;

void setup() {
  size(displayWidth, displayHeight);
  background(255);
  f = new ArrayList<Clickable>();
  t = new TextBox("FOOD HAVOC");
  //String[] fontList = PFont.list();
  //println(fontList);
}

void draw() {
}

void mousePressed(){
  for (int i = 0; i < f.size(); i++){
    if (f.get(i).over()){
      f.get(i).delete();///???????????
      f.remove(i);
    }else{
    }
  }
  Furniture chair = new Chair();
  f.add(chair);
}
