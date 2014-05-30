import java.util.*;

//use queue for steps

MyLinkedList<Clickable> f;
TextBox t;
String state, input;

void setup() {
  size(displayWidth, displayHeight);
  background(255);
  f = new MyLinkedList<Clickable>();
  t = new TextBox("FOOD HAVOC");
  //String[] fontList = PFont.list();
  //println(fontList);
  state = "Welcome";
  input = "";
}

void draw() {
  background(255);
  t.display();
  Iterator<Clickable> itr = f.iterator();
  while (itr.hasNext()){
    Clickable c = itr.next();
    c.display();
  }
  if (state.equals("Welcome")){
    t.set("Welcome to FOOD HAVOC! Do you have an account? Type (y) or (n)");
    ///////////////HOW TO WAIT FOR USER??//////////////
    if (key == 'y' || key == 'Y'){
      //clearInput();
      confirmUsername();
    }else if (key == 'n' || key == 'N'){
      makeUsername();
    }
  }
}

void confirmUsername(){
  t.set("Please type your Username: "+input);
}

void makeUsername(){
  t.set("To make an account, please type a Username and press Enter.");
  t.add(input);
}

void keyReleased(){
  input += key;
  System.out.println((int)key + " " +key + ", "+ input);
}

void clearInput(){
  input = "";
  System.out.println(input);
}

void mousePressed(){
  for (int i = 0; i < f.size(); i++){
    if (f.get(i).over()){
      f.remove(i);
    }else{
    }
  }
  Furniture chair = new Chair();
  f.add(chair);
  Customer person = new YoungLady();
  f.add(person);
}
