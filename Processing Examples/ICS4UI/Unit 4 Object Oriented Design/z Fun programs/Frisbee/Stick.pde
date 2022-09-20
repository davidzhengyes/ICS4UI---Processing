class Stick {
  float r, xC, yC, x1, y1, x2, y2, theta, alpha, w;
  float phaseShift; 
  
  Stick(float alphaGiven, float wGiven, float phaseShiftGiven) {
    this.alpha = alphaGiven;
    this.theta = alphaGiven + PI/2;
    this.w = wGiven;
    this.phaseShift = phaseShiftGiven;

    this.setPoints();
  }
  
  
  void setPoints() {
    this.r = R*cos(t-this.phaseShift);
    
    this.xC = XC + this.r*cos( this.alpha );
    this.yC = YC - this.r*sin( this.alpha );
    
    this.x1 = this.xC + stickLength * cos(this.theta);
    this.y1 = this.yC - stickLength * sin(this.theta);
    
    this.x2 = this.xC + stickLength * cos(this.theta + PI);
    this.y2 = this.yC - stickLength * sin(this.theta + PI);
  }
  
  
  void drawMe() {
    stroke(circleCol);
    circle(this.xC, this.yC, 2*stickLength);
    stroke(stickCol);
    line(this.x1, this.y1, this.x2, this.y2);
  }
  
  
  void update() {
    this.theta += this.w;
    this.setPoints();
  }
}
