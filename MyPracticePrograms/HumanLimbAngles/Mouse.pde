void mousePressed() {
  leftMousePressed=true;

  //detects if you are on a joint
  for (int i=0; i<bob.allJoints.size(); i++) {
    Joint currJoint = bob.allJoints.get(i);

    if (mouseX > currJoint.jointX-7 && mouseX<currJoint.jointX+7) {
      if (mouseY > currJoint.jointY-7 && mouseY<currJoint.jointY+7) {

        if (currJoint.locked) {
          Joint unlockedJoint = currJoint;
          currJoint.locked=false;

          for (int j=0; j<bob.allJoints.size(); j++) {
            if (bob.allJoints.get(j) != unlockedJoint && bob.allJoints.get(j).locked==false) {
              bob.allJoints.get(j).locked=true;
            }
          }
        } 
        else {
          currJoint.locked=true;
        }
      }
    }
  }
  
  for (int i=0; i<bob.allLimbs.size(); i++) {
    Limb currLimb = bob.allLimbs.get(i);
    if (mouseX>min(currLimb.tX,currLimb.bX)-7 && mouseX<max(currLimb.tX,currLimb.bX)+7){
      float slope;
     
      if (abs(currLimb.tX-currLimb.bX)==0){
        currLimb.clicked=true;
      }
      else{
        slope = (float(currLimb.tY)-currLimb.bY)/(currLimb.tX-currLimb.bX);
        
        //if y of mouse is between top and bottom of a limb
        //sin and arctan stuff is because line is not the same vertical height when tilted
        if (mouseY>currLimb.bY-abs(mouseX-currLimb.bX)*slope-(15/cos(atan(slope)))/2 && mouseY<currLimb.bY-abs(mouseX-currLimb.bX)*slope+(15/cos(atan(slope)))/2){
          println(abs(mouseX-currLimb.bX)*slope);
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
  
  leftMousePressed=false;
}
