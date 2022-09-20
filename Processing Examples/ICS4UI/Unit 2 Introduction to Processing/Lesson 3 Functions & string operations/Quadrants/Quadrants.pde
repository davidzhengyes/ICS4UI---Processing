void setup() {
  float x, y;
  
  x = 3; y = -4; 
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));

  x = 0; y = -4; 
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));
  
  x = 2.5; y = 0; 
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));

  x = -2.5; y = 5; 
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));
  
  x = random(-20,20); y = random(-20, 20);
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));
}


String getLocation(float x, float y) {
  if ( x==0 && y==0 ) 
    return "at the origin";
   
  else if ( x==0 ) 
    return "on the y-axis";
   
  else if ( y==0 ) 
    return "on the x-axis";
   
  else if ( x>0 && y>0 ) 
    return "in Quadrant 1";
   
  else if ( x<0 && y>0 )
    return "in Quadrant 2";
   
  else if ( x<0 && y<0 ) 
    return "in Quadrant 3";
   
  else 
    return "in Quadrant 4";
}
