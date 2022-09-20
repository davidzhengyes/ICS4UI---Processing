// measurement class
static class Measurement {
  // fields
  int whole;
  int numerator;
  int denominator; 
  String decimal;
  String type;
  boolean ismixed;
  
  
  // constructors
  Measurement(int n, int d, String t) {
    this.whole = 0;
    this.numerator = n;
    this.denominator = d;
    this.type = t;
  }
  
  // this constructor automatically converts a given mixed fraction to an improper fraction 
  Measurement(int w, int n, int d, String t) {
    this.whole = 0;
    this.numerator = n + w*d;
    this.denominator = d;
    this.type = t;
  }
  
  // this contructor leaves the mixed fraction alone as long as it has a boolean value at the end of its fields
  Measurement(int w, int n, int d, String t, boolean im) {
    this.whole = w;
    this.numerator = n;
    this.denominator = d;
    this.type = t;
    this.ismixed = im;
  }
  
  
  Measurement(int w, String t) {
    this.whole = 0;
    this.numerator = w;
    this.denominator = 1;
    this.type = t;
  }

  
  // converts the measurement as a displayable string
  String display() {    
    String result;
    
    if (this.whole == 0) {
      if (this.denominator == 1) {
        result = str(this.numerator);
      }
      
      else {
        result = this.numerator + "/" + this.denominator; //IMPROVE THIS SO THAT ONLY THE NUMERATOR GETS PRINTED IF THE DENOMINATOR = 1 
      }
  
    }
    
    else {
      if (this.numerator == 0) {
        result = str(this.whole);
      }      
      
      else {
        result = this.whole + " " + this.numerator + "/" + this.denominator;    
      }
    }
    
    if (this.type != "") {
      result += " " + this.type;
    
    }
    
    return result;
  }
  

  // converts the measurement to a mixed fraction
  Measurement convertwhole() {
    this.reduce();

    this.whole = int(float(this.numerator) / this.denominator);
    
    if (this.whole > 1 && this.type != "") {
      this.type += "s";
    }
    
    this.numerator = this.numerator % this.denominator;
    
    return new Measurement (this.whole, this.numerator, this.denominator, this.type, true);
  
  }
  
  
  // rounds the measurement to the nearest 1/4
  Measurement roundtoquarter() {
    float decimal = this.todecimal();
    
    // for values that are super small (less than or equal to 1/8), it rounds it to 1/8 of a tsp 
    if (decimal <= 0.125 && this.type.equals("tsp")) {
      return new Measurement (1, 8, this.type);
    }
    
    // for objects, it rounds it to 1/8 of an object if the value is small (less than or equal to 1/8)
    else if (decimal <= 0.125 && this.type.equals("")) {
      return new Measurement (1, 8, this.type);    
    
    }
    
    decimal *= 4;
    
    decimal = round(decimal);
    
    decimal /= 4;
    
    this.whole = 0;
    this.numerator = int(decimal) * 4 + int((decimal - int(decimal))/.25);
    this.denominator = 4;

    return new Measurement (this.whole, this.numerator, this.denominator, this.type);
  }
  
  
  // changes the measurement to teaspoons
  Measurement changetotea() {
    Measurement m = this;
    if (this.type.equals("tbsp")) {
      m = multiplybyscalar(3);
    
    }
    
    else if (this.type.equals("cup")) {
      m = multiplybyscalar(48);
    
    }
    

    m.reduce();
    m.type = "tsp";
    return m;
  
  }
  
  
  // changes the measurement to tablespoons
  Measurement changetotable() {
    Measurement m = this;
    if (this.type.equals("tsp")) {
      m = dividebyscalar(3);
    
    }
    
    else if (this.type.equals("cup")) {
      m = multiplybyscalar(16);
    
    }
    

    m.reduce();
    m.type = "tbsp";
    return m;
  
  }
  
  
  // changes the measurement to cups
  Measurement changetocup() {
    Measurement m = this;
    if (this.type.equals("tbsp")) {
      m = dividebyscalar(16);
    
    }
    
    else if (this.type.equals("tsp")) {
      m = dividebyscalar(48);
    
    }
    

    m.reduce();
    m.type = "cup";
    
    return m;
  
  }
  
  
  // converts teaspoons to any other unit of measurement if necessary
  Measurement convert() {
    Measurement m = this;
    float decimal = this.todecimal();
    this.type = "tsp";
    
    if (decimal >= 12) {
      m = this.changetocup();
    } 
    
    else if (decimal >= 3) {
      m = this.changetotable();
    }
    

    return m;
    
  }
  
  
  // reduces the measurement fraction
  void reduce() {
    int gcd = getGCD(this.numerator, this.denominator);
    
    this.numerator /= gcd;
    this.denominator /= gcd;       
  }
  
  
  // changes the measurement to a decimal
  float todecimal() {
    return float(this.numerator)/this.denominator; 
  }
  
  
  // multiplies two measurements
  Measurement multiply(Measurement newm) {
   int newNum = this.numerator * newm.numerator;
   int newDe = this.denominator * newm.denominator;
  
   Measurement answer = new Measurement( newNum, newDe, this.type  );
   
   return answer;
  }
  
  //multiplies a measurement by a scalar (a number that's not a fraction)
  Measurement multiplybyscalar( int i ) {
    int newNum = this.numerator * i;
    
    return new Measurement( newNum, denominator, this.type );
  }
  
  // divides a measurement by a scalar
  Measurement dividebyscalar( int i ) {
    int newDe = this.denominator * i;
    
    return new Measurement( numerator, newDe, this.type );
  }

  // returns the gcd of two integers --> for the reduce() function
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
  
} 
