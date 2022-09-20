import g4p_controls.*;

float xMin, xMax, yMin, yMax;
float mx, my, bx, by;
float a, b;
int numRays = 600;
int maxNumRays = 1000;
float raySpeed;
float xBulb = 0, yBulb = 0;
String drawingMode = "particles"; //"particles"

Bulb bulb;
QuadraticCurve e;

void setup(){
  size(600,600);
  createGUI();
  
  xMin = -width/2;  xMax = width/2;
  yMin = -height/2; yMax = height/2;
  
  mx = width/(xMax-xMin);
  bx = -mx*xMin;
  my = -height/(yMax-yMin);
  by = -my*yMax;
  
  a = width/2;  //default values
  b = a;
  //bSlider.setValue(75);
  numRays = 1000;
  raySpeed = 2.0;

  stroke(255);

  e = new QuadraticCurve(a, b);  
  bulb = new Bulb(a/2, 0, raySpeed, numRays);
}


void draw() {
  background(0);
  stroke(255);
  noFill();
  e.drawMe();
  
  bulb.drawObjects();
  bulb.updateObjects();
}


void mouseClicked() {
  xBulb = mouseX - width/2;
  yBulb = height/2 - mouseY;
  
  if (e.eval(xBulb, yBulb) < 0) 
    bulb = new Bulb( xBulb, yBulb, raySpeed, numRays);
}


void resetParameters() {
  a = float(aSlider.getValueI())/100.0 * xMax; 
  b = float(bSlider.getValueI())/100.0 * yMax; 
  raySpeed = float(speedSlider.getValueI())/2.0;
  numRays = min( int(numRaysTextfield.getText()), maxNumRays );
  String bulbPlacement = bulbPlacementList.getSelectedText();
  
  e = new QuadraticCurve(a, b); 

  if (bulbPlacement.equals("Center")) {
    xBulb = 0; 
    yBulb = 0;
  }
  
  else if (bulbPlacement.equals("Focus")) {
    xBulb = e.f1x; 
    yBulb = e.f1y;
  }
  
  else if (bulbPlacement.equals("Left edge")) {
    xBulb = -a*0.99; 
    yBulb = 0;
  }
  
  else if (bulbPlacement.equals("Top edge")) {
    xBulb = 0; 
    yBulb = b*0.99;
  }
  
  else if (bulbPlacement.equals("1/4 between foci")) {
    if (a >= b) {
      xBulb = e.f1x * 0.25 + e.f2x * 0.75;
      yBulb = 0;
    }
    
    else {
      xBulb = 0; 
      yBulb = e.f1y * 0.25 + e.f2y * 0.75;
    }
  }

  bulb = new Bulb( xBulb, yBulb, raySpeed, numRays );
}


float getAngle(float vx, float vy, float wx, float wy){
  float dotProd = vx*wx + vy*wy;
  float vMag = sqrt(vx*vx + vy*vy);
  float wMag = sqrt(wx*wx + wy*wy);
  return acos(dotProd/(vMag*wMag));
}


float getScreenX(float xMath) {
  return xMath + bx;
}


float getScreenY(float yMath) {
  return by - yMath;
}
