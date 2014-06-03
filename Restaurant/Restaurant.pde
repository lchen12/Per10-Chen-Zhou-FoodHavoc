import java.util.*;
import java.io.*;

//////////somehow use stacks?
Hashtable<String, String> users;
ArrayList<Furniture> items; ///furniture that the player has already bought
ArrayList<Clickable> f; ///furniture+customers to be displayed in game
LinkedList<Clickable> moves; ///furniture+customers player has clicked on and wants to move to (First In First Out data structure) 
TextBox txt, mainScreen, stats;
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
  username = null;
  id = 0;
  txt = new TextBox("", 20, 216, 222, 0, 0, displayWidth, 50); //cyan color
  //////////I CHANGED THE RESTART BUTTON INTO A MAIN SCREEN BUTTON
  mainScreen = new TextBox("Main Screen", 0, 255, 0, displayWidth-200, 50, 200, 50);
  stats = new TextBox("", 255, 255, 255, displayWidth-200, 100, 200, 300);
  stats.setSize(20);
  //String[] fontList = PFont.list();
  //println(fontList);
  state = "welcome";
  input = "";
  users = new Hashtable<String, String>();
  entered = false;
  readUsersFile();
  image = loadImage("diner.png");
  image.resize(displayWidth, displayHeight);
  current = null;
}

void draw() {
  background(image);
  txt.display();
  mainScreen.display();
  stats.display();
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
    if (username == null) {
      state = "welcome";
    } else if (p==null) {
      state = "choosePlayer";
    } else {
      play();
    }
  } else if (state.equals("purchase")) {
    purchase();
  } else if (state.equals("purchaseChair")) {
    purchaseChair();
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
        ///////////if player clicked PLAY button..........
      if (mouseY > y && mouseY < y+50) {
        state = "play";
        ///////////if player clicked SHOP button..........
      } else if (mouseY > y+100 && mouseY < y+150) {
        state = "purchase";
        ///////////if player clicked LOG OUT button..........
      } else if (mouseY > y+200 && mouseY < y+250) {
        f = new ArrayList<Clickable>();
        moves = new LinkedList<Clickable>();
        items = new ArrayList<Furniture>();  
        username = null;
        id = 0;
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
    username = null;
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
  ////updates Stats textbox
  stats.set("Name: "+username+"\nLevel: "+p.getLevel()+"\nMoney: "+p.getMoney()+"\nSpeed: "+p.getSpeed());
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
    startFurniture();
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
  } else if (key == 'f' || key == 'F') {
    p = new Player("female");
  }
  state = "play";
  savePlayer();
}

///SAVES PLAYER INTO PLAYERS.CSV///////////////////
void savePlayer() {
  String[] players = loadStrings("players.csv");
  players[id] = p.getGender()+","+p.getLevel()+","+p.getMoney()+","+p.getGoal()+","+p.getSpeed();
  saveStrings("players.csv", players);
}

/////////////ADDS BASIC FURNITURE AND SAVES THEM INTO FILE FOR FUTURE REFERENCE
void startFurniture() {
  PrintWriter output = createWriter("users/"+username+".csv");
  output.println("table,400,500,4,2");
  output.println("diswasher,700,300");
  output.flush();
  output.close();
}
//////////EXTRACTS LIST OF FURNITURE FROM FILE INTO ARRAYLIST<FURNITURE> ITEMS
void setFurniture() {
  String[] stuff = loadStrings("users/"+username+".csv");
  for (String s : stuff) {
    String variables[] = s.split(",");
    /*if (variables[0].equals("chair")) {
     items.add(new Chair(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
     } else*/    if (variables[0].equals("coffee")) {
      items.add(new Coffee(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
    } else if (variables[0].equals("dishwasher")) {
      items.add(new DishWasher(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
    } else if (variables[0].equals("table")) {
      items.add(new Table(Integer.parseInt(variables[1]), Integer.parseInt(variables[2]), Integer.parseInt(variables[3]), Integer.parseInt(variables[4])));
    }
  }
}

//////////SAVES THE FURNITURE THAT USER BOUGHT INTO FILE
void saveFurniture() {
  String[] after = new String[items.size()];
  for (int i = 0; i < after.length; i++) {
    Furniture a = items.get(i);
    if (a.toString().equals("table")) {
      Table b = (Table) a;
      after[i] = b.toString()+","+b.getX()+","+b.getY()+","+b.getMaxSeats()+","+b.getSeats();
      println(after[i]);/////////////////////////////////////////////////////
    } else {
      after[i] = a.toString()+","+a.getX()+","+a.getY();
    }
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
  Furniture c = new Chair(x, y, "faceLeft");
  displayPrice(c);
  Furniture d = new Coffee(x+100, y);
  displayPrice(d);
  Furniture e = new Table(x+200, y, 4, 0);
  displayPrice(e);
  Furniture g = new DishWasher(x+300, y);
  displayPrice(g);
  if (mouseClicked) {
    if (mouseX > x && mouseY < y+100 && mouseY > y) {
      if (mouseX < x+100) {
        state = "purchaseChair";
      } else {
        if (mouseX < x+200) {
          items.add(new Coffee());
        } else if (mouseX < x+300) {
          items.add(new Table(4));
        } else if (mouseX < x+400) {
          items.add(new DishWasher());
        }
        state = "setPurchase";
      }
    }
    mouseClicked = false;
  }
}

void purchaseChair() {
  txt.set("Select the table you would like to add the chair to.");
  TextBox cancel = new TextBox("Cancel", 255, 0, 0, displayWidth-400, 50, 150, 50);
  if (mouseClicked) {
    ///if player clicked on cancel button........
    if (mouseX >= displayWidth-400 && mouseY <= 100) {
      state = "purchase";
    } else {
      if (current!=null && current.toString().equals("table")) {
        Table a = (Table) current;
        if (a.addChair()) {
          if (p.addMoney(-(a.getPrice()))) {
            saveFurniture();
            savePlayer();
            state = "purchase";
          } else {
            a.removeChair();
          }
        }
        current = null;
      }
    }
    mouseClicked = false;
  }
}


void displayPrice(Furniture a) {
  text("$"+a.getPrice(), a.getX(), a.getY()-10);
}

void setPurchase() {
  txt.set("Click where you wish to place your new item.");
  TextBox cancel = new TextBox("Cancel", 255, 0, 0, displayWidth-400, 50, 150, 50);
  Furniture current = items.get(items.size()-1/*items.peek()*/);
  current.setLocation(mouseX, mouseY);
  int price = current.getPrice();
  if (mouseClicked) {
    //println(mouseX+","+mouseY);
    //println(displayWidth-300+","+100);
    ///if the person clicked on the cancel button....
    if (mouseX >= displayWidth-400 && mouseY <= 100) {
      items.remove(items.size()-1);
    } else {
      if (p.addMoney(-price)) {
        saveFurniture();
        savePlayer();
      }
    }
    state = "purchase";
    ////////////TO DO: NOTIFY PLAYER THAT HE DOESN'T HAVE ENOUGH $$ TO PURCHASE ITEM
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
  for (int i = 0; i < items.size (); i++) {
    if (items.get(i).isClicked()) {
      items.remove(i);
      saveFurniture();
      savePlayer();
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
  ///////////IF PERSON CLICKS THE MAIN SCREEN BUTTON.......
  if (mouseX >= displayWidth-200 && mouseX <= displayWidth &&
    mouseY >= 50 && mouseY <= 100) {
    //username = null;
    //id = 0;
    state = "mainScreen";
    return;
  }
  for (int i = 0; i < items.size (); i++) {
    if (items.get(i).over()) {
      items.get(i).click();
      current = items.get(i);
    }
  }
}

