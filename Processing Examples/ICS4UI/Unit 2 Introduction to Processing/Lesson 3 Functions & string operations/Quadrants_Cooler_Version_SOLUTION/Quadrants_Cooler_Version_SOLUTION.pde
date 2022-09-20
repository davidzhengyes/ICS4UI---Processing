void setup() {
  String p;
  
  p = "(1367.2, -54.999)"; 
  println("The point", p, "is", getLocationFromOrderedPair(p));

  p = "(0, -4)"; 
  println("The point", p, "is", getLocationFromOrderedPair(p));
  
  p = "(-62.5, -0.03)"; 
  println("The point " + p + " is " + getLocationFromOrderedPair(p));

  p = "(-28.541, 150.7)"; 
  println("The point " + p + " is " + getLocationFromOrderedPair(p));
}


String getLocationFromOrderedPair( String pair )
{
  float xCoord, yCoord;
  
  int commaIndex = pair.indexOf(",");
  int L = pair.length();
  
  xCoord = float( pair.substring(1, commaIndex) );
  yCoord = float( pair.substring(commaIndex+1, L-1) );
  
  return getLocation( xCoord, yCoord ); 
}


String getLocation(float x, float y) {
  if ( x == 0 && y == 0 ) 
    return "at the origin";
   
  else if ( x == 0 ) 
    return "on the y-axis";
   
  else if ( y == 0 ) 
    return "on the x-axis";
   
  else if ( x > 0 && y > 0 ) 
    return "in quadrant 1";
   
  else if ( x < 0 && y > 0 ) 
    return "in quadrant 2";
   
  else if ( x < 0 && y < 0 ) 
    return "in quadrant 3";
   
  else 
    return "in quadrant 4";
}
