class Fluid {
  float density;
  
  Fluid(float d) {
    //Create new Fluid object using arguments
    this.density = d;
  }
  
  PVector getVelocity(PVector position) {
    //Calculate the velocity at a position in a vector field
    //defined where each component is a function of x, y, z
    
    //F(x, y, z) = (y, y-x, z-y)
    float vX = position.y;
    float vY = position.y-position.x;
    float vZ = 0;
    return new PVector(vX, vY, vZ);
  }
  
  PVector getCurl(PVector position) {
    //Calculate the curl at a position in a vector field
    //defined as the curl of the velocity vecotr field
    
    //MANUALLY CALCULATED
    //F(x, y, z) = (dFz/dy-dFy/dz, dFx/dz-dFz/dx, dFy/dx-dFx/dy)
    float cX = 0 - 0;
    float cY = 0 - 0;
    float cZ = -1 - 0;
    return new PVector(cX, cY, cZ);
  }
  
  //Retreival function to prevent unnecessary manipulation of fields
  float getDensity() {
    return this.density;
  } 
}
  