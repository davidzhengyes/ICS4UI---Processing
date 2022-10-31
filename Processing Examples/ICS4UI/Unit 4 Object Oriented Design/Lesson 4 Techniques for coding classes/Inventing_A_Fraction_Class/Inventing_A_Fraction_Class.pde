void setup() {
  Fraction e = new Fraction( 1, 2 );  
  Fraction f = new Fraction( 5, 3, "f" );  
  Fraction g = new Fraction( 20, 80, "g" );
  
  println();

  //USING THE display() METHOD
  e.display();
  f.display();
  g.display();

  println();

  //USING THE reduce() METHOD
  g.reduce();
  g.display();

  println();
         
  //USING THE toDecimal() METHOD
  float fDecimal = f.toDecimal();
  float gDecimal = g.toDecimal();
  println( f.label + " is equivalent to " + fDecimal);
  println( g.label + " is equivalent to " + gDecimal);

  println();

  //USING METHODS THAT CREATE AND RETURN NEW FRACTION OBJECTS: reciprocal(), multiply(), add(), power()
  Fraction oneOverF = f.reciprocal(); 
  oneOverF.display();

  Fraction oneOverG = g.reciprocal();
  oneOverG.display();
  
  println();

  Fraction prodFG = f.multiply(g);
  prodFG.display();
  prodFG.reduce();
  prodFG.display();
  
  println();

  Fraction fSquared = f.multiply(f);
  fSquared.setLabel("f^2");
  fSquared.display();

  Fraction fCubed = fSquared.multiply(f); //COULD ALSO CALL f.power(3) ONCE YOU'VE CODED power()
  fCubed.setLabel("f^3");
  fCubed.display();
  
  float fCubedDecimal = fCubed.toDecimal();
  println("f^3 is equivalent to " + fCubedDecimal);

  println();

  //CODE THE power() METHOD
  Fraction fToTheFour = f.power(4);
  fToTheFour.setLabel("f^4");
  fToTheFour.display();
  
  Fraction j = new Fraction(0.375,"j");
 
  j.display();
  
  Fraction x = new Fraction(3, 4, "f");   
  Fraction d = new Fraction(1, 3, "g"); 
  Fraction xPlusd = x.addTo(d);
  xPlusd.display();
  //CODE THE add() METHOD
  //Fraction sumFG = f.add(g);
 // sumFG.setLabel("f + g");
  //sumFG.display();



  //USING STATIC METHODS OF THE FRACTION CLASS: getGCD AND getLCM
  //STATIC MEANS THAT THE METHOD DOESN'T WORK WITH ANY PARTICULAR FRACTION OBJECT.
  //THAT IS, THE METHOD BELONGS TO THE CLASS AS A WHOLE, AND NOT TO ANY PARTICULAR OBJECT OF THAT CLASS.
  //STATIC METHODS ARE CALLED INSIDE setup() USING THE SYNTAX Fraction.staticMethodName() INSTEAD OF f.methodName() WHERE f IS SOME FRACTION OBJECT

  int gcd = Fraction.getGCD(12, 15);
  int lcm = Fraction.getLCM(12, 15); //CODE THE getLCM() METHOD

}
