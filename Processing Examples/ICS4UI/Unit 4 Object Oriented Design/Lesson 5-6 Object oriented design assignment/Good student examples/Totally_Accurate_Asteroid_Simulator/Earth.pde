class Earth extends MassObject {
  
  float massEaten = 0;
  

  
  Earth( float x, float y, float m, float r  ) {
    
    this.mass = m;
    this.radius = r;
    this.xC = x;
    this.yC = y;
    
    this.display();
  
  }
  
  
  void display() {
    
    noStroke();
    fill(earthColors[0]);
    ellipse( xC, yC, radius*2, radius*2 );
    
    fill(earthColors[1]);
    ellipse( xC-0.50*radius, yC-0.24*radius, 0.47*radius, 0.61*radius ); 
    ellipse( xC+0.05*radius, yC-0.37*radius, 0.87*radius, 0.36*radius );
    ellipse( xC-0.09*radius, yC-0.12*radius, 0.35*radius, 0.75*radius );
    ellipse( xC-0.34*radius, yC+0.10*radius, 0.40*radius, 0.75*radius );
    ellipse( xC+0.37*radius, yC+0.51*radius, 0.58*radius, 0.27*radius );
    
  }
  
  
  void eat( Asteroid a ) {
    
    this.massEaten += a.mass;
    
    if( this.massEaten > 100000 ) {
      earthColors[0] = color( 0, 0, 0);
      earthColors[1] = color( 0, 0, 0);
      status.message = "You've created a black hole.";
      this.mass = 100000;
      this.mass += a.mass;
    }
    else if( this.massEaten > 20000 ) {
      earthColors[0] = color(255,255,255);
      earthColors[1] = color(255,255,255);
      status.message = "Congratulations, the Earth is now a burning white ball of fire.";
    }
    else if(  this.massEaten > 10000 ) {
      earthColors[0] = color(255, 140, 0);
      earthColors[1] = color(255, 157, 0);
      status.message = "The Earth has been turned into a hellish wasteland.";
    }
    else if( this.massEaten > 5000 ) {
      earthColors[0] = color(79, 68, 56);
      earthColors[1] = color(97, 78, 57);
      status.message = "Heat from asteroid collisions have caused the oceans to boil and 99% of life on Earth is extinct.";
    }
    else {
      status.asteroidNews(); 
    }
 
  }
  
  
}
