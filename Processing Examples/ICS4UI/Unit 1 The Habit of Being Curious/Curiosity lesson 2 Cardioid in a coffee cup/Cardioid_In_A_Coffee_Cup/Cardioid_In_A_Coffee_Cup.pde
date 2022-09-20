float alpha = PI/2;
int numRays = 200;
float dalpha = PI/numRays;
float r;
float xC, yC;
boolean showJustCurrentBeam = false;


void setup(){
  size(1000, 600);
  frameRate(10); //MAKES draw() REPEAT ONLY 5 TIMES PER SECOND INSTEAD OF 30

  background(0);
  float yMid = height/2;
  
  xC = 400 + yMid; 
  yC = yMid;
  r = yMid * 0.95;
}


void draw() {
  float x1, y1, x2, y2, theta;
  int brightness, weight;
  
  //1ST POINT OF IMPACT
  x1 = xC + r*cos( alpha );
  y1 = yC - r*sin( alpha );
  
  //2ND POINT OF IMPACT
  theta = 3*alpha + radians(180);
  x2 = xC + r*cos( theta );
  y2 = yC - r*sin( theta );

  if ( showJustCurrentBeam ) {
    //DRAWS THE RED BISECTING LINE
    background(0);
    stroke(255, 0, 0);
    weight = 2;
    line(xC, yC, x1, y1);
    
    //DRAWS THE CENTRE DOT
    noFill();
    stroke(255,0,0);
    circle(xC, yC, 5);
  }
  
  //DRAWS THE DISH
  noFill();
  stroke(0, 255, 0);
  circle(xC, yC, 2*r);
    
  //DRAWS THE INCOMING RAY
  if ( showJustCurrentBeam ) { //BRIGHTER IF WE'RE DRAWING JUST 1 BEAM
    brightness = 255;
    weight = 2;
  }
  
  else { //DIMMER IF WE'RE DRAWING ALL THE BEAMS CUMULATIVELY
    brightness = 125;
    weight = 1;    
  }
  
  stroke( brightness, brightness, 0); //SOME SHADE OF YELLOW
  strokeWeight( weight );
  line(0, y1, x1, y1);
  
  //DRAWS THE REFLECTED RAY
  stroke(255,255,0);
  strokeWeight(1);
  line(x1, y1, x2, y2);
  
  //IF THE INCOMING RAY HAS REACHED THE BOTTOM EDGE OF THE DISH, THEN STOP...
  if( alpha < -PI/2 ) 
    noLoop();
 
  //...OTHERWISE, DECREASE THE ANGLE BEFORE THE NEXT FRAME BEGINS
  else 
    alpha = alpha - dalpha;
    
  //saveFrame("cardioid-######.png");
}
