import java.util.*;
import java.io.*;

//use queue for steps

Hashtable<String, String> users;
MyLinkedList<Clickable> f;
TextBox txt, restart;
Player p;
String state, input, entry, username;
boolean entered;
PImage image,play,buy;

void setup() {
  //size(displayWidth, displayHeight);
  size(1024, 768);
  f = new MyLinkedList<Clickable>();
  txt = new TextBox("", 20, 216, 222, 0, 0, displayWidth, 50); //cyan color
  restart = new TextBox("Restart", 255, 0, 0, displayWidth-150, 50, 150, 50);
  //String[] fontList = PFont.list();
  //println(fontList);
 // state = "welcome";
  state = "purchase";
  input = "";
  users = new Hashtable<String, String>();
  entered = false;
  username = "";
  readUsersFile();
  image = loadImage("diner.png");

}

void draw() {
  background(image);
  txt.display();
  restart.display();
  Iterator<Clickable> itr = f.iterator();
  while (itr.hasNext ()) {
    Clickable c = itr.next();
    c.display();
  }
  Clickable  c = new Button("play.gif",600,350);
  f.add(c);
  c= new Button("buy.gif",600,500);
  f.add(c);
  if (state.equals("welcome")) {
    txt.set("Welcome to FOOD HAVOC! Do you have an account? Type (y) or (n)");
    ///////////////HOW TO WAIT FOR USER??//////////////
    if (key == 'y' || key == 'Y') {
      input = "";
      state = "confirmUsername";
    } else if (key == 'n' || key == 'N') {
      input = "";
      state = "makeUsername";
    }
  } else if (state.equals("error")) {
    txt.set("Error. Please restart and try again.");
  } else if (state.equals("confirmUsername")) {
    confirmUsername();
  } else if (state.equals("makeUsername")) {
    makeUsername();
  } else if (state.equals("confirmPassword")) {
    confirmPassword();
  } else if (state.equals("makePassword")) {
    makePassword();
  } else if (state.equals("play")) {
    txt.set("Play!");
  } else if (state.equals("purchase")) {
    purchase();
  } else if (state.equals("setPurchase")){
    setPurchase();
  }
}

void readUsersFile() { ////THIS TAKES USERNAMES+PASSWORDS FROM USERS.CSV AND PUTS THEM INTO HASHTABLE
  String[] lines = loadStrings("users.csv");
  for (String l : lines) {
    String[] a = l.split(",");
    users.put(a[0], a[1]);
  }
  System.out.println(users);
}

void addToUsersFile(String p) { /////THIS ADDS THE NEW USERNAME+PASSWORD INTO USERS.CSV
  String[] before = loadStrings("users.csv");
  String[] after = new String[before.length+1];
  for (int i = 0; i < before.length; i++) {
    after[i] = before[i];
  }
  after[after.length-1] = username+","+p;
  saveStrings("users.csv", after);
  /*
  PrintWriter output = createWriter("users.csv"); 
   output.append(before+"\n"+username+","+p);
   output.flush();
   output.close();
   */
}

/*
void addUser(String u, String p) {
 users.put(u, p);
 }
 */
void confirmUsername() {
  txt.set("Please type your Username and then press Enter: "+input);
  if (entered) {
    if (checkUsername(entry)) {    
      state = "confirmPassword";
    }
  }
}

boolean checkUsername(String u) {
  if (users.containsKey(u)) {
    username = u;
    entered = false;
    return true;
  }
  state = "error";
  entered = false;
  return false;
}      

void confirmPassword() {
  txt.set("Please type your Password and then press Enter.");
  if (entered) {
    checkPassword(entry);
  }
}

void checkPassword(String p) {
  if (users.get(username).equals(p)) {
    state = "play";
  } else {
    state = "error";
  }
  entered = false;
}

void makeUsername() {
  txt.set("To make an account, please type a new Username and then press Enter: "+input);
  if (entered) {
    if (checkUsername(entry)) {
      state = "error";
    } else {
      username = entry;
      state = "makePassword";
    }
  }
  entered = false;
}

void makePassword() {
  txt.set("Please enter a new Password and then press Enter.");
  if (entered) {
    users.put(username, entry);
    entered = false;
    state = "play";
    addToUsersFile(entry);
  }
}

void purchase() {
  txt.set("Click on an item you would like to purchase.");
  int sizeBefore = f.size();
  Clickable c = new Chair(200,200);
  f.add(c);
  c=new Coffee(300,200);
  
  f.add(c); 
  c = new Table(4,400,200);
  f.add(c); 
  c = new DishWasher(500,200);
  f.add(c); 
  int sizeAfter = f.size();
  print(f);
  for (int i = sizeBefore; i < sizeAfter; i++){
    Furniture a = (Furniture)(f.get(i));
    print(i);
    print(a.getPrice());
    text("$"+a.getPrice(), a.getX(), a.getY()-10);
  }
  for (int i = 0; i < f.size (); i++) {
    if (f.get(i).isClicked()){
      Clickable chosen = f.get(i);
      chosen.unclick();
      f.remove(i);
      f.add(chosen);
      state = "setPurchase";
    }
  }
}

void setPurchase(){
  txt.set("Click where you wish to place your new item.");
  f.get(f.size()-1).setLocation(mouseX,mouseY);
  if (mousePressed){
    state = "purchase";
  }
} 

void keyPressed() {
  //print(input.indexOf('?'));
  //input = input.replace('?', ' ');
  if ((int)key==10) {
    clearInput();
  } else if ((int)key==8 || (int)key==65535) { //SHIFT AND CAPSLOCK?????????????
    if (input.length()>0) {
      input = input.substring(0, input.length()-1);
    }
  } else {
    if (key!='?') {
      input += key;
      System.out.println((int)key + " " +key + ", "+ input);
    }
  }
}

void clearInput() {
  entry = input;
  input = "";
  entered = true;
}

void deleteInventory() {
  for (int i = 0; i < f.size (); i++) {
    if (f.get(i).isClicked()) {
      f.remove(i);
    }
  }
}

void mousePressed() {
  ///////////IF PERSON CLICKS RESTART BUTTON.......
  if (mouseX >= displayWidth-150 && mouseX <= displayWidth &&
    mouseY >= 50 && mouseY <= 100) {
    state = "welcome";
    return;
  }

  for (int i = 0; i < f.size (); i++) {
    if (f.get(i).over()) {
      f.get(i).click();
      println(f.get(i).isClicked());
    }
  }
}

