import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;

//use queue for steps

Hashtable<String, String> users;
MyLinkedList<Clickable> f;
TextBox t;
Player p;
String state, input, entry, username;
boolean entered;

void setup() {
  size(displayWidth, displayHeight);
  background(255);
  f = new MyLinkedList<Clickable>();
  t = new TextBox("FOOD HAVOC");
  //String[] fontList = PFont.list();
  //println(fontList);
  state = "welcome";
  input = "";
  users = new Hashtable<String, String>();
  users.put("bob","joe");
  entered = false;
  username = "";
}

void addUserToFile(String p){
  File f = new File("users.txt");
  try{
    PrintWriter printer = new PrintWriter(f);
    printer.write(username+","+p);
    System.out.println("scuess");
  }catch (FileNotFoundException e){
    e.printStackTrace();
  }
}

void draw() {
  background(255);
  t.display();
  Iterator<Clickable> itr = f.iterator();
  while (itr.hasNext()){
    Clickable c = itr.next();
    c.display();
  }
  if (state.equals("welcome")){
    t.set("Welcome to FOOD HAVOC! Do you have an account? Type (y) or (n)");
    ///////////////HOW TO WAIT FOR USER??//////////////
    if (key == 'y' || key == 'Y'){
      input = "";
      state = "confirmUsername";
    }else if (key == 'n' || key == 'N'){
      state = "makeUsername";
    }
  }else if (state.equals("error")){
    t.set("Error. Please restart and try again.");
  }else if (state.equals("confirmUsername")){
    confirmUsername();
  }else if (state.equals("makeUsername")){
    makeUsername();
  }else if (state.equals("confirmPassword")){
    confirmPassword();
  }else if (state.equals("makePassword")){
    makePassword();
  }else if (state.equals("play")){
    t.set("Play!");
  }
}

void addUser(String u, String p){
  users.put(u, p);
}

void confirmUsername(){
  t.set("Please type your Username and then press Enter: "+input);
  if (entered){
    if (checkUsername(entry)){    
      state = "confirmPassword";
    }
  }
}

boolean checkUsername(String u){
  System.out.println(users.containsKey("bob"));
  if (users.containsKey(u)){
    username = u;
    entered = false;
    return true;
  }
  entered = false;
  return false;
}      
      
void confirmPassword(){
  t.set("Please type your Password and then press Enter.");
  if (entered){
    checkPassword(entry);
  }
}

void checkPassword(String p){
  if (users.get(username).equals(p)){
    state = "play";
  }else{
    state = "error";
  }
  entered = false;
}
      
void makeUsername(){
  t.set("To make an account, please type a new Username and then press Enter: "+input);
  if (entered){
    if (checkUsername(entry)){
      state = "error";
    }else{
      username = entry;
      state = "makePassword";
    }
  }
  entered = false;
}

void makePassword(){
  t.set("Please enter a new Password and then press Enter.");
  if (entered){
    users.put(username, entry);
    entered = false;
    state = "play";
    addUserToFile(entry);
  }
}

void keyPressed(){
  if ((int)key==10){
    clearInput();
  }else if ((int)key==8 /*|| (int)key==65535*/){
    if (input.length()>0){
      input = input.substring(0,input.length()-1);
    }
  }else{
    if (key!='?'){
    input += key;
    System.out.println((int)key + " " +key + ", "+ input);
    }
  }
}

void clearInput(){
  entry = input;
  input = "";
  entered = true;
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
