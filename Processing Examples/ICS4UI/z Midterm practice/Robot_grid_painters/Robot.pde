class Robot {
  float x, y, angle;
  String direction; //in degrees
  String mode; //"turning" or "walking"
  float speed;
  color col;
  
  
  Robot(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.direction = "right";
    this.angle = 0;
    this.speed = s;
  }
  
  void forward(float dist) {
    for(float t=0.0; t <= dist; t+= this.speed) {
      if (direction.equals("down"))
        this.y += this.speed;
        
      else if (direction.equals("up"))
        this.y -= this.speed;
        
      else if (direction.equals("left"))
        this.x -= this.speed;
        
      else
        this.x += this.speed;
      println(this.x);
      redraw();
      delay(500);
    }
  }
  
  void turnAround() {
    if (direction.equals("down"))
      direction = "up";
    else if (direction.equals("up"))
      direction = "down";
    else if (direction.equals("left"))
      direction = "right";
    else
      direction = "left";
  }


  void turnRight() {
    if (direction.equals("down"))
      direction = "left";
    else if (direction.equals("up"))
      direction = "right";
    else if (direction.equals("left"))
      direction = "up";
    else
      direction = "down";
  }


  void turnLeft() {
    if (direction.equals("down"))
      direction = "right";
    else if (direction.equals("up"))
      direction = "left";
    else if (direction.equals("left"))
      direction = "down";
    else
      direction = "up";
  }


  void drawMe() {
    if (direction.equals("down"))
      direction = "right";
      
    else if (direction.equals("up"))
      direction = "left";
      
    else if (direction.equals("left"))
      direction = "down";
      
    else
      direction = "up";
  }    
   
  
}
