

PVector findEOL(Joint j){
  PVector a = new PVector (j.jointX,j.jointY);
  PVector b = new PVector (mouseX,mouseY);
  b.sub(a);  
  //length of limb
  b.setMag(100);
  a.add(b);
  
  
  return a;
  
}
