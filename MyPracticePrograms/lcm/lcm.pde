void setup(){
  
  int a=3;
  int b=33;
  
  int lcm = getLCM(a,b);
  
  print(lcm);
  
  
}

int getLCM(int a, int b){
  int A=a;
  int B =b;
   
  while (A!= B){
    
    if (A>B){
      B+=b;
    }
    
    if (B>A){
      A+=a;
    }
  }
  return A;
}
