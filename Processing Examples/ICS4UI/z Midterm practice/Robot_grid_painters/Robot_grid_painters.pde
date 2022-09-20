PImage img;
int n = 6;
int s = 70;
Robot dumbRobot, smartRobot, currentRobot;

void setup() {
  size(500,500);
  img = loadImage("turtle.png");
  img.resize(40,60);
  imageMode(CENTER);
  noLoop();
  frameRate(1);
  
  dumbRobot = new Robot(100,100,.05);
  smartRobot = new Robot(100,100,1);
  
  currentRobot = dumbRobot;
  
  dumbRobot.forward(100);
  
  //paintGridDumbly();
  //paintGridSmartly();
}

void paintGridDumbly(){
  for(int row=0; row < n; row++)
      for(int col=0; col < n; col++) {
          for(int i=1; i <= 4; i++) {
            dumbRobot.forward( s );
            dumbRobot.turnRight();
          }
          
          dumbRobot.forward( s );

      }

}

void draw() { 
  println("aaaaaa");
  fill(255,0,0);
  circle(currentRobot.x, currentRobot.y, 20);
}
