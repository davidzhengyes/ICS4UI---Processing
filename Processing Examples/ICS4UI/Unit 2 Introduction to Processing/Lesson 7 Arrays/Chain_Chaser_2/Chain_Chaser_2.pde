//PARAMETERS. TRY CHANGING THESE
int n = 50;
float ballSize = 20;
float k = 0.15; //the "stickiness" of the chain
String leaderFollows = "mouse"; //"mouse", "spiral", "end", "wave", "line"

//DON'T CHANGE THESE
float[] xPos = new float[n];
float[] yPos = new float[n];

float xC, yC;
float time = 0.0;
int t = 0;
float r = 275;
float xLineSpeed = 12;
float yLineSpeed = 7;
float xCurrSpeed = xLineSpeed;
float yCurrSpeed = -yLineSpeed;


void setup(){
  size(1200,600);

  xC = width/2;
  yC = height/2;
  
  //starts all balls at the middle of the screen
  for(int i = 0; i < n; i++){
    xPos[i] = width/2;
    yPos[i] = height/2;
  }
}

void draw() {
  background(0);
  fill(255);
  
  //draws the balls in their current positions
  for( int i = 0; i < n; i++ ){
    circle( xPos[i], yPos[i], ballSize );
    fill(255, 0, 0);
  }
  
  //the leader chases the last ball in the line
  if( leaderFollows.equals("end") ) {
    xPos[0] += (xPos[n-1] - xPos[0]) * k;
    yPos[0] += (yPos[n-1] - yPos[0]) * k;
  }
  
  //the leader traces a sine wave. For best results, set n to over 100 and shrink the ball size
  else if( leaderFollows.equals("wave") ) {
    xPos[0] = 1.2*t;
    yPos[0] = yC - r*sin(.04*t);
    t++;
  }
  
  //the leader traces a spiral. For best results, set n to over 100 and shrink the ball size
  else if( leaderFollows.equals("spiral") ) {
    xPos[0] = xC + r*cos(time);
    yPos[0] = yC - r*sin(time);
    time += .05;
    r += .1;
  }
  
  //the leader bounces around the room
  else if( leaderFollows.equals("line") ) {
    xPos[0] += xCurrSpeed;
    yPos[0] += yCurrSpeed;
    
    if (xPos[0] >= width){
      xCurrSpeed = -xLineSpeed;
    }
    if (xPos[0] <= 0){
      xCurrSpeed = xLineSpeed;
    }
    if (yPos[0] >= height){
      yCurrSpeed = -yLineSpeed;
    }
    if (yPos[0] <= 0){
      yCurrSpeed = yLineSpeed;
    }
  }

  //the leader chases the mouse
  else{
    xPos[0] += (mouseX - xPos[0]) * k;
    yPos[0] += (mouseY - yPos[0]) * k;
  }
  
  //makes each non-leader ball chase the ball ahead of it
  for( int i = 1; i < n; i++ ){
    xPos[i] += ( xPos[i-1] - xPos[i]) * k;
    yPos[i] += ( yPos[i-1] - yPos[i]) * k;
  }
}


//IF THE USER CLICKS THE MOUSE, THE LEADER WILL START TO CHASE THE END BALL
void mouseClicked(){
  leaderFollows = "end";
}
