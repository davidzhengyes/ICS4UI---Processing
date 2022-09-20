class Pin{
  PVector location = new PVector();
  int size;
  int headSize;
  color headColour;
  boolean followMouse;
  int xDirection;
  int yDirection;
  
  Pin(float pX, float pY, int s, int hS, color c, int xD, int yD){
    this.location.x = pX;
    this.location.y = pY;
    this.size = s;
    this.headSize = hS;
    this.headColour = c;
    this.followMouse = false;
    this.xDirection = xD;
    this.yDirection = yD;
  }
 
  Pin(){
    this.size = round(random(minPinSize, maxPinSize));
    this.location.x = random(this.size, width - this.size);
    this.location.y = random(this.size, height - this.size);
    this.headSize = round(random(minPinHeadSize, maxPinHeadSize));
    int colorNum = round(random(0, balloonColors.length - 1));
    this.headColour = balloonColors[colorNum];
    this.followMouse = false;
    int[] directions = {-1, 1};
    this.xDirection = directions[round(random(0, 1))];
    this.yDirection = directions[round(random(0, 1))];
  }
  
  void updatePosition(){
    
    if(followMouse == true){
      this.location.x = mouseX;
      this.location.y = mouseY;
    }
  }
 
  Pin(int pX, int pY){
    this.size = round(random(minPinSize, maxPinSize));
    this.location.x = pX;
    this.location.y = pY;
    this.headSize = round(random(minPinHeadSize, maxPinHeadSize));
    int colorNum = round(random(0, balloonColors.length - 1));
    this.headColour = balloonColors[colorNum];
    this.followMouse = false;
    int[] directions = {-1, 1};
    this.xDirection = directions[round(random(0, 1))];
    this.yDirection = directions[round(random(0, 1))];
  }
 
  void drawPin(){
    stroke(128);
    strokeWeight(2);
    ellipseMode(CENTER);
    line(this.location.x - this.size * this.xDirection, this.location.y - this.size * this.yDirection, this.location.x + this.size * this.xDirection, this.location.y + this.size * this.yDirection);
    fill(this.headColour);
    noStroke();
    ellipse(this.location.x + this.size * this.xDirection, this.location.y + this.size * this.yDirection, this.headSize, this.headSize);
  }
 
  void popBalloons(){
    
    for(int i = 0; i < balloons.size(); i++){
      
      if(sqrt(pow(this.location.x - this.size * this.xDirection - balloons.get(i).position.x, 2) + pow(this.location.y - this.size * this.yDirection - balloons.get(i).position.y, 2)) <= balloons.get(i).radius + 2){
        balloons.get(i).pop(i);
      }
    }
  }
 
 
}
