void keyPressed(){
  
  //pause-unpause with SPACE
  if (key == ' '){
    if (paused){
      loop();
      paused = false;
    }
    else{
      noLoop();
      paused = true;
    }
  } 
  
  //step with ENTER
  if (key == ENTER){
    noLoop();
    paused = true;
    redraw();
  }
  
}
