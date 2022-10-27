void setup(){
  float [] sleepdata = {6,5,3.7,1,6};
  
  
  float avgSleep2=getArrayAverage(sleepdata);
  println("you got",avgSleep2,"hours of sleep each night on average");
}

float getArrayAverage(float[] values){
  float total=0;
  for (int i=0; i<values.length;i++){
    
    total+=values[i];
  }
  
  return total/values.length;
}
