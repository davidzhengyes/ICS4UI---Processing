void setup(){
for (float theta=0; theta<2*PI; theta+=0.1){
     float LS=sec(3*theta);
     float RS=pow(sec(theta),3)/(4-3*pow(sec(theta),2));
     println(theta, LS, "=",RS);
     
  }
  
}

float sec(float angle){
  return 1/cos(angle);
}
