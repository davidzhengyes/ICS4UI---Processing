//USER SETTINGS - TRY CHANGING THESE

boolean showSin = true;
boolean showCos = true;
boolean showTan = true;
boolean showSec = true;
boolean showCot = false;
boolean showCsc = false;

color sinCol = color(255, 0, 0);
color cosCol = color(0, 255, 0);
color tanCol = color(255, 255, 0);
color secCol = color(255, 0, 255);
color cscCol = color(255, 150, 0);
color cotCol = color(0, 255, 255);
color radiusCol = color(255);
color circleCol = color(255);

float speed = 0.01;

int dotSize = 15;
int r, d;
float xC, yC, xDot, yDot, yTan, yCsc;
float midSinY, midCosX, midTanY, midSecX, midSecY, midCotX, midCotY, midCscY;

float xOne, yOne, xOneText, xOneHalf, yCText, xCText;
PFont myFont;

String thetaSymbol = "\u03b8";
String sinTheta = "sin " + thetaSymbol;
String cosTheta = "cos " + thetaSymbol;
String tanTheta = "tan " + thetaSymbol;
String secTheta = "sec " + thetaSymbol;
String cscTheta = "csc " + thetaSymbol;
String cotTheta = "cot " + thetaSymbol;

float theta = PI/3;


void setup() {
  size(800, 800);
  noLoop();  //Press 'r' to start the animation
 
  fill(255);
  myFont = createFont("Arial", 24);
  textFont(myFont);
 
  d = width/2;
  r = d/2;
  xC = width/2;
  yC = height/2;
  xOne = xC + r;
  yOne = yC - r;
  xOneText = 1.01*xOne;
  yCText = 0.99 *yC;
  xOneHalf = (xC + xOne)/2;
  xCText = 1.01*xC;
}

void draw() {
  background(0);
 
  fill(255,140,0);
  text("Press r to run the animation. Press p to pause", 50, 50);
 
  xDot = xC + r*cos(theta);
  yDot = yC - r*sin(theta);
 
  //CIRCLE & AXES
  noFill();
  stroke(255);
  strokeWeight(2);
  circle(xC, yC, d);
  line(0, yC, width, yC);
  line(xC, 0, xC, height);
 
  //RADIUS
  stroke(radiusCol);
  line(xC, yC, xDot, yDot);
 
  strokeWeight(4);
 
  //SINE
  if( showSin ) {
    stroke(sinCol);
    fill(sinCol);
    line(xDot, yC, xDot, yDot);
    midSinY = (yC + yDot)/2;
    textAlign(LEFT);
    text(sinTheta, 1.01*xDot, midSinY);
  }
 
  //COSINE
  if( showCos ) {
    stroke(cosCol);
    fill(cosCol);
    line(xC, yC, xDot, yC);
    midCosX = (xC + xDot)/2;
    textAlign(CENTER);
    text(cosTheta, midCosX, yCText);
  }
 
  //TANGENT
  if( showTan ) {
    stroke(tanCol);
    fill(tanCol);
    yTan = yC - r*tan(theta);
    line(xC, yC, xOne, yTan );
    line(xOne, yC, xOne, yTan );
    midTanY = (yC + yTan)/2;
    textAlign(LEFT);
    text(tanTheta, xOneText, midTanY);
  }
 
  //SECANT
  if( showSec ) {
    stroke(secCol);
    fill(secCol);
    line(xC, yC, xOne, yTan );
    textAlign(LEFT, CENTER);
    text(secTheta, xOneHalf, midTanY);
  }

  //COSECANT
  if( showCsc ) {
    stroke(cscCol);
    fill(cscCol);
    yCsc = yC - r/sin(theta);
    line(xC, yC, xC, yCsc );
    midCscY = (yC + yCsc)/2;
    textAlign(LEFT, CENTER);
    text(cscTheta, xCText, midCscY);
  }
 
  //COTANGENT
  if( showCot ) {
    stroke(cotCol);
    fill(cotCol);
    line(xDot, yDot, xC, yCsc );
    midCotX = 1.01*(xDot + xC)/2;
    midCotY = 0.99*(yDot + yCsc)/2;
    textAlign(LEFT, TOP);
    text(cotTheta, midCotX, midCotY);
  }
 
  //DOT
  fill(circleCol);
  noStroke();
  circle(xDot, yDot, dotSize);
 
  //UPDATES THE ANGLE
  theta = (theta + speed) % TWO_PI;
}
