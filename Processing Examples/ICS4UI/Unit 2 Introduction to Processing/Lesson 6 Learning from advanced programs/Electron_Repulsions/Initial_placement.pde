void makeRandomPoints() {
  float xRand = 0, yRand = 0;
  
  if( boundaryShape.equals("square") ) {
    for(int i = 0; i < n; i++ ) {
      xRand = random( xWallLeft+5, xWallRight-5 );
      yRand = random( yWallTop+5, yWallBottom-5 );
      
      positions[i] = new PVector( xRand, yRand );
      velocities[i] = new PVector( 0, 0 );
      accelerations[i] = new PVector( 0, 0 );
      
      colors[i] = color(255,255,0);
    } 
  }
  
  else if( boundaryShape.equals("ring") ) {
    
    for(int i = 0; i < n; i++ ) { 
      float distFromCenter = 9999;
      
      while( distFromCenter > boundaryRadius ) {
        xRand = random( xWallLeft, xWallRight );
        yRand = random( yWallTop, yWallBottom );
        distFromCenter = dist(xRand, yRand, xC, yC);
      }
      
      positions[i] = new PVector( xRand, yRand );
      velocities[i] = new PVector( 0, 0 );
      accelerations[i] = new PVector( 0, 0 );
      
      colors[i] = color(255,255,0);
    }
  }
}


void makeGridPoints() {
  int dim = int(sqrt(n));

  n = round( pow(dim, 2) );
  float xStart = pad*5, xEnd = width-pad*5;
  float dx = (xEnd - xStart)/(dim-1);
  int k = 0;
  
  for(int i = 0; i < dim; i++ ) {
    float x = xStart + i*dx;
    
    for(int j = 0; j < dim; j++ ) {  
      float y = xStart + j*dx;
      positions[k] = new PVector( x, y );
      velocities[k] = new PVector( 0, 0 );
      accelerations[k] = new PVector( 0, 0 );
      
      colors[k] = color(255,255,0);
        
      k++;
    } 
  } 
}


void drawGridLines() {
  int dim = round(sqrt(n));
  int k = 0;
  stroke(128);

  for(int i = 0; i < dim; i++ ) {
    for(int j = 0; j < dim; j++ ) {  
      if( j < dim-1 )
        line(positions[k].x, positions[k].y, positions[k+1].x, positions[k+1].y);
        
      if( i < dim-1 )
        line(positions[k].x, positions[k].y, positions[k+dim].x, positions[k+dim].y);
        
      k++;
    }
  }   
  noStroke();
}


void drawBoundary() {
  stroke(255);
  strokeWeight(3);

  if( boundaryShape.equals("square") )
    square( pad, pad, width-2*pad );
    
  if( boundaryShape.equals("ring") )
    circle( xC, yC, width-2*pad );
  
  noStroke();
  strokeWeight(1);
}
  
  
