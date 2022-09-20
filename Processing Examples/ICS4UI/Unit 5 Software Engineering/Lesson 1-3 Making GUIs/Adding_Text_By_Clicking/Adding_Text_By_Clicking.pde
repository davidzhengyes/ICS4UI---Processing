import g4p_controls.*;

ArrayList<String> onScreen = new ArrayList<String>();
int yPos = 100;

void setup(){
  size(500,500);
  createGUI();
  background(0);
 
}

void draw(){
  background(0);
  
  for(String s : onScreen) {
    text(s, 100, yPos);
  }
}
