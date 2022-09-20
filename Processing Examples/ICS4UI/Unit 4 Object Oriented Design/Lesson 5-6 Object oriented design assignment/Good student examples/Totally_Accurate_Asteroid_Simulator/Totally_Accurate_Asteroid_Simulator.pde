/* 
CONTROLS

Esc : exit program
X   : delete all asteroids
R   : reset the simulation
T   : toggle whether trails are displayed
S   : toggle displaying status message and timestep
-/+ : decrease/increase the timestep (slowmo/fastmo)

Click and drag LMB to shoot asteroids
Scroll while holding down LMB or shift to change asteroid size
Scroll while holding down control to change shooting power
*/

//Numbers
int fps = 30;   //Frame Rate
float G = 42.50; //Gravitational constant
float crosshair = 5;  //Aiming crosshair diameter
float aimPower = 0.2;  //How powerful asteroid shots are
int trailLength = 6;  //Length of trails for asteroids, must be greater than 1
float timeStep = 1;  //The amount of time that passes in each frame. Lower timesteps leads to more accurate physics and slower animation. Higher timesteps lead to less accurate physics and faster animation.
float despawnBounds = 1000; //How far off screen an asteroid can travel before despawning

//Options
boolean trailsOn  = true;  //Toggles whether trails will be displayed or not
boolean statusOn  = true;  //Toggles whether status message and timestep are displayed
boolean earthCollisionsOn = true;  //Toggles whether asteroids can collide with Earth or not (setting to false can lead to wonky physics)
String asteroidCollisionMode = "fuse"; //Set to "none", "destroy", or "fuse". Determines whether asteroids will be destroyed when colliding

//Colors
color trailColor = color(255);
color asteroidColor = color(130);
color[] earthColors = new color[2];

//Input
boolean shift = false;
boolean ctrl = false;
boolean lmb   = false;

//Objects
PVector click = new PVector();
PVector release = new PVector();
Earth earth;
Status status;
ArrayList<Asteroid> asteroids;



void setup() {
  
  fullScreen();
  
  textFont( createFont("Georgia", 24) );
  background(0);
  frameRate(fps);
  
  reset();
  
}



void draw() { 

  background(0);
  
  updateAsteroidPositions();
  
  displayAsteroids();
  earth.display();
  status.display();
  displayCrosshair();
  
  checkEarthCollisions();
  checkAsteroidCollisions();
  
  
}




void updateAsteroidPositions() {

  for( int i=asteroids.size()-1; i>=0; i-- ) {
    Asteroid a = asteroids.get(i); 
    a.updatePos();
    if( a.xC < -despawnBounds || a.yC < -despawnBounds || a.xC > despawnBounds+displayWidth || a.yC > despawnBounds+displayHeight )
      asteroids.remove(i);
    a.attract(earth);
  }
}


void displayAsteroids() {
  
  for( int i=0; i<asteroids.size(); i++ ) {
    Asteroid a = asteroids.get(i);
    if( trailsOn ) 
      a.trail.display();
    a.display();
  }
}


void displayCrosshair() {
  
  if( lmb ) {
    stroke(255);
    noFill();
    ellipse( click.x, click.y, crosshair*2, crosshair*2 );
    line( click.x, click.y, mouseX, mouseY);
  }
  else if( shift ) {
    stroke(255);
    noFill();
    ellipse( mouseX, mouseY, crosshair*2, crosshair*2 );
  }
}


void checkEarthCollisions() {
  
  if( earthCollisionsOn ) {
    for( int i=asteroids.size()-1; i>-1; i-- ) {
      Asteroid a = asteroids.get(i);
      
      if( a.checkCollision( earth ) ) {
        earth.eat(a);
        asteroids.remove(i);
      }  
    }
  }
}


void checkAsteroidCollisions() {
  
  if( ! asteroidCollisionMode.equals("none") ) {
    
    if( asteroidCollisionMode.equals("destroy") )    
      destroyCollision();
    else if( asteroidCollisionMode.equals("fuse") )  
      fuseCollision();
      
  }
}

//Collision handler if collision mode is "destroy"
void destroyCollision() {
  
  //Find collisions
  for( int i=0; i<asteroids.size(); i++ ) {
    for( int j=i+1; j<asteroids.size(); j++ ) {
      Asteroid a = asteroids.get(i);
      Asteroid b = asteroids.get(j);
      
      if( a.checkCollision(b) ) {
        a.isCollided = true;
        b.isCollided = true;
      }
    }
  }
  
  //Remove collided asteroids
  for( int i=asteroids.size()-1; i>-1; i-- ) {
    Asteroid a = asteroids.get(i);
    if( a.isCollided )
      asteroids.remove(i);
  }
}


//Collision handler if collision mode is "fuse"
void fuseCollision() {
  
  //Finds all collided asteroids and store who they are collided to
  for( int i=0; i<asteroids.size(); i++ ) {
    for( int j=i+1; j<asteroids.size(); j++ ) {
      Asteroid a = asteroids.get(i);
      Asteroid b = asteroids.get(j);
      
      if( a.checkCollision(b) ) {
        
        a.isCollided = true;
        b.isCollided = true;
        
        a.fusedTo.add(b);
        b.fusedTo.add(a); 
      } 
    }  
  }
 
  //Fuses groups of collided asteroids together
  for( int i=asteroids.size()-1; i>-1; i-- ) {
    Asteroid a = asteroids.get(i);
    
    if( a.isCollided ) {
      
      //This part ensures that no duplicate fused asteroids are made
      if( a.isFused ) {
        asteroids.remove(i);
      }
      else {
        for( int j=0; j<a.fusedTo.size(); j++ ) {
          Asteroid b = a.fusedTo.get(j);
          b.isFused = true;
        }
        asteroids.add( new Asteroid( a.fusedTo ) );
        asteroids.remove(a);
      }
    }
  }
}


void reset() {
  asteroids = new ArrayList<Asteroid>();
  earth = new Earth( width/2, height/2, 1000, 50 );
  status = new Status();
  earthColors[0] = color(40,40,240);
  earthColors[1] = color(40,130,50);  
}


//Shortcut for pythagorean theorum
float pythag( float a, float b ) {
  return sqrt( pow(a,2) + pow(b,2) );
}
