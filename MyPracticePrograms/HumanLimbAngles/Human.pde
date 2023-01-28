class Human{
  Joint leftHip;
  Limb leftFemur;
  Joint leftKnee;
  Limb leftTibia;
  Joint leftHeel;
  Limb leftFoot;
  
  Joint selectedJoint;
  ArrayList<Limb> allLimbs = new ArrayList<Limb>();
  ArrayList<Joint> allJoints = new ArrayList<Joint>();
  
  String name;
  
  Human(String n){
    this.name=n;
    
    this.leftHip=new Joint("Hip", 300,300);
    
    this.leftFemur=new Limb ("Femur", 300,300,300,400);
    this.leftKnee = new Joint ("Knee", 300,400);
    this.leftTibia = new Limb ("Tibia", 300,400,400,490);
    this.leftHeel=new Joint("Heel",400,490);
    this.leftFoot=new Limb ("Foot",400,490,300,500);
    
    allLimbs.add(leftFemur);
    allLimbs.add(leftTibia);
    allLimbs.add(leftFoot);
    allJoints.add(leftHip);
    allJoints.add(leftKnee);
    allJoints.add(leftHeel);
   
  }
  
  
  //shows everything on screen
  void display(){
    
    for (int i=0; i<allLimbs.size(); i++){
      Limb currLimb = allLimbs.get(i);
      strokeWeight(15);
      stroke(255);
      
      //this whole chain of ifs determine what text file to read from, or to use values from moving limbs with mouse
      if (democlick==false && userClick==false){
        line(currLimb.topCoord.x,currLimb.topCoord.y,currLimb.bottomCoord.x,currLimb.bottomCoord.y);
       
      }
      else if (democlick && frameCount<frameWhenDemoClick+demoData.length){
        String [] frame=demoData[frameCount-frameWhenDemoClick].split(",");
        //takes one row from txt file and splits into an array for positions
        
        line(int(frame[i*4]),int(frame[i*4+1]),int(frame[i*4+2]),int(frame[i*4+3]));
        //for each limb
       
      }
      
      
      else if (userClick && recordingUser==false && frameCount<frameWhenUserClick+userDemo.length ){
        String [] frame=userDemo[frameCount-frameWhenUserClick].split(",");
      
        line(int(frame[i*4]),int(frame[i*4+1]),int(frame[i*4+2]),int(frame[i*4+3]));
      }
      else{
        democlick=false;
        userClick=false;
       
      }
    }
    
    //displays joints
    for (int i=0; i<allJoints.size(); i++){
      Joint currJoint = allJoints.get(i);
      strokeWeight(15);
      if (currJoint.locked){
        stroke(0,0,255);
      }
      else{
        stroke(0,255,0);
      }
      if (democlick==true || userClick==true){
        //if during a demo, do nothing
      }
      else{
        point(currJoint.coords.x,currJoint.coords.y);
      }
    }
  }
  
  void update(){
    //check which limb if any is clicked
        
    for (int i=0; i<this.allLimbs.size(); i++) {
      Limb currLimb = this.allLimbs.get(i);
      
      if (currLimb.clicked){
        
        PVector jointAndNewMouse = PVector.sub(new PVector(mouseX,mouseY),allJoints.get(clickedJointIndex).coords);
        //direction vector from mouse to the selected joint
        
        float newMouseAngle=PVector.angleBetween(new PVector(1,0),PVector.sub(new PVector(mouseX,mouseY),allJoints.get(clickedJointIndex).coords));
        //need angle from limb to x axis then can do simple subtractions.
        
        
        
        float deltaAngle;
        //
 
       
       
        //if in top two quadrants flip the angle to go the other way, angle between two vectors is always <=180
        if (jointAndNewMouse.x<0 && jointAndNewMouse.y<0 || (jointAndNewMouse.x>0&&jointAndNewMouse.y<0)){

          deltaAngle=oldMouseAngle-newMouseAngle;
          
        }
        else{
          deltaAngle=newMouseAngle-oldMouseAngle;
        }
        
        for (Limb limb:allLimbs){
         
          if (allLimbs.indexOf(limb)>=clickedJointIndex){
            //finds angle to axis of direction vector of point if limb is below the joint
            float angleToAxis=PVector.angleBetween(new PVector(1,0),PVector.sub(limb.bottomCoord,allJoints.get(clickedJointIndex).coords));
            float topAngleToAxis = PVector.angleBetween(new PVector(1,0),PVector.sub(limb.topCoord,allJoints.get(clickedJointIndex).coords));
            if (limb.bottomCoord.y<allJoints.get(clickedJointIndex).coords.y){
              angleToAxis*=-1;
              //flips if point is above (smaller y value) than joint
            }
            
            if (limb.topCoord.y<allJoints.get(clickedJointIndex).coords.y){
              topAngleToAxis*=-1;
            }
            
            //finds rotated coordinates
            PVector rotatedCoords = findEOL(allJoints.get(clickedJointIndex),limb.bottomCoord,angleToAxis+deltaAngle); //because each index of limb matches index of joint above
            PVector rotatedCoords1 = findEOL (allJoints.get(clickedJointIndex),limb.topCoord,topAngleToAxis+deltaAngle);//topAngleToAxis+deltaAngle
            
            
            limb.bottomCoord.x=rotatedCoords.x;
            limb.bottomCoord.y=rotatedCoords.y;
            limb.topCoord.set(rotatedCoords1);
          }
        }
      }
    }
  }
  
  //sets new joint pos
  void updateJoints(){
    for (Joint j: allJoints){
      j.coords=allLimbs.get(allJoints.indexOf(j)).topCoord;
      
    }
  }
  
  
}
