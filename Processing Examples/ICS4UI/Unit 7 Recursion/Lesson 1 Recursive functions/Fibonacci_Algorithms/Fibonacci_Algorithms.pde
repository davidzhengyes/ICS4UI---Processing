long numAdditions = 0;

long dumbFib(int n) {
  if ( n==1 || n==0 ) 
    return 1;

  else {
    numAdditions++;
    return dumbFib(n-1) + dumbFib(n-2);
  }
}


void testDumbFibonacciAlgorithm( int range ) {
  for (int i = 0; i <= range; i++) {
    print( "Fibonacci number " + i + " is...");
    println( dumbFib(i) + "\t\t\t Additions performed: " + numAdditions );
    numAdditions = 0;
  }
}


void setup(){
  int range = 40;
          
  //testSmartFibonacciAlgorithm( range );        
  testDumbFibonacciAlgorithm( range );
  
  exit();
}
