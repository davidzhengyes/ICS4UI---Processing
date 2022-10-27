
void setup(){
  println(getTotalEnergy(5.0,100,20));
  println(getTotalEnergy(2.8,-5,-10));
  println(getTotalEnergy(-9,3,5));
}






float getTotalEnergy(float m, float h, float v){
  if (m<0 || h<0) {
    return 0.0;
  }
  
  else{

    return m*9.81*h+1.0/2*m*pow(v,2);
    
  }
  
  
  
}
