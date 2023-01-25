

PVector findEOL(Joint j,PVector rotatingPoint,float angle ){
  PVector a = new PVector (j.coords.x,j.coords.y);
  PVector b = PVector.sub(rotatingPoint,a);
  float mag=b.mag();
  
  PVector updated = new PVector(mag*cos(angle)+a.x,mag*sin(angle)+a.y);
  
  
  //vector subtraction before i knew angles had to be used :(
  //b.sub(a);  
  ////length of limb
  //b.setMag(dist(j.coords.x,j.coords.y,rotatingPoint.x,rotatingPoint.y));
  //a.add(b);
  
  
  return updated;
  
}
