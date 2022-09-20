void setup() {
  String a = "3.15x10^4";        //that’s 31,500
  String b = "4.0000x10^3";      //that’s 4,000

  String aTimesb = multiplyInScientificNotation(a, b); 
  println( aTimesb );
}

String multiplyInScientificNotation(String a, String b) {
  //GET THE COEFFICIENT AND EXPONENT OF STRING A
  int aTimesIndex = a.indexOf("x");             //4 (the index at which "x" occurs in String a)
  String aCoeff = a.substring(0, aTimesIndex);  //"3.15"
  float aCoeffNum = float(aCoeff);              //the coefficient 3.15
  String aExp = a.substring(aTimesIndex+4);     //"4"
  int aExpNum = int(aExp);                      //the exponent 4
  
  //GET THE COEFFICIENT AND EXPONENT OF STRING B
  int bTimesIndex = b.indexOf("x");             //6
  String bCoeff = b.substring(0, bTimesIndex);  //"4.0000"
  float bCoeffNum = float(bCoeff);              //the coefficient 4.0000 
  String bExp = b.substring(bTimesIndex+4);     //"3"
  int bExpNum = int(bExp);                      //the exponent 3
  
  //DO THE CALCULATIONS
  float prod = aCoeffNum * bCoeffNum;  //12.6...since this is bigger than 10, we'll have to reduce it to 1.26 later...see below
  int exp = aExpNum + bExpNum;         //3 + 4 = 7
  
  //If the final coefficient is 10 or more, 
  //then divide it by 10 and increase the exponent by 1 repeatedly
  //until the coefficient is less than 10
  while ( prod >= 10.0 ) {
      prod = prod / 10;
      exp++;
  }
  
  return str(prod) + "x10^" + str(exp);
}
