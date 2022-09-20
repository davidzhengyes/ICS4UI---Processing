float ringSpeed = 3.0;
float numFramesBetweenRingReleases = 1.5;
String ringShape = "circle"; //"square", "circle"
String sourceMotionMode = "linear"; //"linear", "circular", "wave", "backandforth", "mouse"

//Linear mode parameters
float xStartFraction = 0.05;
float xSpeed = 0; //1.2*ringSpeed;
float ySpeed = 0;
float xAcceleration = 0.08;

//Circular, wave or backandforth parameters
float frequency = 0.15;
float amplitude = 60;
float horizontalWaveSpeed = 1.6*ringSpeed;
float xCentre, yCentre;

//Don't change these
Ring[] rings;
int n = 500;
float maxRingSize, xPos, yPos;
int currIndex = 0;
float realTime = 0.0;
float timeSinceLastRingRelease = 0.0;


void setup() {
  size(1400, 1000);
  rings = new Ring[n];
  xPos = width * xStartFraction;
  yPos = height/2;
  xCentre = width/2;
  yCentre = height/2;
  frameRate(30);
  maxRingSize = width; //sqrt(2)/2
}


void draw() {
  background(0, 0, 255);

  drawSource();
  drawRings();

  if ( timeSinceLastRingRelease > numFramesBetweenRingReleases ) 
    releaseNewRing();

  realTime++;
  timeSinceLastRingRelease++;

  updateSourcePosition();
}


void releaseNewRing() {
  if (currIndex < n) {
    rings[currIndex] = new Ring(xPos, yPos, 0, ringSpeed);
    timeSinceLastRingRelease = 0.0;
    currIndex = (currIndex + 1) % n;
  }
}


void drawSource() {
  fill(255, 0, 0);
  noStroke();
  circle(xPos, yPos, 10);
}


void drawRings() {
  noFill();
  stroke(255, 200, 0);
  
  if(ringShape == "circle") {
    for (int i=0; i < currIndex; i++)
      if (rings[i].radius < maxRingSize) {
        rings[i].drawCircular();
        rings[i].grow();
      }
  }
  
  else if(ringShape == "square") {
    for (int i=0; i < currIndex; i++)
      if (rings[i].radius < maxRingSize) {
        rings[i].drawSquare();
        rings[i].grow();
      }
  }
}


void updateSourcePosition() {
  if ( sourceMotionMode == "linear" ) {
    xPos += xSpeed;
    yPos += ySpeed;
    xSpeed += xAcceleration;
  } 
  
  else if( sourceMotionMode != "mouse" ) {
    float theta = realTime * frequency;

    if ( sourceMotionMode == "circular" ) {
      xPos = xCentre + amplitude*cos(theta);
      yPos = yCentre - amplitude*sin(theta);
    } 
    
    else if ( sourceMotionMode == "backandforth" ) {
      xPos = xCentre + amplitude*cos(theta);
    } 
    
    else if ( sourceMotionMode == "wave" ) {
      xSpeed = horizontalWaveSpeed;
      xPos += xSpeed;
      yPos = yCentre - amplitude*sin(theta);
    }
  }
  
  else {
    //mouse mode updates with mouse motion, not with the frame count
  }
}


void clearRings() {
  currIndex = 0;
  rings = new Ring[n];
}


void mouseMoved() {
  if (sourceMotionMode == "mouse") {
    xPos = mouseX; 
    yPos = mouseY;
  }
}


void mouseClicked()
{
  clearRings();
  xPos = mouseX;
  yPos = mouseY;
  xCentre = mouseX;
  yCentre = mouseY;
  xSpeed = 0;
  ySpeed = 0;
}
