void setup() {
  float x, y;
 
  x = 3; y = -4;
  println("The point (" + x + ", " + y + ") is", getLocation("(1,2)"));

  x = 0; y = 0;
  println("The point (" + x + ", " + y + ") is", getLocation("(1,2)"));
 
  x = 2.5; y = 0;
  println("The point (" + x + ", " + y + ") is", getLocation("(1,2)"));

  x = -2.5; y = 5;
  println("The point (" + x + ", " + y + ") is", getLocation("(1,2)"));
 
  x = random(-20,20); y = random(-20, 20);
  println("The point (" + x + ", " + y + ") is", getLocation("(1,2)"));
}


String getLocation(String op) {
  //float[]coords=float(split(op, ","));
  //float x=coords[0];
  //float y=coords[1];
  
  int whereisopenbracket=op.indexOf("(");
  int whereisclosedbracket=op.indexOf(")");
  int whereiscomma=op.indexOf(",");
  int x=int((op.substring(whereisopenbracket+1,whereiscomma)));
  int y=int((op.substring(whereiscomma+1,whereisclosedbracket)));
  
  
  
  if( x==0 && y==0 )
    return "at the origin";
 
  else if ( y==0    )
    return "on the x-axis";
 
 
  else if ( x==0    )  
    return "on the y-axis";
   
   else if (x>0){
     
     if (y>0){
       return "quadrant 1";
     }
     
     else {
       return "quadrant 4";
     }
         
   }
   
   else if (x<0){
     if (y>0) {
       return "quadrant 2";
     }
     
     else {
       return "quadrant 3";
     }
     
   }
 
  else
    return "I have no idea where that is!";
 
}
