String [] messages = new String[5];
float [] radianMeasure = new float[5];
void setup() {
 String[] radAngles = loadStrings("radianMeasures.txt");
 background(0);
 size(800,600);
 
 for (int i=0; i<5; i++){
   String radAngle = radAngles[i];
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
   messages[i]=message;
   radianMeasure[i]=2*PI-float(numAndDen[0])/numAndDen[1]*PI;
   
   textAlign(CENTER);
   textFont(createFont("Times New Roman",60));
   
   
   circle(400,105+115*i,61);
 
   
  }
 
}

void draw(){
  fill(255,255,255);
  text(messages[frameCount-1],400,65+115*(frameCount-1));
  fill(0,255,0);
  circle(400,105+115*(frameCount-1),63);
  fill(0);
  arc(400, 105+115*(frameCount-1), 60, 60, 0, radianMeasure[frameCount-1]);
  if(frameCount==5)
  noLoop();
  
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
