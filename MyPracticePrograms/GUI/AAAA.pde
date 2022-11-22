float x = 0;
import g4p_controls.*;

float xSpeed = 4;  //user will eventually be able to set this using a slider bar
float r = 40;
color c = color(0, 120, 0);

void setup() {
  size(700, 300);
  createGUI();
}


void draw() {
  background(100);
  fill(c);
  circle( x, height/2, 2*r);
  x += xSpeed;
 
  if (x > width + r)
    x = -r;
  
}
