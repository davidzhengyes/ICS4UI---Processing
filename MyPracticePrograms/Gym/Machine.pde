class Machine{
  
  
  String name;
  Meathead meathead;
  int exhaustionFactor;
  int weight;
  int dirtiness;
  
  
  Machine(String n, int e, int w, int d){
    this.name = n;
    this.exhaustionFactor = e;
    this.weight = w;
    this.dirtiness = d;
    this.meathead = null;
  }
  
  boolean isOccupied(){
    if (this.meathead!=null){
      return true;
    }
    else{
      return false;
    }
  }
  
  
}
