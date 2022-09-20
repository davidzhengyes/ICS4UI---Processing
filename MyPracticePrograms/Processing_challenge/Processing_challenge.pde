String request = "Draw a red circle at center (200, 300) and radius 255";
//Assume the user can only say red, blue, green or black

String colour=request.substring(request.indexOf("a ")+2, request.indexOf("circle")-1);
float x=float(request.substring(request.indexOf("(")+1, request.indexOf(",")));
float y=float(request.substring(request.indexOf(",")+1,request.indexOf(")")));
float radius=float(request.substring(request.indexOf("ius")+3,request.length()));


    

void setup(){
  size(800,600);
  
  
  
}



void draw(){
  switch (colour){
  case "red":
    fill(255,0,0);
    break;
    
  case "blue":
    fill(0,0,255);
    break;
    
  case "green":
    fill(0,255,0);
    break;
    
   case "black":
     fill (0);
     break;
    
  }
  circle(x,y,radius);
  
}
