void mousePressed(){
  leftMousePressed=true;
  
  for (int i=0; i<bob.allJoints.size(); i++){
      Joint currJoint = bob.allJoints.get(i);
      
      if (mouseX > currJoint.jointX-7 && mouseX<currJoint.jointX+7){
        if (mouseY > currJoint.jointY-7 && mouseY<currJoint.jointY+7){
       
          if (currJoint.locked){
            Joint unlockedJoint = currJoint;
            currJoint.locked=false;
            
            for (int j=0; j<bob.allJoints.size(); j++){
              if (bob.allJoints.get(j) != unlockedJoint && bob.allJoints.get(j).locked==false){
                bob.allJoints.get(j).locked=true;
              }
            }
          }
          else{
            currJoint.locked=true;
            
          }
          
        }
      }
    }
  //if (mouse on the joint when clicked){
  //  jointSelected = true;
    
  //}
}




void mouseReleased(){
  //if (jointSelected==true && mouse on joint){
  //  change joint status;
  //}
  leftMousePressed=false;
}
