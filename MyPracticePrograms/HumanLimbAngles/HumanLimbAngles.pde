Human bob = new Human("bob");
boolean leftMousePressed;
boolean jointSelected=false;
PImage img;
void setup(){
  size(600,600);
  background(0);
  stroke(255);
  strokeWeight(5);
  line(0,500,600,500);
  line(0,505,600,505);
  
  img = loadImage ("circle.jpg");
}






void draw(){
  pushMatrix();
  //rotate(PI/3);
  //image(img,0,100,900,520);
  popMatrix();
  //updatePosFromAngles();  
  bob.display();
  
}
