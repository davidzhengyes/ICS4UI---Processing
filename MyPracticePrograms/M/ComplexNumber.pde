class ComplexNum{
  float realPart;
  float imagPart;
  
  ComplexNum(float r, float i){
    this.realPart=r;
    this.imagPart=i;
  }
  
  void describe(){
    println(this.realPart,"+",this.imagPart+"i");
  }
  
  ComplexNum add(ComplexNum x){
    ComplexNum s = new ComplexNum(this.realPart+x.realPart,this.imagPart+x.imagPart);
    return s;
  }
  
  ComplexNum multiply (ComplexNum x){
    ComplexNum s = new ComplexNum(this.realPart*x.realPart-this.imagPart*x.imagPart,this.realPart*x.imagPart+this.imagPart*x.realPart);
    return s;
  }
  
}
