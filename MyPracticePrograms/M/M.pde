void setup(){
  size(1000,1000);
  
  noLoop();
  println(getA(500));
  println(getB(500));
  
  new ComplexNum(1.0,2.0).multiply(new ComplexNum(2,3)).describe();
}

void draw(){
  for (int x=0; x<=1000; x++){
    for(int y=0;y<=1000;y++){
      float a=getA(x);
      float b=getB(y);
      
      ComplexNum c = new ComplexNum(a,b);
      ComplexNum z=c;
      
      int n=1;
      float zMagnitude = sqrt(pow(z.realPart,2) + pow(z.imagPart,2));
      
      while (zMagnitude<2 && n<=200){
        z=z.multiply(z).add(c);
        n++;
        zMagnitude = sqrt(pow(z.realPart,2) + pow(z.imagPart,2));      
      }
    
      
      if(n==201){
        
        point(x,y);
      }
    }
  }
}

float getA(float x){
  return x/1000*3-2;
}

float getB(float y){

    return ((1000-y)/1000*3-1.5);

}
