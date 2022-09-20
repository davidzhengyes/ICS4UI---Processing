float xF, yF, xE, yE;
float L = 150;
float theta = PI/2 *0.999;
float angSpeed = 0;
float g = .01;

void setup(){
  size(500,500);
  xF = width/2;
  yF = height *0.9;
}

void draw() {
  background(255);
  stroke(255,0,0);
  strokeWeight(2);
  line(0, yF, width, yF);
  
  drawDomino();
  updateDomino();
}


void drawDomino() {
  stroke(0);
  strokeWeight(10);
  xE = xF + L*cos(theta);
  yE = yF - L*sin(theta);
  line(xF, yF, xE, yE);
}


void updateDomino() {
  if(theta > 0) {
    theta = max(theta - angSpeed, 0);
    angSpeed = angSpeed + g*cos(theta);
  }
}
