int[] a = {5, 9, 3, 10};


void printArrayAtIndexUNSAFE( int i ) {
  println("The value at index " + i + " is " + a[i] );
}


void setup() {
  printArrayAtIndexUNSAFE( 3 );  //Okay
  printArrayAtIndexUNSAFE( 0 );  //Okay
  printArrayAtIndexUNSAFE( -1 ); //Error!!! This index does not exist
  printArrayAtIndexUNSAFE( 10 );  //Error!!! This index does not exist
  
  exit();
}
