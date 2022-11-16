void setup(){
  size(1000,1000);
  
  noLoop();
  
}

void draw(){
  for (int x=0; x<=1000; x++){
    for(int y=0;y<=1000;y++){
      float a=getA(x);
      float b=getB(y);
      
      ComplexNumber c = new ComplexNumber(a,b);
      ComplexNumber z=c;
      
      int n=1;
      
      while (z is still small enough and n<=200){
        z=z^2+c;
        n++;
      }
      
      if(n==200){
        draw a black dot at x,y;
      }
    }
  }
}

float getA(float x){
  return x/1000*3-2;
}

float getB(float y){
  if (y<=500){
    return (1000-y)/1000*3-1.5;
  }
  else{
    return ((1000-y)/1000*3-1.5);
  }
}
