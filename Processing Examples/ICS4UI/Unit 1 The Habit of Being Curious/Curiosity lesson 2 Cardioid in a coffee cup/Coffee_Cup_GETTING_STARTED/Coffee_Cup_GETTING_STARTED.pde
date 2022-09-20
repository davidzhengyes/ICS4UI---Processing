float theta = PI/2;
int numRays = 100;
float dTheta = PI/numRays;
float r;
float xC, yC;
boolean showJustCurrentBeam = true;


void setup(){
  size(1000, 600);
  frameRate(15); //MAKES draw() REPEAT ONLY 5 TIMES PER SECOND INSTEAD OF 30

  background(0);
  float yMid = height/2;
  
  xC = 400 + yMid; 
  yC = yMid;
  r = yMid * 0.95;
}


void draw() {
  float x1, y1;
  int brightness, weight;
  
  //1ST POINT OF IMPACT
  x1 = xC + r*cos( theta );
  y1 = yC - r*sin( theta );
  
  //2ND POINT OF IMPACT
  

  if ( showJustCurrentBeam ) {
    ////DRAWS THE RED BISECTING LINE
    //background(0);
    //stroke(190, 0, 0);
    //line(xC, yC, x1, y1);
    
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
  
  
  //IF THE INCOMING RAY HAS REACHED THE BOTTOM EDGE OF THE DISH, THEN STOP...
  if( theta < -PI/2 ) 
    noLoop();
 
  //...OTHERWISE, DECREASE THE ANGLE BEFORE THE NEXT FRAME BEGINS
  else 
    theta = theta - dTheta;
    
}
