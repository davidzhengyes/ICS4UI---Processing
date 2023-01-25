PVector point = new PVector(200,200);
PVector rotatedPoint=new PVector(300,300);
void setup(){
  size(400,400);
  
}
float ang=1;
void draw(){
  fill(0);
  circle(point.x,point.y,15);
  
  circle(rotatedPoint.x,rotatedPoint.y,15);
  
  rotate(point,rotatedPoint,ang);
  
  //circle(sin(ang)*100+200,-1*cos(ang)*100+200,5);
  ang+=PI/120;
}



void rotate(PVector center, PVector point, float angle){
  float x,y;
  PVector z=PVector.sub(point,center);
  float mag=z.mag();
  x=mag*cos(angle)+center.x;
  y=mag*sin(angle)+center.y;
  
  circle(x,y,10);
  
}
