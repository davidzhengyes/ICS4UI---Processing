int maximumLevel = 12;
float deltaPhi = PI/8;
float branchDecayFactor = 0.82; // 1.0 --> no shrinking at all, 0.99 means shrink by 1% each gen.
float startingLength = 120;
int currLevel;
boolean animateAllStages = true;
int animationSpeed = 3;

void setup() {
    background(255);
    size(1200,600);
    strokeWeight(4);
    
    if( !animateAllStages )
      noLoop();
      
    else
      frameRate(animationSpeed);
}


void draw() {
  if (animateAllStages) {
    if( currLevel <= maximumLevel) {
        drawFibTree(currLevel, width/2, height-20, PI/2, deltaPhi, startingLength, 0);  
        currLevel++;
    }
  }
  
  else {
    drawFibTree(maximumLevel, width/2, height/2, 0, deltaPhi, startingLength, 0); 
    drawFibTree(maximumLevel, width/2, height/2, PI/2, deltaPhi, startingLength, 0);  
    drawFibTree(maximumLevel, width/2, height/2, PI, deltaPhi, startingLength, 0); 
    drawFibTree(maximumLevel, width/2, height/2, 3*PI/2, deltaPhi, startingLength, 0);  
  }
}


void drawFibTree(int n, float x1, float y1, float phi, float deltaPhi, float L, int age) {
   //BASE CASE
   float x2 = x1 + L*cos(phi);
   float y2 = y1 - L*sin(phi);
   setColour(age);
   line(x1, y1, x2, y2);
   
   if (n > 1) {  //RECURSIVE CASE
     L *= branchDecayFactor;
     
     if( age == 0 ) //We've just drawn a baby branch, now spawn a single kid branch at same angle
       drawFibTree(n-1, x2, y2, phi, deltaPhi, L, 1);
       
     else { //We've just drawn a kid or adult branch, now spawn a new baby + new adult
       drawFibTree(n-1, x2, y2, phi+deltaPhi, deltaPhi, L, 0);
       drawFibTree(n-1, x2, y2, phi-deltaPhi, deltaPhi, L, 2);
     }
   }
}


void setColour(int age) {
  if(age==0)
    stroke(0,255,0);
    
  else if(age==1)
    stroke(0,0,255);
    
  else
    stroke(255,0,255);
}
