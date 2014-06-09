//////////OPTIONAL: ADD A PODIUM TO MAKE CUSTOMERS WAITING IN LINE HAPPIER
////////////really laggy when lots of stuff...

////////////Sound
import ddf.minim.*;
import java.util.*;
import java.io.*;
import java.math.*;

//////sound variables
Minim minim;
AudioPlayer song;
//////////somehow use stacks?
Hashtable<String, String> users;
ArrayList<Furniture> items; ///furniture that the player has already bought
ArrayList<Party> customers; ///customers to be displayed in game
ArrayList<Clickable> f; ///clickable stuff to add to game that doesn't belong to any other arraylist?
LinkedList<Clickable> moves; ///furniture+customers player has clicked on and wants to move to (First In First Out data structure) 
TextBox txt, mainScreen, stats, cancel, continu, play, shop, logout, moveMerchandise, deleteMerchandise, expandTable, yes, no;
Player p;
Party currentParty;
ArrayList<String> options; ////list of customer types to choose from
String state, input, entry, username;
boolean entered, mouseClicked;
Clickable current; //item that player just clicked on
int id, maxPartySize, customersToServe, customersWaiting, customersWaitingForFood, lastTimeCheck, timeInterval, lastTimeCustomer, timeAddCustomer;
//lastTimeCustomer, timeAddCustomer keeps track of how long after the last customers appeared
PImage image /*, play, buy*/;
Close close;
Random rand;

void setup() {
  size(displayWidth, displayHeight);
  rand = new Random(1); /////////create random seed so customers come the same order
  customers = new ArrayList<Party>();
  f = new ArrayList<Clickable>();
  moves = new LinkedList<Clickable>();
  items = new ArrayList<Furniture>();  
  username = null;
  id = 0;
  txt = new TextBox("", 20, 216, 222, 0, 0, displayWidth, 50); //cyan color
  //////////I CHANGED THE RESTART BUTTON INTO A MAIN SCREEN BUTTON
  mainScreen = new TextBox("Main Screen", 0, 255, 0, displayWidth-200, 50, 200, 50);
  yes = new TextBox("YES", 255, 0, 0, displayWidth/2, 50, 100, 50);
  no = new TextBox("NO", 0, 0, 255, displayWidth/2+100, 50, 100, 50);
  stats = new TextBox("", 255, 255, 255, 0, displayHeight-100, displayWidth, 100);
  cancel = new TextBox("Cancel", 255, 0, 0, displayWidth-350, 50, 150, 50);
  continu = new TextBox("Continue", 255, 255, 0, displayWidth-350, 50, 150, 50);
  play = new TextBox("PLAY", 0, 255, 0, displayWidth/5, displayHeight/4, 150, 50);
  shop = new TextBox("SHOP", 0, 255, 0, displayWidth/5, displayHeight/2, 150, 50);
  logout = new TextBox("LOGOUT", 0, 255, 0, displayWidth/5, displayHeight*3/4, 150, 50);
  moveMerchandise = new TextBox("Move Merchandise", 255, 255, 0, displayWidth-500, 50, 300, 50);
  deleteMerchandise = new TextBox("Delete Merchandise", 255, 255, 0, displayWidth-500, 100, 300, 50);
  expandTable = new TextBox("Expand Table", 255, 255, 0, displayWidth-500, 150, 300, 50);
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
  options = new ArrayList<String>();
  options.add("RichMan");
  options.add("YoungLady");
  options.add("FoodCritic");    
  options.add("CollegeKid");
  options.add("Old");
  lastTimeCheck = millis();
  timeInterval = 2000; //2000
  lastTimeCustomer = millis();
  timeAddCustomer = 9000; //9000
  close = new Close(displayWidth/4, displayHeight/4);
  maxPartySize = 2;  minim=new Minim(this);
  song= minim.loadFile("music.mp3");
  song.loop();
}

void draw() {
  background(image);
  txt.display();
  mainScreen.display();
  stats.display();
  Iterator<Furniture> itrI = items.iterator();
  while (itrI.hasNext ()) {
    Clickable c = itrI.next();
    c.display();
  }
  Iterator<Party> itrC = customers.iterator();
  while (itrC.hasNext ()) {
    Clickable c = itrC.next();
    c.display();
  }
  Iterator<Clickable> itrF = f.iterator();
  while (itrF.hasNext ()) {
    Clickable c = itrF.next();
    c.display();
  }
  //Clickable  c = new Button("play.gif", 600, 350);
  //f.add(c);
  //c= new Button("buy.gif", 600, 500);
  //f.add(c);
  if (state.equals("welcome")) {
    txt.set("Welcome to FOOD HAVOC! Do you have an account?");
    yes.display();
    no.display();
    if (mouseClicked) {
      if (mouseX > displayWidth/2 && mouseX < displayWidth/2+100 && mouseY > 50 && mouseY < 100) { ///if clicked on yes button...
        input = "";
        state = "confirmUsername";
      } else if (mouseX > displayWidth/2+100 && mouseX < displayWidth/2+200 && mouseY > 50 && mouseY < 100) {///if clicked on no button...
        input = "";
        state = "makeUsername";
      }
      mouseClicked = false;
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
  } else if (state.equals("seatCustomers")) {
    seatCustomers();
  } else if (state.equals("endLevel")) {
    close();
  } else if (state.equals("shop")) {
    shop();
  } else if (state.equals("moveMerchandise")) {
    moveMerchandise();
  } else if (state.equals("setMerchandise")) {
    setMerchandise();
  } else if (state.equals("notEnoughMoney")) {
    notEnoughMoney();
  } else if (state.equals("purchaseChair")) {
    purchaseChair();
  } else if (state.equals("deleteMerchandise")) {
    deleteMerchandise();
  } else if (state.equals("expandTable")) {
    expandTable();
  } else if (state.equals("confirmDeletion")) {
    confirmDeletion();
  } else if (state.equals("setPurchase")) {
    setPurchase();
  } else if (state.equals("confirmMainScreen")) {
    confirmMainScreen();
  }
}

void stop(){
  song.close();
  minim.stop();
  super.stop();
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
  int x = displayWidth/5;
  play.display();
  shop.display();
  logout.display();
  if (mouseClicked) {
    if (mouseX > x && mouseX < x+150) {
      ///////////if player clicked PLAY button..........
      if (mouseY > displayHeight/4 && mouseY < displayHeight/4+50) {
        if (p!=null) {
          customersToServe = 3+2*p.getLevel(); //total number of parties to be served in each round; based on level
          maxPartySize = 2+p.getLevel()/3;
          timeAddCustomer = 9000 - p.getLevel()*10;
        }
        state = "play";
        ///////////if player clicked SHOP button..........
      } else if (mouseY > displayHeight/2 && mouseY < displayHeight/2+50) {
        state = "shop";
        ///////////if player clicked LOG OUT button..........
      } else if (mouseY > displayHeight*3/4 && mouseY < displayHeight*3/4+50) {
        f = new ArrayList<Clickable>();
        moves = new LinkedList<Clickable>();
        items = new ArrayList<Furniture>();  
        customers = new ArrayList<Party>();
        stats = new TextBox("", 255, 255, 255, displayWidth-200, 100, 200, 300);
        username = null;
        id = 0;
        state = "welcome";
      }
    }
    mouseClicked = false;
  }
}

////////ONLY HAPPENS WHEN PLAYER IS IN PLAYING MODE AND WANTS TO QUIT MID-SHIFT
void confirmMainScreen() {
  txt.set("Are you sure you would like to quit playing? The profits made during your shift will not be saved.");
  yes.display();
  no.display();
  if (mouseClicked) {
    if (mouseX > displayWidth/2 && mouseX < displayWidth/2+100 && mouseY > 50 && mouseY < 100) { ///if clicked on yes button...
      customers = new ArrayList<Party>();
      f = new ArrayList<Clickable>();
      for (int i = 0; i < items.size (); i++) {
        if (items.get(i).toString().equals("table")) {
          ((Table)items.get(i)).setOrderNumber(0);
        }
      }
      p.setLocation(0, 100);
      p.resetProfit();
      state = "mainScreen";
    } else if (mouseX > displayWidth/2+100 && mouseX < displayWidth/2+200 && mouseY > 50 && mouseY < 100) { ///if clicked on no button...
      state = "play";
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
  p = new Player(variables[0], Integer.parseInt(variables[1]), Integer.parseInt(variables[2]), Double.parseDouble(variables[3]), Double.parseDouble(variables[4]), Double.parseDouble(variables[5]), Double.parseDouble(variables[6]));
  ////updates Stats textbox
  updateStats();
}

////updates Stats textbox
void updateStats() {
  String tab = "     ";
  if (p==null) {
    state = "choosePlayer";
    return;
  } else {
    stats.set("Name: "+username+tab+"Level: "+p.getLevel()+tab+"Money: "+p.getMoney()+tab+"Speed: "+round(p.getSpeed(),2)+tab+"Customer Speed Factor: "+round(p.getCustomerSlowFactor(),2)+tab+"Customer Patience Factor: "+
      round(p.getPatienceFactor(),2)+tab+"Chef Cooking Time: "+round(p.getChefTimeCook(),1)+tab+"Profit: "+p.getProfit()+tab+"Goal: "+p.getGoal());
  }
}

public double round(double value, int places) {
    if (places < 0) throw new IllegalArgumentException();
    BigDecimal bd = new BigDecimal(value);
    bd = bd.setScale(places, RoundingMode.HALF_UP);
    return bd.doubleValue();
}

void makeUsername() {
  txt.set("To make an account, please type a new Username and then press Enter: "+input);
  if (entered) {
    if (entry.equals("")) {
      state = "makeUsername";
    } else if (checkUsername(entry)) {
      username = null;
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
    state = "mainScreen";
    savePlayer();
  } else if (key == 'f' || key == 'F') {
    p = new Player("female");
    state = "mainScreen";
    savePlayer();
  }
}

///SAVES PLAYER INTO PLAYERS.CSV///////////////////
void savePlayer() {
  if (p!=null) {
    String[] players = loadStrings("players.csv");
    players[id] = p.getGender()+","+p.getLevel()+","+p.getMoney()+","+p.getSpeed()+","+p.getChefTimeCook()+","+p.getPatienceFactor()+","+p.getCustomerSlowFactor();
    saveStrings("players.csv", players);
  }
}

/////////////ADDS BASIC FURNITURE AND SAVES THEM INTO FILE FOR FUTURE REFERENCE
void startFurniture() {
  PrintWriter output = createWriter("users/"+username+".csv");
  output.println("table,"+displayWidth/2+",500,4,2");
  output.println("trashBin,"+(int)(displayWidth-displayWidth/2.5)+","+(displayHeight/5));
  output.println("orderHolder,"+(int)(displayWidth-displayWidth/3.5)+",150");
  output.flush();
  output.close();
}
//////////EXTRACTS LIST OF FURNITURE FROM FILE INTO ARRAYLIST<FURNITURE> ITEMS
void setFurniture() {
  items = new ArrayList<Furniture>();
  String[] stuff = loadStrings("users/"+username+".csv");
  for (String s : stuff) {
    String variables[] = s.split(",");
    /*if (variables[0].equals("chair")) {
     items.add(new Chair(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
     } else*/    if (variables[0].equals("coffeeMachine")) {
      items.add(new CoffeeMachine(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
    } else if (variables[0].equals("trashBin")) {
      items.add(new TrashBin(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
    } else if (variables[0].equals("orderHolder")) {
      items.add(new OrderHolder(Integer.parseInt(variables[1]), Integer.parseInt(variables[2])));
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
    } else {
      after[i] = a.toString()+","+a.getX()+","+a.getY();
    }
  }
  saveStrings("users/"+username+".csv", after);
}


void shop() {
  txt.set("Click on an item you would like to purchase.");
  //int sizeBefore = f.size();
  int cols = 5;
  int rows = 1;
  int x = displayWidth/10;
  int y = displayHeight/4;
  //////MAKES A CHART TO DISPLAY THE FURNITURE ITEMS TO PURCHASE//////////
  fill(0);
  textSize(40);
  text("FURNITURE", x, y-50);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      fill(255);
      stroke(0);
      rect(x, y, 100, 100);
      x+=150;
    }
  }
  x = displayWidth/10;
  Furniture c = new Chair(x, y, "faceLeft");
  displayPrice(c);
  Furniture d = new CoffeeMachine(x+150, y);
  println(((CoffeeMachine)d).isReady());
  displayPrice(d);
  Furniture e = new Table(x+300, y, 4, 0);
  displayPrice(e);
  Furniture g = new TrashBin(x+450, y);
  displayPrice(g);
  Furniture h = new OrderHolder(x+600, y);
  displayPrice(h);
  //////MAKES A CHART TO DISPLAY UPGRADES (SPEED INCREASE, PATIENCE INCREASE, ETC.) TO PURCHASE//////////
  textSize(40);
  text("UPGRADES", x, y+250);
  String[] upgrades = {
    "Speedy Shoes", "Speedy Chef", "Mellow Customers", "Quick Customers"
  };
  cols = upgrades.length;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      fill(255);
      stroke(0);
      rect(x, y+300, 100, 100);
      displayPrice(upgrades[i], x, y+300);
      x+=150;
    }
  }
  x = displayWidth/10;
  moveMerchandise.display();
  deleteMerchandise.display();
  expandTable.display();
  if (mouseClicked) {
    if (mouseX > x && mouseY < y+100 && mouseY > y) {
      if (mouseX < x+150) {
        state = "purchaseChair";
      } else {
        if (mouseX < x+300) {
          items.add(new CoffeeMachine());
        } else if (mouseX < x+450) {
          items.add(new Table(4));
        } else if (mouseX < x+600) {
          items.add(new TrashBin());
        } else if (mouseX < x+750) {
          items.add(new OrderHolder());
        }
        state = "setPurchase";
      }
    } else if (mouseX > displayWidth-500 && mouseX < displayWidth-200 && mouseY > 50 && mouseY < 100) { ///if clicked on moveMerchandise button...
      state = "moveMerchandise";
    } else if (mouseX > displayWidth-500 && mouseX < displayWidth-200 && mouseY > 100 && mouseY < 150) { ///if clicked on deleteMerchandise button...
      state = "deleteMerchandise";
    } else if (mouseX > displayWidth-500 && mouseX < displayWidth-200 && mouseY > 150 && mouseY < 200) { ///if clicked on expandTable button...
      state = "expandTable";
    } else if (mouseX > x && mouseY < y+400 && mouseY > y+300) {
      if (mouseX < x+150) {
        if (p.addMoney(-70)) {
          p.increaseSpeed();
        } else {
          state = "notEnoughMoney";
        }
      } else if (mouseX < x+300) {
        if (p.addMoney(-50)) {
          p.decreaseChefTimeCook();
        } else {
          state = "notEnoughMoney";
        }
      } else if (mouseX < x+450) {
        if (p.addMoney(-70)) {
          p.increasePatienceFactor();
        } else {
          state = "notEnoughMoney";
        }
      } else if (mouseX < x+600) {
        if (p.addMoney(-60)) {
          p.decreaseCustomerSlowFactor();
        } else {
          state = "notEnoughMoney";
        }
      } else if (mouseX < x+750) {
        ////////////////////
      }
      savePlayer();
    }
    mouseClicked = false;
  }
  updateStats();
}

void displayPrice(Furniture a) {
  textSize(20);
  fill(0);
  text("$"+a.getPrice(), a.getX(), a.getY()-10);
  text(a.toString(), a.getX(), a.getY()-30);
}

void displayPrice(String s, int x, int y) {
  textSize(13);
  fill(0);
  int p = 0;
  if (s.equals("Speedy Shoes")) {
    p = 70;
    text("20% speed\nincrease.", x+5, y+20);
  } else if (s.equals("Speedy Chef")) {
    p = 50;
    text("20% decrease\nin the time\nit takes for\nchef to cook.", x+5, y+20);
  } else if (s.equals("Mellow Customers")) {
    p = 70;
    text("10% additional\npatience", x+5, y+20);
  } else if (s.equals("Quick Customers")) {
    p = 60;
    text("10% quicker\ncustomers", x+5, y+20);
  }
  textSize(18);
  text("$"+p, x, y-10);
  text(s, x, y-30);
}

void purchaseChair() {
  txt.set("Select the table you would like to add the chair to.");
  cancel.display();
  if (mouseClicked) {
    ///if player clicked on cancel button........
    if (mouseX >= displayWidth-350 && mouseY <= 100) {
      state = "shop";
    } else {
      if (current!=null && current.toString().equals("table")) {
        Table a = (Table) current;
        if (a.canAddChair() && p.addMoney(-10)) {
          a.addChair();
          saveFurniture();
          savePlayer();
          state = "shop";
        } else {
          state = "notEnoughMoney";
        }
        current = null;
      }
    }
    mouseClicked = false;
  }
  updateStats();
}

void notEnoughMoney() {
  continu.display();
  txt.set("You do not have enough money to purchase this item.");
  if (mouseClicked) {
    if (mouseX >= displayWidth-350 && mouseY <= 100) { ////if player clicked on continu button
      state = "shop";
    }
    mouseClicked = false;
  }
}

void setPurchase() {
  txt.set("Click where you wish to place your new item.");
  cancel.display();
  Furniture current = items.get(items.size()-1/*items.peek()*/);
  current.setLocation(mouseX, mouseY);
  int price = current.getPrice();
  if (mouseClicked) {
    //println(mouseX+","+mouseY);
    //println(displayWidth-300+","+100);
    ///if the person clicked on the cancel button....
    if (mouseX >= displayWidth-350 && mouseY <= 100) {
      items.remove(items.size()-1);
      state = "shop";
    } else {
      if (p.addMoney(-price)) {
        saveFurniture();
        savePlayer();
        state = "shop";
      } else {
        items.remove(items.size()-1);
        state = "notEnoughMoney";
      }
    }
    mouseClicked = false;
  }
  updateStats();
}

void expandTable() {  
  txt.set("$30 is needed to increase the size of a table by 4 seats. Click on a table you would like to expand.");
  cancel.display();
  if (mouseClicked) {
    ///if the person clicked on the cancel button....
    if (mouseX >= displayWidth-350 && mouseY <= 100) {
      state = "shop";
    } else {
      if (current!=null && current.toString().equals("table")) {
        Table t = (Table) current;
        if (p.addMoney(-30)) {
          t.expand();
          saveFurniture();
          savePlayer();
        } else {
          state = "notEnoughMoney";
        }
        current = null;
      }
    }
    mouseClicked = false;
  }
}

void moveMerchandise() {
  txt.set("Click an item you would like to move.");
  if (mouseClicked) {
    if (current!=null) {
      if (items.contains(current)) {
        items.remove(current);
        items.add((Furniture)current);
        state = "setMerchandise";
      }
      current = null;
    }
    mouseClicked = false;
  }
}

void setMerchandise() {
  txt.set("Click where you wish to place the item.");
  cancel.display();
  Furniture current = items.get(items.size()-1/*items.peek()*/);
  current.setLocation(mouseX, mouseY);
  if (mouseClicked) {
    ///if the person clicked on the cancel button....
    if (mouseX >= displayWidth-350 && mouseY <= 100) {
      setFurniture();
      state = "moveMerchandise";
    } else {
      saveFurniture();
      state = "moveMerchandise";
    }
    mouseClicked = false;
  }
}

void deleteMerchandise() {
  txt.set("Click the item you wish to delete.");
  if (mouseClicked) {
    ///if the person clicked on the cancel button....
    if (mouseX >= displayWidth-350 && mouseY <= 100) {
      state = "shop";
    } else {
      if (current!=null) {
        if (items.contains(current)) {
          items.remove(current);
          items.add((Furniture)current);
          state = "confirmDeletion";
        }
        current = null;
      }
    }
    mouseClicked = false;
  }
}

void confirmDeletion() {  
  yes.display();
  no.display();
  txt.set("Are you sure you wish to delete "+items.get(items.size()-1).toString()+"?");
  if (mouseClicked) {
    if (mouseX > displayWidth/2 && mouseX < displayWidth/2+100 && mouseY > 50 && mouseY < 100) { ///if clicked on yes button...
      input = "";
      items.remove(items.size()-1);
      state = "deleteMerchandise";
      saveFurniture();
    } else if (mouseX > displayWidth/2+100 && mouseX < displayWidth/2+200 && mouseY > 50 && mouseY < 100) { ///if clicked on yes button...
      input = "";
      state = "deleteMerchandise";
    }
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
    }
  }
}

void clearInput() {
  entry = input;
  input = "";
  entered = true;
}

void play() {
  txt.set("When a customer arrives, click on the customer, click on a table, and start serving!");
  p.display();    
  ////////////IF PLAYER ISN'T HOLDING ANYTHING AND NO MORE CUSTOMERS////////////////////////////////
  if (p.getHold()==0 && customers.size()==0 && customersToServe==0) {
    if (p.getProfit()>=p.getGoal()) {
      p.level();
    }
    savePlayer(); //save player's stats
    state = "endLevel";
  }
  for (int i = 0; i < f.size (); i++) {
    if (f.get(i).toString().equals("Chef")) {
      Chef c = (Chef)(f.get(i));
      c.decreaseTime();
    }
  }
  if ( millis() > lastTimeCustomer + timeAddCustomer ) { /////add a customer every (timeCustomer/1000) seconds
    lastTimeCustomer = millis();
    if (customersToServe > 0) { ////if maximum number of customers isn't reached yet...
      int x = displayWidth/8;
      if (customersWaiting > 10) {
        x = displayWidth/32;
      } else if (customersWaiting > 5) {
        x = displayWidth/16;
      }
      int picker = rand.nextInt(options.size());
      String type = options.get(picker);
      if (type.equals("Old")) {
        customers.add(new OldParty(rand, maxPartySize, x, 120+(customersWaiting%5)*150, p));
      } else {
        customers.add(new Party(rand, maxPartySize, x, 120+(customersWaiting%5)*150, type, p));
      }
      customersWaiting++;
      customersToServe--;
    }
  }
  if ( millis() > lastTimeCheck + timeInterval ) {
    lastTimeCheck = millis();
    p.updateTime();
    for (int i = 0; i < items.size (); i++) {
      if (items.get(i).toString().equals("coffeeMachine")) {
        ((CoffeeMachine)items.get(i)).increaseTime();
      }
    }
    for (int i = 0; i < customers.size (); i++) {
      Party party = customers.get(i);
      party.decrease(); //decrease patience of each party every few seconds
      if (party.getPatience()<0) { /////if customer runs how of patience, leaves
        if (party.getState().equals("waiting")) {
          customersWaiting--;
        }
        p.addProfit(party.getSize()*(-100)); ///decreases player's profit
        removeOrderNumber(party);
        customers.remove(i);
      }
      party.increaseTime();
    }
    for (int i = 0; i < f.size (); i++) {
      if (f.get(i).toString().equals("Chef")) {
        Chef c = (Chef)(f.get(i));
        c.decreaseTime();
        if (c.getTime() <= 0) {
          f.add(new ServingDome(c.getX()-50, c.getY(), c.getOrderNumber())); //creates a serving dome on the counter
          f.remove(c);
        }
      }
    }
  }
  if (mouseClicked) {
    if (current!=null) {
      ////////////////IF PLAYER CLICKED A CUSTOMER, AND THAT CUSTOMER IS ON LINE
      if (customers.contains(current) && ((Party)current).getState().equals("waiting")) {
        currentParty = (Party)current;
        state = "seatCustomers";
      } else {
        moves.add(current);
        print(moves);
      }
      current = null;
    }
    mouseClicked = false;
  }
  if (moves.size()>0) {
    ///the next move
    Clickable c = moves.peek();
    ////true if player finished moving to Clickable
    if (p.move(c)) {
      if (customers.contains(c)) {
        currentParty = (Party)c;
        if (p.hasCoffee() && !currentParty.getState().equals("done")) {
          f.remove(p.removeCoffee());
          currentParty.addPatience();
        } else {
          if (currentParty.isReady()) {
            if (currentParty.getState().equals("ordering")) {
              if (p.getHold()<2) {              
                currentParty.removeMenus();
                currentParty.setState("waitingForFood");
                customersWaitingForFood++;
                currentParty.getTable().setOrderNumber(customersWaitingForFood);
                currentParty.addPatience();
                Menu m = new Menu(100, 100, currentParty.getTable().getOrderNumber());
                f.add(m);
                p.holdItem(m);
                p.addProfit("ordering");
              }
            } else if (currentParty.getState().equals("waitingForFood")) {
              if (p.checkDomeOrderNumber(currentParty.getTable().getOrderNumber())) { ////if player is holding a dome with the same order number as party
                f.remove(p.getDome(currentParty.getTable().getOrderNumber()));
                p.removeDome(currentParty.getTable().getOrderNumber());
                customersWaitingForFood--;
                currentParty.getTable().setOrderNumber(0);
                ///put food on table
                currentParty.setState("eating");          
                currentParty.addPatience();
                p.addProfit("waitingForFood");
              }
            } else if (currentParty.getState().equals("eating")) {
              currentParty.getTable().unoccupy();
              p.addProfit("eating");
              currentParty.setState("done");
            } else if (currentParty.getState().equals("done")) {
              p.addProfit("done");
              p.updateTips(currentParty.getPatience()/10);
              p.addMoney(currentParty.getPatience()/10);
              customers.remove(currentParty);
              Plate pl = new Plate(0, 0);
              f.add(pl);
              p.holdItem(pl);
            }
          }
        }
      } else if (f.contains(c)) { ////f is the array of Clickables that doesn't belong to items or customers; it has ServingDomes, food plates, etc...
        if (c.toString().equals("ServingDome")) {
          p.holdItem(c);
        }
      } else if (items.contains(c)) {
        if (c.toString().equals("orderHolder")) {
          Menu m = p.removeMenu();
          if (m!=null) {
            f.remove(m);
            print(m.getOrderNumber());
            f.add(new Chef(displayWidth*3/4+m.getOrderNumber()*25, displayHeight/7+100*m.getOrderNumber(), m.getOrderNumber(), p.getChefTimeCook())); //creates a chef near the dome
            m = p.removeMenu();
            if (m!=null) {
              f.remove(m);
              f.add(new Chef(displayWidth*3/4+m.getOrderNumber()*25, displayHeight/7+100*m.getOrderNumber(), m.getOrderNumber(), p.getChefTimeCook())); //creates a chef near the dome
            }
          }
        } else if (c.toString().equals("trashBin")) {
          Plate pl = p.removePlate();
          if (pl!=null) {
            f.remove(pl);
            pl = p.removePlate();
            if (pl!=null) {
              f.remove(pl);
            }
          }
        } else if (c.toString().equals("coffeeMachine")) {
          ((CoffeeMachine)c).reset();
          Coffee cof = new Coffee();
          f.add(cof);
          p.holdItem(cof);
        }
      }
      moves.remove();
    }
  }
  updateStats();
}

///removes all domes or menus associated with the leaving party's order number
void removeOrderNumber(Party party) {
  if (party.getTable()!=null) {
    int orderNumber = party.getTable().getOrderNumber();
    p.removeOrderNumber(orderNumber);
    party.getTable().setOrderNumber(0);
    for (int i = 0; i < f.size (); i++) {
      Clickable object = f.get(i);
      if (object.toString().equals("ServingDome") && ((ServingDome)object).getOrderNumber()==orderNumber) {
        f.remove(i);
      } else if (object.toString().equals("Menu") && ((Menu)object).getOrderNumber()==orderNumber) {
        f.remove(i);
      }
    }
  }
}

void seatCustomers() {
  txt.set("Click a table to seat the customer(s).");
  cancel.display();
  if (mouseClicked) {
    ///if player clicked on cancel button........
    if (mouseX >= displayWidth-350 && mouseY <= 100) {
      state = "play";
    } else if (current!=null && current.toString().equals("table")) {
      Table t = (Table) current;
      ////////if table has enough seats and table isn't occupied..........
      if (currentParty.getSize() <= t.getSeats() && !t.isOccupied()) {
        /////set party's table
        currentParty.addTable(t);
        //println(currentParty.getW()+","+currentParty.getH()+": table "+t.getW()+","+t.getH());
        /////set table as occupied
        t.occupy();
        currentParty.setLocation(t);
        currentParty.setState("ordering");
        currentParty.addMenus();
        customersWaiting--;
        currentParty.addPatience();
        state = "play";
      }
      current = null;
    }
    mouseClicked = false;
  }
}

void close() {
  close.display();
  endLevel();
}

void endLevel() {
  continu.display();
  if (p.getProfit()<p.getGoal()) {
    txt.set("Darn! You didn't earn enough to reach your goal, but don't lose hope! Practice makes perfect.");
  } else {    
    txt.set("Congratulations! You are now level "+p.getLevel()+"! Keep up the good work!");
  }
  if (mouseClicked) {
    if (mouseX >= displayWidth-350 && mouseY <= 100) { ////if player clicked on continu button
      state = "mainScreen";
      p.resetProfit();
      updateStats();
    }
    mouseClicked = false;
  }
}

void mouseReleased() {
  mouseClicked = true;
  ///////////IF PERSON CLICKS THE MAIN SCREEN BUTTON.......
  if (mouseX >= displayWidth-200 && mouseX <= displayWidth &&
    mouseY >= 50 && mouseY <= 100) {
    //username = null;
    //id = 0;
    if (state.equals("play") || state.equals("seatCustomers")) {
      state = "confirmMainScreen";
    } else {
      customers = new ArrayList<Party>();
      f = new ArrayList<Clickable>();
      updateStats();
      state = "mainScreen";
    }
    return;
  }
  for (int i = 0; i < items.size (); i++) {
    if (items.get(i).over()) {
      items.get(i).click();
      current = items.get(i);
    }
  }
  for (int i = 0; i < customers.size (); i++) {
    if (customers.get(i).over()) {
      customers.get(i).click();
      current = customers.get(i);
    }
  }
  for (int i = 0; i < f.size (); i++) {
    if (f.get(i).over()) {
      f.get(i).click();
      current = f.get(i);
    }
  }
}

