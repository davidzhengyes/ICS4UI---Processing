class Platform {
  float xPos;
  float yPos;
  float xInit;
  float yInit;
  float l;
  float h;
  float xS;
  float yS;
  float xR;
  float yR;
  
  //Constructor method.
  Platform(float x, float y, float le, float he, float xSp, float ySp, float xRa, float yRa, int d) {
    this.xPos = x;
    this.yPos = y;
    this.xInit = x;
    this.yInit = y;
    this.l = le;
    this.h = he;
    this.xS = xSp;
    this.yS = ySp;
    this.xR = xRa;
    this.yR = yRa;
    
    if (d == 1) {
      this.xS = this.xS*-1;
      this.yS = this.yS*-1;
    }
  }
  
  //Another constructor method.
  Platform(float x, float y, float le, float he, float xSp, float ySp, float xRa, float yRa) {
    this.xPos = x;
    this.yPos = y;
    this.xInit = x;
    this.yInit = y;
    this.l = le;
    this.h = he;
    this.xS = xSp;
    this.yS = ySp;
    this.xR = xRa;
    this.yR = yRa;
  }
  
  //Draws platform.
  void drawPlatform() {
    fill(111);
    rect(this.xPos, this.yPos, this.l, this.h);
  }
  
  //Updates it if it is a moving platform.
  void update() {
    this.xPos += this.xS;
    if (this.xPos > this.xInit + xR || this.xPos < this.xInit - xR) {
      this.xS = this.xS*-1;
    }
    this.yPos += this.yS;
    if (this.yPos > this.yInit + yR || this.yPos < this.yInit - yR) {
      this.yS = this.yS*-1;
    }
  }
  
}
