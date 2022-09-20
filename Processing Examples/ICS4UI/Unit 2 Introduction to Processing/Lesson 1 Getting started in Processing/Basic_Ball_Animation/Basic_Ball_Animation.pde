//GLOBAL VARIABLES
float xBall, yBall;

//MAIN PROGRAM
void setup(){
  size(800,600);
  xBall = 0;
  yBall = height/4;   //Here, height is automatically 
                      //set to 600/2 and width to 800/2
}

//DRAW() GETS CALLED ~30 TIMES PER SECOND AFTER SETUP() FINISHES 
void draw(){
  background(0,255,0);
  
  fill(0,0,255);
  stroke(255,255,0);
  
  rect(xBall, yBall, 40, 40);
  xBall = xBall + 5;
  yBall = yBall -1.5;
}



//OTHER THINGS TO TRY
  //xBall = xBall + (width-xBall)*0.02;
  //xBall += (mouseX-xBall)*0.2;
  //yBall += (mouseY-yBall)*0.2;
