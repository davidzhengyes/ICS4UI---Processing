String typing = "";
PFont f;

void setup() {
  size(900,200);
  f = createFont("Arial", 24);
  textFont(f);
}

void draw(){
  background(255);
  fill(255,0,0);
  text(typing, 100, 100);
}

void keyPressed() {
  if( key == BACKSPACE ) {
    if (typing.length() > 0 )
      typing = typing.substring(0, typing.length()-1);
  }
    
  else
    typing = typing + key;
}
