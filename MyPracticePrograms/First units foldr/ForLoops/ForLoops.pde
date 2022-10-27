float total=0;

void setup(){
for (float theta=0; theta<2*PI; theta+=0.1){
     float LHS=sin(2*theta);
     float RHS=2*sin(theta)*cos(theta);
     println(LHS,RHS);
  }
  
}
