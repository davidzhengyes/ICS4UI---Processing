class Dot {
  PVector location;
  PVector center, minusCenter;
  float r;
  color col;
  float size;
  float distFromCenter;
  
  Dot(PVector p, PVector c) {   
   this.location = p;
   this.center = c;
   this.minusCenter = new PVector( -this.center.x, -this.center.y);
   this.distFromCenter = dist(c.x, c.y, p.x, p.y );
   this.col = color(0,0,255);
  }
  
  Dot(float x, float y, PVector c, color col, float size) {   
   this.location = new PVector(x, y);
   this.center = c;
   this.minusCenter = new PVector( -this.center.x, -this.center.y);
   this.distFromCenter = dist(c.x, c.y, x, y );
   this.col = col;
   this.size = size;
  }
 
 
  void rotate( float w ) {
    float c = cos(w);
    float s = sin(w);
    
    PVector v = this.location.add(minusCenter);
    PVector vRotated = new PVector(v.x*c + v.y*s, -v.x*s + v.y*c); 
    this.location = vRotated.add(this.center); 
   }
   
   
   void drawMe() {
     fill(this.col);
     noStroke();
     circle(this.location.x, this.location.y, this.size);
   }
}
