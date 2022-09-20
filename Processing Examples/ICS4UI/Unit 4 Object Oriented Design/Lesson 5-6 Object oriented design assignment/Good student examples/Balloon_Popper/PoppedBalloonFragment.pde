class PoppedBalloonFragment{
  PVector position = new PVector();
  PVector velocity = new PVector();
  int radius;
  color colour;
 
  PoppedBalloonFragment(float xP, float yP, int size, color c){
    this.position.x = xP;
    this.position.y = yP;
    float velocityDegree = random(0, 2*PI);
    float velocityModifierX = random(0, maxFragmentVelocities);
    float velocityModifierY = random(0, maxFragmentVelocities);
    this.velocity.x = sin(velocityDegree) * velocityModifierX;
    this.velocity.y = cos(velocityDegree) * velocityModifierY;
    this.radius = round(random(minFragmentRadius, round(size / 2)));
    this.colour = c;  
  }
 
  boolean isOffScreen(){
    
    if(this.position.x - this.radius >= width || this.position.x + this.radius <= 0 || this.position.y - this.radius >= height || this.position.y + this.radius <= 0)
      return true;
   
    return false;
  }
 
  void updatePosition(){
    this.position.x += this.velocity.x;
    this.position.y += this.velocity.y;
    if(fragGravity)
      this.velocity.y += fragGravityAmount;
  }
 
  void drawFragment(){
    fill(this.colour);
    ellipseMode(CENTER);
    ellipse(this.position.x, this.position.y, this.radius, this.radius);
  }
}
