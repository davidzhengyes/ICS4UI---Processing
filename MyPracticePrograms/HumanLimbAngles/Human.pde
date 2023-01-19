class Human{
  Joint leftHip;
  Limb leftFemur;
  Joint leftKnee;
  Limb leftTibia;
  
  ArrayList<Limb> allLimbs = new ArrayList<Limb>();
  ArrayList<Joint> allJoints = new ArrayList<Joint>();
  
  String name;
  
  Human(String n){
    this.name=n;
    
    this.leftHip=new Joint("Hip", 300,300);
    this.leftFemur=new Limb ("Femur", 300,300,300,400);
    this.leftKnee = new Joint ("Knee", 300,400);
    this.leftTibia = new Limb ("Tibia", 300,400,300,490);
    allLimbs.add(leftFemur);
    allLimbs.add(leftTibia);
    allJoints.add(leftHip);
    allJoints.add(leftKnee);
  }
  
  
  
  void display(){
    
    for (int i=0; i<allLimbs.size(); i++){
      Limb currLimb = allLimbs.get(i);
      strokeWeight(15);
      stroke(255);
      line(currLimb.tX,currLimb.tY,currLimb.bX,currLimb.bY);
    }
    
    for (int i=0; i<allJoints.size(); i++){
      Joint currJoint = allJoints.get(i);
      strokeWeight(15);
      stroke(0,0,255);
      point(currJoint.jointX,currJoint.jointY);
    }
  }
  
  
  
}
