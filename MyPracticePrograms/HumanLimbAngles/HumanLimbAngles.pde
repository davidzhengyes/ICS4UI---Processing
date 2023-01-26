import g4p_controls.*;
Human bob = new Human("bob");
boolean leftMousePressed;
boolean jointSelected=false;
Joint testJoint=new Joint ("test",200,200);
boolean anyLimbClicked=false;

float oldMouseAngle=0;
PVector jointAndOldMouse;

int clickedJointIndex=0;

PVector lastFrameMouse;
PImage img;
void setup(){
  createGUI();
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
  

  background(0);
  
  
 
  
  bob.update();
  bob.updateJoints();
  bob.display();
  
  jointAndOldMouse=PVector.sub(new PVector(mouseX,mouseY),bob.allJoints.get(clickedJointIndex).coords);
  oldMouseAngle=PVector.angleBetween(new PVector(1,0),jointAndOldMouse);
 
  stroke(255);
  strokeWeight(5);
  line(0,500,600,500);
  line(0,505,600,505);
  //old mouse angle subtraction!
  
  
  
}
