class MarkerPoint {
  PVector location;
  PVector center, minusCenter;
  float r;
  color col;
  float size;
  float distFromCenter;
  
  //CONSTRUCTOR #1
  MarkerPoint(PVector p, PVector c){   
   this.location = p;
   this.center = c;
   this.minusCenter = new PVector( -this.center.x, -this.center.y);
   this.distFromCenter = dist(c.x, c.y, p.x, p.y );
   this.col = color(0,0,255);
  }
  
  //CONSTRUCTOR #2
  MarkerPoint(float x, float y, PVector c, color col, float size){   
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
    
    PVector v = this.location.add( minusCenter );                  //TRANSLATING THE MARKER POINT'S LOCATION VECTOR BACK TO THE ORIGIN SO WE CAN MORE EASILY CALCULATE ITS ROTATION BY THE GIVEN ANGLE w
    PVector vRotated = new PVector(v.x*c + v.y*s, -v.x*s + v.y*c); //USING THE ROTATION FORMULA xRotated = x cos(w)-y sin(w), yRotated = -x sin(w) + y cos(w)
    this.location = vRotated.add( this.center );                   //TRANSLATING THE ROTATED VECTOR BACK TO THE CENTER WITH THE FORMULA xFinal = xC + xRotated, yFinal = yC + yRotated
   }
   
   
   void drawMe() {
     fill( this.col );
     noStroke();
     circle( this.location.x, this.location.y, this.size);
   }
}
