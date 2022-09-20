//Left click to spawn more stationary pins
//Press any key on the keyboard to pop all of the balloons currently on screen (you need to click on the game screen before it works)
//For a more game-like (though less realistic) version, try changing balloonGravity to false

boolean balloonGravity = true;             //If this is true, balloons will have gravity applied to them
boolean fragGravity = true;                //If this is true, the balloon fragments will have gravity applied to them
boolean balloonRandomSpawn = true;         //If this is true, more balloons will spawn in over time
float fragGravityAmount = 0.5;             //This number is the acceleration of gravity on the balloon fragments - the higher, the stronger gravity is
float balloonGravityAmount = 0.1;          //This number is the acceleration of gravity on the balloons - the higher, the stronger gravity is
int balloonSpawnFrames = 30;               //The frequency at which new balloons spawn - the lower, the faster new balloons spawn in
int numRandomlyGeneratedBalloons = 5;      //The number of balloons that are randomly generated at the beginning of the program
int rateOfFrames = 30;                     //The frame rate
int minBalloonSpeed = 1;                   //The minimum speed balloons can travel at in a direction - the higher, the faster
int maxBalloonSpeed = 4;                   //The maximum speed balloons can travel at in a direction - the higher, the faster
int minBalloonRadius = 20;                 //The minimum radius a balloon can have
int maxBalloonRadius = 50;                 //The maximum radius a balloon can have
int minStringSize = 70;                    //The minimum size a string can be
int maxStringSize = 150;                   //The maximum size a string can be
int minStringTurns = 1;                    //The minimum amount of curves a string can have (0 will cause there to be no string)
int maxStringTurns = 3;                    //The maximum amount of curves a string can have
int minStringTurnWidth = 1;                //The minimum width a string's curve is
int maxStringTurnWidth = 20;               //The maximum width a string's curve is
int minPinSize = 5;                        //The minimum length a pin can be
int maxPinSize = 15;                       //The maximum length a pin can be
int minPinHeadSize = 3;                    //The minimum radius the head of a pin can be
int maxPinHeadSize = 10;                   //The maximum radius the head of a pin can be
int maxFragmentVelocities = 6;             //The maximum initial velocity a balloon fragment can have
int minFragmentRadius = 1;                 //The minimum radius a balloon fragment can have
float fragmentSizeDivisor = 2;             //Balloon fragments spawn in with a maximum radius proportional to the original ballons's radius at a factor of this
float balloonBounceModifier = 0.88;        //If balloonGravity is true, then this modifier is applied to the velocity every time a balloon bounces

int balloonFrames;
ArrayList<Balloon> balloons;
ArrayList<Pin> pins;
ArrayList<PoppedBalloonFragment> fragments;
color[] balloonColors = {color(255, 255, 0), color(255, 0, 255), color(0, 255, 255), color(0, 0, 255), color(0, 255, 0), color(255, 0, 0)};

void setup(){
  size(800, 800);
  frameRate(30);
  balloonFrames = 0;
  balloons = new ArrayList<Balloon>();
  pins = new ArrayList<Pin>();
  fragments = new ArrayList<PoppedBalloonFragment>();
 
  Balloon b1 = new Balloon(400, 200, -2, -3, 50, color(255, 0, 0));
  b1.changeColor(color(255, 255, 0));
  BalloonString s1 = new BalloonString(75, 1, 15);
  b1.addString(s1);
  balloons.add(b1);
 
  for(int i = 0; i < numRandomlyGeneratedBalloons; i++){
    spawnBalloon();    
  }
   
  Pin p1 = new Pin(0, 0, 10, 5, color(0, 255, 255), 1, 1);
  p1.followMouse = true;
  pins.add(p1);
  
  Pin p2 = new Pin();
  pins.add(p2);
}

void draw(){
  background(0);
  for(int i = balloons.size() - 1; i >= 0; i--){
    balloons.get(i).updatePosition();
    balloons.get(i).drawBalloon();        
    
    if(balloons.get(i).hasString)
      balloons.get(i).string.drawString();
    
    if(balloons.get(i).position.x == -100 && balloons.get(i).position.y == -100){
      balloons.remove(i);
    }
    
    else{
      balloons.get(i).updatePosition();
      balloons.get(i).checkCollisions();
    }
  }
 
  for(int i = 0; i < pins.size(); i++){
    pins.get(i).updatePosition();
    pins.get(i).drawPin();
    pins.get(i).popBalloons();
  }

  for(int i = fragments.size() - 1; i >= 0; i--){
    fragments.get(i).drawFragment();
    fragments.get(i).updatePosition();
   
    if(fragments.get(i).isOffScreen() == true)
      fragments.remove(i);    
  }
  
  balloonFrames++;
  
  if(balloonRandomSpawn == true && balloonFrames > balloonSpawnFrames){
    spawnBalloon();
    balloonFrames = 0;
  }
}

void spawnBalloon(){
  Balloon b = new Balloon();    
  
  if(true){
    BalloonString s = new BalloonString();
    b.addString(s);
  }
  
  balloons.add(b);
}

void mousePressed(){
  Pin p = new Pin(mouseX, mouseY);
  pins.add(p);
}

void keyPressed(){
  for(int i = balloons.size() - 1; i >= 0; i--){
    balloons.get(i).pop(i);
  }
}
