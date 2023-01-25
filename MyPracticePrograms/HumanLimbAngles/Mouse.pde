//add something so limb doesnt jump when joint is clicket//
void mousePressed() {
  lastFrameMouse=new PVector(mouseX,mouseY);
  loop();
  leftMousePressed=true;
  jointSelected=false;
  //detects if you are on a joint
  for (int i=0; i<bob.allJoints.size(); i++) {
    Joint currJoint = bob.allJoints.get(i);

    if (mouseX > currJoint.coords.x-7 && mouseX<currJoint.coords.x+7) {
      if (mouseY > currJoint.coords.y-7 && mouseY<currJoint.coords.y+7) {
        jointSelected=true;
        if (currJoint.locked) {
          Joint unlockedJoint = currJoint;
          currJoint.locked=false;
          bob.selectedJoint=currJoint;

          for (int j=0; j<bob.allJoints.size(); j++) {
            if (bob.allJoints.get(j) != unlockedJoint && bob.allJoints.get(j).locked==false) {
              bob.allJoints.get(j).locked=true;
            }
          }
        } 
        else {
          currJoint.locked=true;
          
          bob.selectedJoint=null;
        }
      }
    }
  }
  
  if (jointSelected==false){
    for (int i=0; i<bob.allLimbs.size(); i++) {
      Limb currLimb = bob.allLimbs.get(i);
      
      //first checks if the mouse click is between limb endpoints in x direction
      if (mouseX>min(currLimb.topCoord.x,currLimb.bottomCoord.x)-7 && mouseX<max(currLimb.topCoord.x,currLimb.bottomCoord.x)+7){
        
        //if endpoints are aligned vertically
        if (currLimb.topCoord.x==currLimb.bottomCoord.x){
          currLimb.clicked=true;
          anyLimbClicked=true;
        }
        //if they are not vertically,
        else{
          //calculate slope
          currLimb.slope = (float(int(currLimb.topCoord.y-currLimb.bottomCoord.y)))/(currLimb.topCoord.x-currLimb.bottomCoord.x);
         
          //if y of mouse is between top and bottom of a limb
          //sin and arctan stuff is because line is not the same vertical height when tilted
         
          float adjustedLineHeight = (15/cos(atan(currLimb.slope)))/2;
          float slopeTimesXDist=abs(mouseX-int(currLimb.bottomCoord.x))*currLimb.slope;
          if (currLimb.bottomCoord.x<currLimb.topCoord.x){
            
            if (mouseY>currLimb.bottomCoord.y+slopeTimesXDist-adjustedLineHeight && mouseY<currLimb.bottomCoord.y+slopeTimesXDist+adjustedLineHeight){
           
              currLimb.clicked=true;
              anyLimbClicked=true;
              break;
            }
          }
          
          else{
            if (mouseY>currLimb.bottomCoord.y-slopeTimesXDist-adjustedLineHeight && mouseY<currLimb.bottomCoord.y-slopeTimesXDist+adjustedLineHeight){
              currLimb.clicked=true;
              anyLimbClicked=true;
              break;
            }
          }
         
        }
        
      }
    }
  }
}




void mouseReleased() {
  //if (jointSelected==true && mouse on joint){
  //  change joint status;
  //}
  //make all limbs unclicked
  anyLimbClicked=false;
  for (int i=0; i<bob.allLimbs.size(); i++) {
    bob.allLimbs.get(i).clicked=false;
  }
  
  leftMousePressed=false;
  noLoop();
}
