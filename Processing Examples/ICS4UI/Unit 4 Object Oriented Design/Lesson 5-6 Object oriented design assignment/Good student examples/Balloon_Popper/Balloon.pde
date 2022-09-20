class Balloon{
  PVector position = new PVector();
  PVector velocity = new PVector();
  boolean hasString;
  int xSpeed;
  int radius;
  color colour;
  BalloonString string;
 
  Balloon(int pX, int pY, int vX, int vY, int rad, color c){
    this.position.x = pX;
    this.position.y = pY;
    this.velocity.x = vX;
    this.velocity.y = vY;
    this.hasString = false;
    this.radius = rad;
    this.colour = c;
  }
 
  Balloon(){
    int numTries = 0;
    this.hasString = false;
    this.radius = round(random(minBalloonRadius, maxBalloonRadius));
    int colorNum = round(random(0, balloonColors.length - 1));
    this.colour = balloonColors[colorNum];
   
    boolean posSelected = false;
    while(posSelected == false){
      numTries++;
      int x = round(random(0 + this.radius, width - this.radius));
      int y = round(random(0 + this.radius, height - this.radius));
     
      boolean squareOccupied = false;
      for(int i = 0; i < balloons.size(); i++){
       
        if(sqrt(pow(x - balloons.get(i).position.x, 2) + pow(y - balloons.get(i).position.y, 2)) < this.radius + balloons.get(i).radius)
          squareOccupied = true;
      }
     
      if(squareOccupied == false){
        posSelected = true;
        this.position.x = x;
        this.position.y = y;
       
        float xVelocity = random(minBalloonSpeed, maxBalloonSpeed);
        float yVelocity = random(minBalloonSpeed, maxBalloonSpeed);
        
        if(random(1) > 0.5)
          xVelocity = xVelocity * -1;
        
        if(random(1) > 0.5)
          yVelocity = yVelocity * -1;
        
        this.velocity.x = xVelocity;
        this.velocity.y = yVelocity;
      }
     
      else if(numTries >= 100){
        posSelected = true;
        this.position.x = -100;
        this.position.y = -100;
        this.velocity.x = 0;
        this.velocity.y = 0;
      }      
    }
  }
 
  void changeColor(color c){
    this.colour = c;
  }
 
  void checkCollisions(){
    if(this.position.x - this.radius <= 0)
      this.velocity.x = this.velocity.x * -1;
   
    if(this.position.x + this.radius >= width)
      this.velocity.x = this.velocity.x * -1;
   
    if(this.position.y - this.radius <= 0){
      this.velocity.y = this.velocity.y * -1;
      this.position.y = this.radius;
    }
   
    if(this.position.y + this.radius >= height){
      this.velocity.y = this.velocity.y * -1;
      this.position.y = height - this.radius;
      
      if(balloonGravity == true)
        this.velocity.y = this.velocity.y * balloonBounceModifier;
    }
    
  }
 
  void updatePosition(){
    this.position.x += this.velocity.x;
    this.position.y += this.velocity.y;
    
    if(balloonGravity == true)
      this.velocity.y += balloonGravityAmount;
  }
 
  void drawBalloon(){
    noStroke();
    ellipseMode(CORNERS);
    fill(this.colour);
    ellipse(this.position.x - this.radius, this.position.y - this.radius, this.position.x + this.radius, this.position.y + this.radius);
  }
 
  void addString(BalloonString s){
    this.hasString = true;
    this.string = s;
    this.string.balloon = this;
    
    if(round(random(0, 1)) == 1)
      s.widthTurns = s.widthTurns * -1;
  }
 
  void pop(int index){
    balloons.remove(index);
    for(int i = 0; i < this.radius / round(fragmentSizeDivisor); i++){
      PoppedBalloonFragment f1 = new PoppedBalloonFragment(this.position.x, this.position.y, this.radius, this.colour);
      fragments.add(f1);
    }
  }
}
