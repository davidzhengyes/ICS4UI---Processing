void setup() {
  ComplexNumber z = new ComplexNumber(6, 8);       //6+8i
  ComplexNumber w = new ComplexNumber(-2.5, -7.9); //-2.5-7.9i
  ComplexNumber i = new ComplexNumber(0, 1);       //Just plain i
  
  z.printMe();    //should print "6+8i" to the screen
  w.printMe();   //should print "-2.5-7.9i"  ("-2.5+-7.9i" is okay for today, but eventually improve the code so that it prints the nicer way)
  i.printMe();    //should print just "i"  ("0+1i" is okay for today, but improve your code eventually)
  
  float absZ = z.absoluteValue();
  float absI = i.absoluteValue();

  println( absZ );   //should print 10.0
  println( absI );   //should print 1.0
  
  ComplexNumber zPlusW = z.add( w );
  zPlusW.printMe();
  
  ComplexNumber zw = z.multiply(w);
  zw.printMe();
  

}
