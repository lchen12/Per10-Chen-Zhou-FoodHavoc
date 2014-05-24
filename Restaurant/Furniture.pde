class Furniture{
  
  PImage img;
  int price;
  
  Furniture(int price, String jpg, int w, int h){
    this.price = price;
    img = loadImage(jpg);
    img.resize(w,h);
    image(img,mouseX,mouseY);
  }
  
  int getPrice(){
    return price;
  }
  
  void size(int w, int h){
    img.resize(w,h);
  }
  
  void setPrice(int x){
    price = x;
  }
  
      
}
