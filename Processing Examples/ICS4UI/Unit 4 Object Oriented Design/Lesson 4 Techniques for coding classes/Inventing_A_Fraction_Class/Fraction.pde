static class Fraction {
    
  //FIELDS
  int numerator;
  int denominator; 
  String label;
  
      
  //CONSTRUCTOR 1
  Fraction( int n, int d ) {
    this.numerator = n;
    this.denominator = d;
    this.label = "";
  }
  
  
  //CONSTRUCTOR 2
  Fraction( int n, int d, String l ) {
    this.numerator = n;
    this.denominator = d;
    this.label = l;
  }
  
  //CONSTRUCTOR 3
  Fraction(float f,String l){
    if (str(f).indexOf(".")<0){
      this.numerator=int(f);
      this.denominator=1;
    }
    
    else{
      float tenFactor = pow(10,str(f).length()-str(f).indexOf(".")-1);
      this.numerator=int(f*tenFactor);
      this.denominator=int(tenFactor);
    }  
    
    this.label=l;
    this.reduce();
  }
  
  
  //ADD A 3rd CONSTRUCTOR THAT LETS THE USER CREATE A FRACTION FROM A DECIMAL. 
  //FOR EXAMPLE, Fraction f = new Fraction(0.375)  WOULD SET f TO 3/8.
  //HINT: MAKE USE OF THE reduce() METHOD AT THE END.
  

  //METHODS
  void display() {         
    String printedFrac = this.numerator + "/" + this.denominator; //IMPROVE THIS SO THAT ONLY THE NUMERATOR GETS PRINTED IF THE DENOMINATOR = 1
    
    if ( this.label.equals("") )
        println( printedFrac );
    
    else
        println( this.label + " = " + printedFrac );   
  }
  
  
  void reduce() {
    int gcd = getGCD( this.numerator, this.denominator );
    
    this.numerator /= gcd;
    this.denominator /= gcd;       
  }
  
  
  float toDecimal() {
    return float(this.numerator)/this.denominator; //casting to float is needed to prevent Processing from dropping the decimal
  }
  
  
  //USED FOR SETTING THE LABEL OF FRACTIONS THAT WERE CREATED BY ADDING OR MULTIPLYING OTHER FRACTIONS, INSTEAD OF A CALL TO A CONSTUCTOR. 
  void setLabel( String name ) {
    this.label = name;
  }
  
  
  //METHODS THAT RETURN A NEW FRACTION OBJECT
  Fraction reciprocal() {
    Fraction recip = new Fraction( this.denominator, this.numerator );
    recip.label = "1 / " + this.label;
    return recip;
  }
  
  
  Fraction multiply( Fraction other ) {
   int newNumer = this.numerator * other.numerator;
   int newDenom = this.denominator * other.denominator;
  
   Fraction answer = new Fraction( newNumer, newDenom );
   
   answer.label = this.label + " x " + other.label;
   
   return answer;
  }
  
  
  Fraction multiplyByInteger( int i ) {
    int newNumerator = this.numerator * i;
    
    return new Fraction( newNumerator, denominator);
  }
  
  //The following 4 methods are "static". 
  //This means that the user doesn't have to create a new Fraction object to use them.
  //Static methods are just "helper methods" that don't require information about any particular Fraction object.
  //To call a static method inside setup, you use <CLASS NAME>.<METHOD NAME> instead of <OBJECT VARIABLE NAME>.<METHOD NAME>  
  //For example, Fraction.decimalToFraction(0.33)
  static int getGCD(int a, int b) {
    int max, min, rem;
    
    max = Math.max(a, b);
    min = Math.min(a, b);
    
    rem = max % min;
    
    while (rem > 0) {
        max = min;
        min = rem;
        rem = max % min;
    }
    
    return min;
  }
  
  
  static int getLCM(int a, int b) {
    
    return a*b/getGCD(a,b);
  }
  
  
  static Fraction decimalToFraction( float d ) {
    float numerator = d;
    int denominator = 1;
    
    while ( ! isWholeNumber(numerator) ) {
        numerator *= 10;
        denominator *= 10;
    } 
    
    int numer = (int) numerator;
    
    Fraction f = new Fraction(numer, denominator);
    f.reduce();
    
    return f;
    
  }
  
  //This method is "private" because it's only needed by other methods in the class, and not by setup().
  //The user has no access to it from setup().
  private static boolean isWholeNumber( float d ) {
      return d == round(d);
  }
  
  Fraction power(int p){
    return new Fraction (int(pow(this.numerator,p)),int(pow(this.denominator,p)),this.label+"^"+str(p));
    
  }
  
  Fraction addTo(Fraction f){
    int newDen=getLCM(f.denominator,this.denominator);
    int thisNum = int(float(newDen)/this.denominator*this.numerator);
    int fNum = int(float(newDen)/f.denominator*f.numerator);
    
    return new Fraction(thisNum+fNum,newDen,f.label + "+" +this.label);
  }
  
} //END OF FRACTION CLASS
