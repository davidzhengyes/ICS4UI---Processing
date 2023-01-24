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
  
  
  
  void display(){
    
    for (int i=0; i<allLimbs.size(); i++){
      Limb currLimb = allLimbs.get(i);
      strokeWeight(15);
      stroke(255);
      line(currLimb.topCoord.x,currLimb.topCoord.y,currLimb.bottomCoord.x,currLimb.bottomCoord.y);
    }
    
    for (int i=0; i<allJoints.size(); i++){
      Joint currJoint = allJoints.get(i);
      strokeWeight(15);
      if (currJoint.locked){
        stroke(0,0,255);
      }
      else{
        stroke(0,255,0);
      }
      point(currJoint.jointX,currJoint.jointY);
    }
  }
  
  void update(){
    //check which limb if any is clicked
        
    for (int i=0; i<this.allLimbs.size(); i++) {
      Limb currLimb = this.allLimbs.get(i);
      
      if (currLimb.clicked){
        
        
        PVector rotatedCoords = findEOL(bob.allJoints.get(bob.allLimbs.indexOf(currLimb))); //because each index of limb matches index of joint above
       
        
        currLimb.bottomCoord.x=rotatedCoords.x;
        currLimb.bottomCoord.y=rotatedCoords.y;
      }
    }
  }
  
  
  
}
