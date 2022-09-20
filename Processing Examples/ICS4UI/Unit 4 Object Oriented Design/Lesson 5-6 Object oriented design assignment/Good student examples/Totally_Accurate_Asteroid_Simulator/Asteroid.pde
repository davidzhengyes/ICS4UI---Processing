class Asteroid extends MassObject { 
  
  float xV, yV;
  boolean isCollided = false;
  boolean isFused = false;
  
  ArrayList<Asteroid> fusedTo = new ArrayList<Asteroid>();
  
  Trail trail;
  
  //Constructor for building asteroid from scratch
  Asteroid(  float x, float y, float xVelo, float yVelo, float mr, String mode ){
    
    this.xC = x;
    this.yC = y;
    this.xV = xVelo;
    this.yV = yVelo;
    
    if( mode.equals("r") ) {
      this.radius = mr;
      this.mass = PI*pow( this.radius, 2 );
    }
    
    else if( mode.equals("m") ) {
      this.mass = mr;
      this.radius = pow( this.mass/PI, 1.0/2.0 );
    }
    
    this.fusedTo.add( this );
    
    this.display();
    
    trail = new Trail(xC, yC);
  }
  
  
  //Constructor for fusing multiple asteroids together into one using formulas for a perfectly inelastic collision
  Asteroid( ArrayList<Asteroid> fusedAsteroids ){
    
    float n = fusedAsteroids.size();
    float xCSum = 0;
    float yCSum = 0;
    float xP = 0;
    float yP = 0;
    float massSum = 0;
    
    for( int i=0; i<n; i++) {
      Asteroid a = fusedAsteroids.get(i);
      
      xCSum += a.xC*a.mass;
      yCSum += a.yC*a.mass;
      xP += a.xP();
      yP += a.yP();
      massSum += a.mass;
    }
    
    this.xC = xCSum/massSum; 
    this.yC = yCSum/massSum; 
    this.xV = xP/massSum;  
    this.yV = yP/massSum;
    this.mass = massSum;
    this.radius = pow( this.mass/PI, 1.0/2.0 );
    
    this.fusedTo.add( this );
    
    this.display();
    
    trail = new Trail( this.xC, this.yC );
    
  }
  
  
  
  void attract( MassObject p ) {
    
    //Distance to object
    float dx = p.xC - this.xC;
    float dy = p.yC - this.yC;
    float d = pythag( dx, dy );
    
    //Newton's law of universal gravitation
    float a = G*p.mass/pow(d,2);     
    float angle = atan2( dy, dx );
    
    //Add acceleration to velocity
    this.xV += cos(angle)*a*timeStep;
    this.yV += sin(angle)*a*timeStep;
    
  }
  
  
  
  void updatePos() {
    
    //Update x and y using current velocity
    this.xC += this.xV*timeStep;
    this.yC += this.yV*timeStep;
    
    //Update trail
    this.trail.update( this.xC, this.yC );
      
  }
  
  
  
  void display() {
    
    //Draw asteroid
    noStroke();
    fill(asteroidColor);
    ellipse( xC, yC, radius*2, radius*2 );

  }
  
  
  
  boolean checkCollision( MassObject a ) {
    
    float collisionDist = this.radius + a.radius;
    float currentDist = pythag( this.xC - a.xC, this.yC - a.yC );
    
    if( currentDist < collisionDist ) {
      return true;
    }
    
    else {
      return false;
    }
    
  }
  
  
  //P = momentum
  float xP() {
    
    float xP = this.xV * this.mass;
    return xP;
    
  }
  
  float yP() {
    
    float yP = this.yV * this.mass;
    return yP;
    
  }
    
    
}
