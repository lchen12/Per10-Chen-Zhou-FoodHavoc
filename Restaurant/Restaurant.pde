import java.util.*;
import java.io.*;

//use queue for steps

Hashtable<String, String> users;
MyLinkedList<Clickable> f;
TextBox txt, restart;
Player p;
String state, input, entry, username;
boolean entered, mouseClicked;
PImage image;

void setup() {
  //size(displayWidth, displayHeight);
  size(1024, 768);
  f = new MyLinkedList<Clickable>();
  txt = new TextBox("", 20, 216, 222, 0, 0, displayWidth, 50); //cyan color
  restart = new TextBox("Restart", 255, 0, 0, displayWidth-150, 50, 150, 50);
  //String[] fontList = PFont.list();
  //println(fontList);
  //state = "welcome";
  state = "mainScreen";
  input = "";
  users = new Hashtable<String, String>();
  entered = false;
  username = "";
  readUsersFile();
  image = loadImage("diner.png");
  p = new Player();
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
  } else if (state.equals("mainScreen")){
    mainScreen();
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
  } else if (state.equals("setPurchase")) {
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
}

void mainScreen(){
  int x = 200;
  int y = 200;
  TextBox play = new TextBox("PLAY", 0, 255, 0, x, y, 150, 50);
  TextBox purchase = new TextBox("SHOP", 0, 255, 0, x, y+100, 150, 50);
  TextBox logout = new TextBox("LOGOUT", 0, 255, 0, x, y+200, 150, 50);
  if (mouseClicked){
    if (mouseX > x && mouseX < x+150){
      if (mouseY > y && mouseY < y+50){
        state = "play";
      }else if (mouseY > y+100 && mouseY < y+150){
        state = "purchase";
      }else if (mouseY > y+200 && mouseY < y+250){
        state = "welcome";
      }
    }
    mouseClicked = false;
  }
}

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
    state = "mainScreen";
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
    state = "mainScreen";
    addToUsersFile(entry);
  }
}

void purchase() {
  txt.set("Click on an item you would like to purchase.");
  //int sizeBefore = f.size();
  int cols = 5;
  int rows = 1;
  int x = 200;
  int y = 200;
  //////MAKES A CHART TO DISPLAY THE ITEMS TO PURCHASE//////////
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      fill(255);
      stroke(0);
      rect(x, y, 100, 100); 
      x+=100;
    }
  }
  x = 200;
  Furniture c = new Chair(x, y);
  displayPrice(c);
  Furniture d = new Coffee(x+100, y);
  displayPrice(d); 
  Furniture e = new Table(4, x+200, y);
  displayPrice(e);
  Furniture g = new DishWasher(x+300, y);
  displayPrice(g);
  if (mouseClicked){
    if (mouseX > x && mouseY < y+100 && mouseY > y){
      if (mouseX < x+100){
        f.add(new Chair());
      }else if (mouseX < x+200){
        f.add(new Coffee());
      }else if (mouseX < x+300){
        f.add(new Table(4));
      }else if (mouseX < x+400){
        f.add(new DishWasher());
      }
      state = "setPurchase";
    }
    mouseClicked = false;
  }
  
}

void displayPrice(Furniture a){
  text("$"+a.getPrice(),a.getX(),a.getY()-10);
}

void setPurchase() {
  txt.set("Click where you wish to place your new item.");
  Furniture current = (Furniture)f.get(f.size()-1);
  current.setLocation(mouseX, mouseY);
  int price = current.getPrice();
  if (mouseClicked) {
    p.addMoney(-price);
    state = "purchase";
    mouseClicked = false;
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

void mouseReleased() {
  mouseClicked = true;
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

