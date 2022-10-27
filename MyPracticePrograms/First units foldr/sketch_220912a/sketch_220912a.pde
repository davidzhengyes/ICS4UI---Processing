float x=100;
float y=200;
float s=5;
float t=5;



void setup() {
  size(800,600);
  background(0,0,90);
}

void draw()
{
  
 
  fill(random(1,mouseX),0,random(1,mouseX));
  rotate(45);        
  square(x,y,50);
  
  
  
  if (y>height ||y<0)
  {
    t*=-1;
  }
  
  if (x>width || x<0){
    s*=-1;
  }
  
  x+=s;
  y+=t;
  
  
  
}
