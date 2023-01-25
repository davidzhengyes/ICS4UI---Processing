Human bob = new Human("bob");
boolean leftMousePressed;
boolean jointSelected=false;
Joint testJoint=new Joint ("test",200,200);
boolean anyLimbClicked=false;
float oldAngle=0;
float oldMouseAngle=0;
PVector jointAndOldMouse;

PVector lastFrameMouse;
PImage img;
void setup(){
  size(600,600);
  background(0);
  stroke(255);
  strokeWeight(5);
  line(0,500,600,500);
  line(0,505,600,505);
  //frameRate(1);
  img = loadImage ("circle.jpg");
  println(bob.leftHip);
  bob.leftFemur.superiorJoint=bob.leftHip;
}






void draw(){
  
  
  pushMatrix();
  //rotate(PI/3);
  //image(img,0,100,900,520);
  popMatrix();
  background(0);
  //updatePosFromAngles();  
  bob.update();
  bob.display();
  if (anyLimbClicked){
    lastFrameMouse=new PVector(mouseX,mouseY);
  }
  stroke(255);
  strokeWeight(5);
  line(0,500,600,500);
  line(0,505,600,505);
  //old mouse angle subtraction!
  jointAndOldMouse=PVector.sub(new PVector(mouseX,mouseY),bob.leftHip.coords);
  oldMouseAngle=PVector.angleBetween(new PVector(1,0),jointAndOldMouse);
  oldAngle=PVector.angleBetween(new PVector(1,0),PVector.sub(bob.leftFemur.bottomCoord,bob.leftHip.coords));
  
}
