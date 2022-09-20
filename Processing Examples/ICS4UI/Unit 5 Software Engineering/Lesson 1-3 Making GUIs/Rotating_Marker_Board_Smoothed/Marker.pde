class Marker {
  float x, y;
  float xSpeed, ySpeed;
  float distFromCenter;
  float frequency, amplitude, period, periodQuarter, squareSpeed;
  String motionType;  //"sinusoidal", "linear", "circular", "figure8", "parabola", "mouse"
  float xCentrePercent, yCentrePercent;
  color colour;
  int strokeSize;

  //CONSTRUCTOR 1
  Marker(String mt, float fr, float amp, float xcp, float ycp, color col) {
    this.motionType = mt;
    this.frequency = fr;
    this.amplitude = amp;
    this.xCentrePercent = xcp;
    this.yCentrePercent = ycp;
    this.colour = col;
    this.strokeSize = 3;
    getSquareParameters();
  }
  
  //CONSTRUCTOR 2
  Marker( color col ) {
    this.colour = col;
  }
  
  
  void getSquareParameters() {
    this.period = 2*PI/this.frequency;
    this.periodQuarter = this.period/4;
    this.squareSpeed = 2*this.amplitude/periodQuarter;
  }

  void updatePosition() { 
    float f = this.frequency;
    float A = this.amplitude;
    float xC = width*this.xCentrePercent;
    float yC = height*this.yCentrePercent;
    
    if ( this.motionType.equals("sinusoidal") ) {
      this.x = xC + A*sin(f * t);
      this.y = yC;
    }
    
    else if ( this.motionType.equals("circular") ) { 
      this.x = xC + A*cos( f * t);
      this.y = yC + A*sin( f * t);
    }
    
    else if ( this.motionType.equals("figure8") ) { 
      this.x = xC + A*sin( 2 * f * t);
      this.y = yC + A*sin( f * t);
    } 
    
    else if ( this.motionType.equals("pretzel") ) { 
      this.x = xC + A*sin( 4 * f * t);
      this.y = yC + A*sin( 3 * f * t);
    } 
    
    else if ( this.motionType.equals("parabola") ) { 
      this.x = xC + A*sin( f * t);
      this.y = yC - A*sin( 2*f * t + HALF_PI);
    } 
    
    else if ( this.motionType.equals("square") ) { 
      float t2 = t % period;
      float t3 = t % periodQuarter;
      float ds = squareSpeed*t3;
      
      if( t2 <= periodQuarter )
      {
        this.x = xC + A;
        this.y = yC + A - ds;
      }
      
      else if( t2 <= 2*periodQuarter )
      {
        this.x = xC + A - ds;
        this.y = yC - A;
      }
      
      else if( t2 <= 3*periodQuarter )
      {
        this.x = xC - A ;
        this.y = yC - A + ds;
      }
      
      else if( t2 <= period )
      {
        this.x = xC - A + ds;
        this.y = yC + A;
      }      
    } 

    else if ( this.motionType.equals("mouse") ) { 
      this.x = mouseX;
      this.y = mouseY;
    }
    
    this.distFromCenter = dist(this.x, this.y, center.x, center.y);
  }  
  
  
  void drawMe() {
    fill( this.colour );
    stroke(0);
    circle(this.x, this.y, 12);
  }
}
