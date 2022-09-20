void setup() {
  size(600,600);
  background(0);
  
  //THERE ARE 3 WAYS TO DECLARE AN ARRAY
  
  //WAY 1: LIST ALL THE VALUES IN ADVANCE USING A { } LIST
  int[] a = {90, 83, 10, 70, 12, 6};
  
  //Printing the array
  printArray(a);
  
  //Printing its length
  println("Array a's length is " + a.length);
  
  //Changing the values using a loop
  for( int i=0 ; i < a.length; i++ ) {
     a[i] += 200;
  }
  
  //Reprinting
  println();
  printArray(a);
  
  //YOUR TURN 1: USE A LOOP TO PRINT THE ARRAY IN REVERSE ORDER. HINT: MAKE i GO 4, 3, 2, 1, 0
  for( int i = a.length-1; i >= 0; i-- ) {
     println(a[i]);
  }
  
  //YOUR TURN 2: FIND THE AVERAGE VALUE
  int sum = 0;
        
  for (int i = 0; i < a.length; i++)           
     sum += a[i];
        
  float avg = sum/a.length;
  println("Zack's average is " + avg);  
  
  
  //WAY 2: DECLARE THE SIZE IN ADVANCE BUT NOT THE VALUES...
  int[] x = new int[10];
  float[] y = new float[10];
  
  //...WITH THE INTENTION OF FILLING THE VALUES LATER IN THE PROGRAM
  for( int i = 0; i < 10; i++ ) {
    x[i] = 2*i;
    y[i] = 2*x[i]+5;
    
    text(x[i], 100, 15*i);
    text(y[i], 150, 15*i);
  }
  
    
  //WAY 3: DECLARE THE NAME BUT DON'T COMMIT TO THE SIZE YET
  float[] c;
  
  //Picking a random size;
  int n = (int) random(10,20); 
  
  //Completing the array declaration
  c = new float[n]; 
  
  //Filling the values randomly
  for( int i = 0; i < n; i++ ) 
    c[i] = random(0,1);
    
  printArray(c);
  
  exit();
}
