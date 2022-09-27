void setup() {
 size(800,600);
 String radAngle = "2pi/3";
 int[] numAndDen=findNumAndDen(radAngle);
 float degrees=numAndDen[0]*180/numAndDen[1];
 
 String radAngleWithUnicode = "\u03c0";
 if (numAndDen[0]!=1){
   radAngleWithUnicode=numAndDen[0] + radAngleWithUnicode;
 }
 
 if (numAndDen[1]!=1){
   radAngleWithUnicode += "/" + numAndDen[1];
 }
 
 String message = (radAngleWithUnicode +  " radians = "+ degrees+ "\u00b0");
 textAlign(CENTER);
 textFont(createFont("Times New Roman",60));
 text(message,400,100);
 
 arc(400, 100, 60, 60, 0, 2*PI-float(numAndDen[0])/numAndDen[1]*PI);
 
}



int [] findNumAndDen (String radianMeasure) {
  int numerator;
  int denominator;
  int piIndex = radianMeasure.indexOf("pi");
  int slashIndex = radianMeasure.indexOf("/");
  
  if (slashIndex != -1){
    denominator = int(radianMeasure.substring(slashIndex+1,radianMeasure.length()));
  }
  
  else{
    denominator = 1;
  }
  
  if (piIndex != 0){
    numerator=int(radianMeasure.substring(0,piIndex));
  }
  
  else{
    numerator = 1;
  }
  
  int[] fraction = {numerator,denominator};
  return fraction;
}
