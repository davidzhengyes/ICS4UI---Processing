class Egg{
  color colour;
  PVector Location = new PVector();
  int size;
  boolean picked;
  
  Egg (int s, color c){
    this.size = s;
    this.colour = c;
    this.picked = true;
  }
  
  void drawEgg(){
    if (picked==false){
      fill(colour);
      ellipse(this.Location.x, this.Location.y, this.size, 1.5*this.size);
    }    
  }
  
  void infoEgg(int rangeX1, int rangeX2, int rangeY1, int rangeY2){
    this.Location.x = round(random(rangeX1, rangeX2));
    this.Location.y = round(random(rangeY1, rangeY2));
    this.picked = false;
  }
}
