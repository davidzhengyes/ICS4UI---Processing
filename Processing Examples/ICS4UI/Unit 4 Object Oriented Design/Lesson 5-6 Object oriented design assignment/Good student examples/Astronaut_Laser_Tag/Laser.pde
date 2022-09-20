class Laser {
  float xPos;
  float yPos;
  float speed;
  float xD;
  float yD;
  Astronaut o;
  PImage image;
  Spacestation myMap;
  
  //Constructor method.
  Laser(float x, float y, Astronaut opposing, Spacestation theMap) {
    this.xPos = x;
    this.yPos = y;
    this.xD = opposing.xPos;
    this.yD = opposing.yPos;
    this.o = opposing;
    this.myMap = theMap;
  }
  
  //Draws laser.
  void drawLaser() {
    image(image, this.xPos, this.yPos);
  }
  
  void update() {
    this.xPos += this.speed;
  }
  
  //Checks if it hits the target.
  boolean checkForHit() {
    if (this.xPos + 50 > this.xD + 20 && this.xPos + 70 < this.xD + 60 && this.yPos > this.yD && this.yPos < this.yD + 70 && this.image == laserForward) {
      return true;
    } 
    
    if (this.xPos > this.xD && this.xPos  < this.xD + 60 && this.yPos > this.yD && this.yPos < this.yD + 80 && this.image == laserBackward) {
      return true;
    } 
    
    else {
      return false;
    }
    
  }
  
  //Checks if it hits any platforms.
  boolean checkForObstacles() {
    int truthCounter = 0;
      for (int i = 0; i < this.myMap.entireMap.size(); i ++) {
        if (this.xPos + 30 > this.myMap.entireMap.get(i).xPos && this.xPos + 30 < this.myMap.entireMap.get(i).xPos + this.myMap.entireMap.get(i).l && this.yPos > this.myMap.entireMap.get(i).yPos && this.yPos < this.myMap.entireMap.get(i).yPos + this.myMap.entireMap.get(i).h) {
          truthCounter ++;
        }
      }   
      
      if (truthCounter > 0) {
        return true;
      }
      
      else {
       return false; 
      }
  }
  
  
}
