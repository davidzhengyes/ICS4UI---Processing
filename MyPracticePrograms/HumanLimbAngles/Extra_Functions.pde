
//finds rotated point around a circle using position of a joint, the point wanting to be rotated and angle in radians
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

//storing positions in a text file
void writeToFile(){
    // a for loop here would have too many conditions
    pw.print(bob.leftFemur.topCoord.x);
    pw.print(",");
    pw.print(bob.leftFemur.topCoord.y);
    pw.print(",");
    pw.print(bob.leftFemur.bottomCoord.x);
    pw.print(",");
    pw.print(bob.leftFemur.bottomCoord.y);
    pw.print(",");
    
    pw.print(bob.leftTibia.topCoord.x);
    pw.print(",");
    pw.print(bob.leftTibia.topCoord.y);
    pw.print(",");
    pw.print(bob.leftTibia.bottomCoord.x);
    pw.print(",");
    pw.print(bob.leftTibia.bottomCoord.y);
    pw.print(",");
    
    pw.print(bob.leftFoot.topCoord.x);
    pw.print(",");
    pw.print(bob.leftFoot.topCoord.y);
    pw.print(",");
    pw.print(bob.leftFoot.bottomCoord.x);
    pw.print(",");
    pw.println(bob.leftFoot.bottomCoord.y);
   
}
