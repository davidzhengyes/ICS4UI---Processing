class ComplexNumber {
  //FIELDS
  float realPart; //a    Why not int?
  float imagPart; //b
  
  //CONSTRUCTOR
  ComplexNumber( float rp, float ip ) {
    this.realPart = rp;
    this.imagPart = ip;
  }
  
  //METHODS
  void printMe() {
    println( this.realPart + "+" + this.imagPart + "i" );  //For now this is fine.
  }
  
  
  float absoluteValue() {  // |z| = sqrt(a^2 + b^2)
    return sqrt( pow(this.realPart,2) + pow(this.imagPart,2) ) ;
  }
  
  
  float absoluteValueSquared() {  // |z| = sqrt(a^2 + b^2)
    return pow(this.realPart,2) + pow(this.imagPart,2);
  }
  
  ComplexNumber add( ComplexNumber other ) {
    float newReal = this.realPart + other.realPart;
    float newImag = this.imagPart + other.imagPart;
    
    ComplexNumber newCN = new ComplexNumber(newReal, newImag);
    
    return newCN;
  }
  
  
  //a = this.realPart
  //b = this.imagPart
  //c = other.realPart
  //d = other.imagPart
  //ac-bd
  //ad+bc
  
  ComplexNumber multiply( ComplexNumber other ) {
    float newRealPart = this.realPart*other.realPart - this.imagPart*other.imagPart;
    float newImagPart =  this.realPart*other.imagPart + this.imagPart*other.realPart;
    
    ComplexNumber answer = new ComplexNumber( newRealPart, newImagPart);    
    
    return answer;
  }
  
  
  

  
}
