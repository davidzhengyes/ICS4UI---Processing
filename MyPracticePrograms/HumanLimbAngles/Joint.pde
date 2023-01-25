class Joint{
  
  String type;
  Boolean locked;
  
  PVector coords;
  
  Joint(String t, int jX,int jY){
    this.type=t;
    
    this.coords=new PVector(jX,jY);
    this.locked=true;
    
    
  }
  
  
  
  
  
  
}
