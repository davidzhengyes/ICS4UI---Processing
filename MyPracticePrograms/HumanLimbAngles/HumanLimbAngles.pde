Human bob = new Human("bob");
void setup(){
  size(600,600);
  background(0);
  stroke(255);
  strokeWeight(5);
  line(0,500,600,500);
  line(0,505,600,505);
  
  
}






void draw(){
  //updatePosFromAngles();  
  bob.display();
  
}
