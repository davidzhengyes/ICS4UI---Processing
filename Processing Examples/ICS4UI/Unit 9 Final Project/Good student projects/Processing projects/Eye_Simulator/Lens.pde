class Lens{
  float focalLength;
  float power;
  Eye eye;
  
  Lens(float p, Eye e){
    this.power = p;
    this.focalLength = 1/p;
    this.eye = e;
  }
  
  void changePower(float p){
    this.power = p;
    this.focalLength = 1/p;
    eye.changeLensedPower();
  }
  
  void drawSelf(){
    float x = this.eye.x-32;
    float y = this.eye.y;
    if (this.power == 0){ //draws a flat glass if no power
      rect(x,y, 5,50);
    }
    else if (this.power > 0){ //draws a concave lens if positive power
      noFill();
      stroke(0,255,255);
      arc(x-8,y, 10,50, -PI/2,PI/2);
      arc(x+8,y, 10,50, PI/2, 3*PI/2);
      line(x-8,y-25, x+8,y-25);
      line(x-8,y+25, x+8,y+25);
    }
    else{ //draws a convex lens if negative power
      noFill();
      stroke(0,255,255);
      arc(x,y, 10,50, -PI/2,PI/2);
      arc(x,y, 10,50, PI/2, 3*PI/2);
    }
  }
}
