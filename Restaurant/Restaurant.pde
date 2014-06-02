import java.util.*;
import java.io.*;

Hashtable<String, String> users;
ArrayList<Furniture> items; ///furniture that the player has already bought
ArrayList<Clickable> f; ///furniture+customers to be displayed in game
LinkedList<Clickable> moves; ///furniture+customers player has clicked on and wants to move to (First In First Out data structure) 
TextBox txt, restart;
Player p;
String state, input, entry, username;
boolean entered, mouseClicked;
Clickable current; //item that player just clicked on
int id;
PImage image, play, buy;

void setup() {
  size(displayWidth, displayHeight);
  f = new ArrayList<Clickable>();
  moves = new LinkedList<Clickable>();
  items = new ArrayList<Furniture>();
  txt = new TextBox("", 20, 216, 222, 0, 0, displayWidth, 50); //cyan color
  restart = new TextBox("Restart", 255, 0, 0, displayWidth-150, 50, 150, 50);
  //String[] fontList = PFont.list();
  //println(fontList);
  state = "welcome";
  input = "";
  users = new Hashtable<String, String>();
  entered = false;
  username = "";
  readUsersFile();
  image = loadImage("diner.png");
  current = null;
}

void draw() {
  image.resize(displayWidth, displayHeight);
  background(image);
  txt.display();
  restart.display();
  Iterator<Furniture> itr = items.iterator();
  while (itr.hasNext ()) {
    Clickable c = itr.next();
    c.display();
  }
  Clickable  c = new Button("play.gif", 600, 350);
  f.add(c);
  c= new Button("buy.gif", 600, 500);
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
  } else if (state.equals("mainScreen")) {
    txt.set("FOOD HAVOC");
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
  } else if (state.equals("choosePlayer")) {
    choosePlayer();
  } else if (state.equals("play")) {
    if (p==null) {
      state = "choosePlayer";
    } else {
      play();
    }
  } else if (state.equals("purchase")) {
    purchase();
  } else if (state.equals("deleteInventory")) {
    deleteInventory();
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
  after[after.length-1] = username+","+p+","+(after.length-1);
  saveStrings("users.csv", after);
}

void mainScreen() {
  int x = 200;
  int y = 200;
  TextBox play = new TextBox("PLAY", 0, 255, 0, x, y, 150, 50);
  TextBox purchase = new TextBox("SHOP", 0, 255, 0, x, y+100, 150, 50);
  TextBox logout = new TextBox("LOGOUT", 0, 255, 0, x, y+200, 150, 50);
  if (mouseClicked) {
    if (mouseX > x && mouseX < x+150) {
      if (mouseY > y && mouseY < y+50) {
        state = "play";
      } else if (mouseY > y+100 && mouseY < y+150) {
        state = "purchase";
      } else if (mouseY > y+200 && mouseY < y+250) {
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
    setid();
    initiatePlayer();
    setFurniture();
  } else {
    state = "error";
  }
  entered = false;
}

void setid() {
  String[] lines = loadStrings("users.csv");
  for (String l : lines) {
    String[] a = l.split(",");
    if (username.equals(a[0])) {
      id = Integer.parseInt(a[2]);
    }
  }
}

///READS PLAYERS.CSV AND TAKES THE NUMBERS///////////////////
void initiatePlayer() {
  String[] lines = loadStrings("players.csv");
  if (lines[id].equals("null")) {
    state = "choosePlayer";
    return;
  }
  String[] variables = lines[id].split(",");
  p = new Player(variables[0], Integer.parseInt(variables[1]), Integer.parseInt(variables[2]), Integer.parseInt(variables[3]), Integer.parseInt(variables[4]));
}


void makeUsername() {
  txt.set("To make an account, please type a new Username and then press Enter: "+input);
  if (entered) {
    if (entry.equals("")) {
      state = "makeUsername";
    } else if (checkUsername(entry)) {
      state = "error";
    } else {
      username = entry;
      state = "makePassword";
    }
    entered = false;
  }
}

void makePassword() {
  txt.set("Please enter a new Password and then press Enter.");
  if (entered) {
    users.put(username, entry);
    entered = false;
    state = "choosePlayer";
    addToUsersFile(entry);
    addLineToPlayersFile();
    setid();
    addFurniture();
    setFurniture();
  }
}

//ensures that players.csv has same number of lines has users.csv///
void addLineToPlayersFile() {
  String[] before = loadStrings("players.csv");
  String[] after = new String[before.length+1];
  for (int i = 0; i < before.length; i++) {
    after[i] = before[i];
  }
  after[after.length-1] = "null";
  saveStrings("players.csv", after);
}

void choosePlayer() {
  txt.set("Would you like your server to be male(m) or female(f)? Type m or f.");
  if (key == 'm' || key == 'M') {
    p = new Player("male");
    state = "play";
    addPlayer();
  } else if (key == 'f' || key == 'F') {
    p = new Player("female");
    state = "play";
    addPlayer();
  }
}

///WRITES NEW PLAYER INTO PLAYERS.CSV///////////////////
void addPlayer() {
  String[] players = loadStrings("players.csv");
  players[players.length-1] = p.getGender()+","+p.getLevel()+","+p.getMoney()+","+p.getGoal()+","+p.getSpeed();
  saveStrings("players.csv", players);
}

/////////////ADDS BASIC FURNITURE AND SAVES THEM INTO FILE FOR FUTURE REFERENCE
void addFurniture() {
  PrintWriter output = createWriter("users/"+username+".csv");
  output.println("chair,500,500");
  output.println("chair,500,600");
  output.println("table,400,500");
  output.println("diswasher,700,300");
  output.flush();
  output.close();
}
//////////EXTRACTS LIST OF FURNITURE FROM FILE INTO ARRAYLIST<FURNITURE> ITEMS
void setFurniture() {
  String[] stuff = loadStrings("users/"+username+".csv");
  for (String s : stuff) {
    String variables[] = s.split(",");
    if (variables[0].equals("chair")) {
      items.add(new Chair(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
    } else if (variables[0].equals("coffee")) {
      items.add(new Coffee(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
    } else if (variables[0].equals("dishwasher")) {
      items.add(new DishWasher(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
    } else if (variables[0].equals("table")) {
      items.add(new Table(4, Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
    }
  }
}

//////////SAVES THE FURNITURE THAT USER BOUGHT INTO FILE
void saveFurniture() {
  String[] after = new String[items.size()];
  for (int i = 0; i < after.length; i++) {
    Furniture a = items.get(i);
    after[i] = a.toString()+","+a.getX()+","+a.getY();
  }
  saveStrings("users/"+username+".csv", after);
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
  if (mouseClicked) {
    if (mouseX > x && mouseY < y+100 && mouseY > y) {
      if (mouseX < x+100) {
        items.add(new Chair());
      } else if (mouseX < x+200) {
        items.add(new Coffee());
      } else if (mouseX < x+300) {
        items.add(new Table(4));
      } else if (mouseX < x+400) {
        items.add(new DishWasher());
      }
      state = "setPurchase";
    }
    mouseClicked = false;
  }
}

void displayPrice(Furniture a) {
  text("$"+a.getPrice(), a.getX(), a.getY()-10);
}

void setPurchase() {
  txt.set("Click where you wish to place your new item.");
  Furniture current = items.get(items.size()-1);
  current.setLocation(mouseX, mouseY);
  int price = current.getPrice();
  if (mouseClicked) {
    p.addMoney(-price);
    state = "purchase";
    saveFurniture();
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

//////////NOTE TO SELF: ACTIVATE THIS FUNCTION AND MAKE AN EDIT RESTUARANT FUNCTION///////////
void deleteInventory() {
  for (int i = 0; i < f.size (); i++) {
    if (f.get(i).isClicked()) {
      f.remove(i);
    }
  }
}

void play() {
  txt.set("When a customer arrives, click on the customer, click on a table, and start serving!");
  p.display();
  if (mouseClicked) {
    if (current!=null) {
      moves.add(current);
      print(moves);
      current = null;
    }
    mouseClicked = false;
  }
  if (moves.size()>0) {
    ////true if player finished moving to Clickable
    if (p.move(moves.peek())) {
      moves.remove();
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
  for (int i = 0; i < items.size (); i++) {
    if (items.get(i).over()) {
      items.get(i).click();
      current = items.get(i);
    }
  }
}

