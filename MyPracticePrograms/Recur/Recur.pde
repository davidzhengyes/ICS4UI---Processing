void setup(){
  
  
  println(h(12));
  
}


boolean isDivBy3(int x){
  String y=str(x);
  if (x==0 || x==3 ||x==6|| x==9){
    return true;
  }
  else if (x>=1&& x<9){
    return false;
  }
  else{
    int sum = getDigitSum(x);
    return isDivBy3(sum);
  }
  
}

float h(float x){
  if (x<=2){
    return 1;
  }
  else{
    return (3*h(x/2)+4);
    
  }
  
}
