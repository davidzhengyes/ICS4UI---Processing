PVector[] wordLocations;
String msg = "ICS$UI";
PFont myFont;


void setup() {
  size(600,600);
  
  myFont = createFont("Times New Roman", 24);
}


void draw() {
  background(0);
  textFont(myFont);
  fill(mouseX,mouseY,0);
  
  for(int i=0; i< msg.length(); i++) {
    text( msg.substring(i, i+1), 300+i*20, 300+i*20);
  
  }
}
  
