float xleft=-2;
float xright=1;
float ytop=1.5;
float ybottom=-1.5;

int xmouse;
int ymouse;

float newY;
float newX;

void setup(){
  size(1000,1000);
  
  noLoop();
  println(getA(0.15));
  println(getB(1));
  
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
      
      while (zMagnitude<2 && n<200){
        z=z.multiply(z).add(c);
        n++;
        zMagnitude = sqrt(pow(z.realPart,2) + pow(z.imagPart,2));      
      }
    
      if (n<200){
        
        stroke(n+55,n+55,255-n);
        point(x,y);
        
      }
      
      if(n==200){
        stroke(0);
        point(x,y);
      }
    }
  }
}

void updatePos(){
  newX=getA(xmouse);
  newY=getB(ymouse);
  
  
}

float getA(float x){
  return x/1000*(xright-xleft)+xleft;
}

float getB(float y){

    return ((1000-y)/1000*(ytop-ybottom)-ytop);

}
