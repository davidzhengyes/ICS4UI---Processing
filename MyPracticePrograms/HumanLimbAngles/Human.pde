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
    this.leftTibia = new Limb ("Tibia", 300,400,400,490);
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
        //currLimb.bX=mouseX;
        //currLimb.bY=mouseY;
        
        //maybe make another function to rotate limb later
        PVector a = new PVector (this.leftTibia.topCoord.x,this.leftTibia.topCoord.y);
        PVector b = new PVector (mouseX,mouseY);
        b.sub(a);  
        b.setMag(100);
        a.add(b);
        
        println(a.x,a.y);
       
        
        currLimb.bottomCoord.x=a.x;
        currLimb.bottomCoord.y=a.y;
      }
    }
  }
  
  
  
}
