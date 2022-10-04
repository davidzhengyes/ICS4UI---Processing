String [] messages = new String[5];
float [] radianMeasure = new float[5];
void setup() {
 String[] radAngles = loadStrings("radianMeasures.txt");
 background(0);
 size(800,600);
 
 for (int i=0; i<5; i++){
   String radAngle = radAngles[i];
   int[] numAndDen=findNumAndDen(radAngle);
   float degrees=degrees(float(numAndDen[0])/numAndDen[1]*PI);
   
   String radAngleWithUnicode = "\u03c0";
   if (abs(numAndDen[0])!=1){
     radAngleWithUnicode=numAndDen[0] + radAngleWithUnicode;
   }
   
   if (abs(numAndDen[1])!=1){
     radAngleWithUnicode += "/" + numAndDen[1];
   }
  
   String message = (radAngleWithUnicode +  " radians = "+ degrees+ "\u00b0");
   messages[i]=message;
   radianMeasure[i]=float(numAndDen[0])/numAndDen[1]*PI;
   
   textAlign(CENTER);
   textFont(createFont("Times New Roman",60));
   printArray(radianMeasure);
   
  }
  
}

void draw(){
  fill(255,255,255);
  text(messages[frameCount-1],400,65+115*(frameCount-1));
  noFill();
  stroke(255,255,255);
  circle(400,105+115*(frameCount-1),60);
  
  fill(0,255,0);
  if (radianMeasure[frameCount-1]>0)
  arc(400, 105+115*(frameCount-1), 60, 60, 2*PI-radianMeasure[frameCount-1], 2*PI);
  
  else
  arc(400, 105+115*(frameCount-1), 60, 60, 0, -1*radianMeasure[frameCount-1]);
  
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
    String BeforePi = radianMeasure.substring(0,piIndex);
    
    if(BeforePi.equals("-")){
      numerator=-1;
    }
    else
    numerator=int(BeforePi);
  }
  
  else{
    numerator = 1;
  }
  
  int[] fraction = {numerator,denominator};
  return fraction;
}
