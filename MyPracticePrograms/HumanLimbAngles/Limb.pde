class Limb{
  int tX,tY,bX,bY;
  PVector topCoord,bottomCoord;
  String type;
  boolean clicked;
  float slope;
  Joint superiorJoint;
  
  Limb(String t,int topX,int topY,int bottomX,int bottomY){
    this.type=t;
    this.tX=topX;
    this.tY=topY;
    this.bX=bottomX;
    this.bY=bottomY;
    
    this.topCoord= new PVector(topX,topY);
    this.bottomCoord=new PVector(bottomX,bottomY);
    
    this.assignOrder();
    //somehow assign this automatically depending on type
    //if (this.type.equals("Tibia")){
    //  this.superiorJoint = bob.leftKnee;
    //}
    //else{
    //  this.superiorJoint=bob.leftHip;
    //}
  }
  
  void assignOrder(){
    this.superiorJoint=testJoint;
  }
  
  
}
