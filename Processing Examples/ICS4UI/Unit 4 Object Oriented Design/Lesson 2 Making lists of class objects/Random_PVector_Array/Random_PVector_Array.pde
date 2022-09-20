void setup() {
  size(600,600);
  PVector[] points = getRandomPoints(6);
  
  for( PVector pv : points ) {
    circle(pv.x, pv.y, 50);
  }
}


PVector[] getRandomPoints(int numPoints) {
  PVector[] rp = new PVector[numPoints]; //allocates space in RAM for 6 PVector objects
  
  for(int i=0; i < numPoints; i++) { //fills the array rp with rand. values
    int randX = int( random(0, width) );
    int randY = int( random(0, height) );
    
    rp[i] = new PVector(randX, randY);
  }
  
  return rp;
}
