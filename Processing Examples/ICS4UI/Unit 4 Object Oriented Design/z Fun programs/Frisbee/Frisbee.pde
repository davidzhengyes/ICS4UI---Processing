float R, r, W, w, t, XC, YC, D, deltaPhaseShift, deltaT, f, numRotations;
int n = 120;
float stickLength;
Stick[] sticks = new Stick[n];
color stickCol = color(255, 255, 0);
color circleCol = color(255, 120, 120);

void setup() {
  size(900,900);
  //strokeWeight(2);
  XC = width/2;
  YC = height/2;
  t = 0;
  float alpha = 0;
  float phaseShiftCurr = 0;
  R = 0.9*XC;
  D = 2*R;
  deltaT = 0.01;
  float deltaAlpha = 2*PI/n;
  
  stickLength = R * 0.1;
  deltaPhaseShift = deltaAlpha * 3;
  numRotations = 8;
  
  w = deltaT * numRotations;
  
  for(int i=0; i < n; i++ ) {
    float wCurr = w*pow(1, i); 
    sticks[i] = new Stick( alpha, wCurr, phaseShiftCurr );
    alpha += deltaAlpha;
    phaseShiftCurr += deltaPhaseShift;
  }
}


void draw() {
  background(0);
  noFill();
  stroke(255);
  //circle(XC, YC, D);
  
  stroke(stickCol);
  
  for(int i=0; i < n; i++ ) {
    sticks[i].drawMe();
    sticks[i].update();
  }
  
  t += deltaT;
}
