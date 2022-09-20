void mousePressed() {
  
  if( mouseButton == LEFT ) {
    click.x = mouseX;
    click.y = mouseY;
    
    lmb = true;
  }
  
}

void mouseReleased() {
  
  if( mouseButton == LEFT ) {
    release.x = mouseX;
    release.y = mouseY;
    float dx = click.x - release.x;
    float dy = click.y - release.y;
    
    Asteroid a = new Asteroid( int(click.x), int(click.y), aimPower*dx, aimPower*dy, crosshair, "r" );
    asteroids.add(a);
    
    lmb = false;
  }
  
}

void mouseWheel( MouseEvent event ) {
  
  float e = event.getCount();
  
  //Changing asteroid shooting power
  if( ctrl ) {
    aimPower -= e*0.05;
    if( aimPower < 0 )
      aimPower = 0;
    else if( aimPower > width/400.0 )
      aimPower = width/400.0;
  }
  
  //Changing asteroid size
  else if( lmb || shift ) {
    crosshair -= e;
    if( crosshair < 0 ) 
      crosshair = 0;
  }
  
}

void keyPressed() {
  
  if( key == 'x' || key == 'X' ) 
    asteroids = new ArrayList<Asteroid>();
    
  if( key == 'r' || key == 'R' )
    reset();
    
  if( key == 't' || key == 'T' )
    trailsOn = !trailsOn;
    
  if( key == 's' || key == 'S' )
    statusOn = !statusOn;
    
  if( key == '+' )
    timeStep /= 0.9;
   
  if( key == '-' )
    timeStep *= 0.9;
    
  keyHeld( true );
  
}

void keyReleased() { 
  
  keyHeld( false );
  
}


//Keeps track of which keys are being held down
void keyHeld( boolean mode ) {
  
  if( keyCode == SHIFT )  shift = mode;
  
  else if( keyCode == CONTROL )  ctrl = mode;
  
}
