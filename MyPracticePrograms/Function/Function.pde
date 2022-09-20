void setup(){
  float y = f(11);
  println("y is",y);
  
  y=f(-3);
  
  println(y);
  
  y=f(-20);
  println(y);
  
  println(roundAny(10.32432424,2));
  
  
}

float roundAny(float x,int n){
  float t=round(x*pow(10,n));
  return t/pow(10,n);
}
float f(float x)
{
  return sqrt(x+5);
}
