//PARAMETERS
int numKids = 10;
float minChainLength = 100;
float maxAngle = 70; //degrees
float delayBetweenReleases = 0.15;
boolean drawChains = true;

float timeBetweenFrames = .03;
float heightOfBar = 0.05; //max 1.0
color ballColour = color(255, 255, 0);
float kidSizeFactor = 1;


//CALCULATED VALUES
float xC; 
float yC;
float[] r;
float[] releaseTime;
float KidSize;
float maxDeflection = radians(maxAngle);
float time = 0.0;

//MAIN PROGRAM - GETS RUN ONCE WHEN THE PROGRAM STARTS
void setup(){
  background(0);
  size(1200,1000);
  
  xC = width/2;
  yC = heightOfBar*height;
  float availableWidth = min(xC, height-yC);
  KidSize = kidSizeFactor * (availableWidth - minChainLength)/numKids;
  r = new float[numKids];
  releaseTime = new float[numKids];
  
  //SET RELEASE TIMES
  for(int i = 0; i<numKids; i++){
    r[i] = minChainLength + i*KidSize;
    releaseTime[i] = i * delayBetweenReleases;
  }
}

//GETS CALLED REPEATEDLY (ABOUT 30 TIMES/SEC) AS SOON AS setup() 
//HAS FINISHED RUNNING
void draw() {
  background(0); //RESETS THE BACKGROUND COLOR EACH FRAME
  
  //LOOPS THROUGH EACH KID AND CALCULATES HER/HIS ANGLE AND (X,Y) POSITION
  for( int i = 0; i < numKids; i++ ){
    float theta = 3*PI/2 + maxDeflection*sin(time-releaseTime[i]);
    float xKid = xC + r[i]*cos(theta); 
    float yKid = yC - r[i]*sin(theta); 
    
    if (drawChains == true) { //DRAWS THE SWING'S CHAIN, IF DESIRED
      stroke(200);
      line(xC, yC, xKid, yKid);
    }
    
    noStroke();
    fill( ballColour );
    ellipse( xKid, yKid, KidSize, KidSize ); //DRAWS ONE BALL IN ITS CURRENT POSITION
  }
    
  time = time + timeBetweenFrames;
}
