class Ring {
  float x, y;
  float radius, diameter;
  float speed;
  
  
  Ring(float xPos, float yPos, float r, float s) {
    this.x = xPos;
    this.y = yPos;
    this.radius = r;
    this.speed = s;
    this.diameter = 2*r;
  }
  
  void grow() {
    radius += speed;
    this.diameter = 2*radius;
  }
  
  void drawCircular() {
    ellipse(x, y, diameter, diameter);
  }
  
  void drawSquare() {
    rect(x-radius, y-radius, diameter, diameter);
  }
}