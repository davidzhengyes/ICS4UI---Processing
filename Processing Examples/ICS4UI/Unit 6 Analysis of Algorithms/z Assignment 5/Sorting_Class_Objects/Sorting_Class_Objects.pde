void setup() {
  
 
  //TESTING MERGE SORT
  Point2D[] p = new Point2D[10];
  
  for(int i = 0; i<p.length; i++) {
    int x = (int) random(0,50);
    int y = (int) random(0,50);
    p[i] = new Point2D(x,y);
  }
  
  Point2D[] pSorted = mergeSort( p, 0, p.length-1 );    
  
  for(int i = 0; i < p.length; i++) {
    pSorted[i].printMe();
  }
}


Point2D[] mergeSort(Point2D[] a, int start, int end ) {
  if ( start == end ) {  
    Point2D[] arrayWithOneElement = { a[start] };
    return arrayWithOneElement;
  } 
  
  else {
    int middle = (end + start) / 2;  //finds the middle index between start and end

    Point2D[] sortedLeftHalf  = mergeSort( a, start, middle );     // recursive function-call
    Point2D[] sortedRightHalf = mergeSort( a, middle + 1, end );   // recursive function-call

    return merge( sortedLeftHalf, sortedRightHalf ); 
  }
}


Point2D[] merge( Point2D[] a, Point2D[] b ) {
  Point2D[] c = new Point2D[a.length + b.length];
  int i = 0;
  int j = 0;
  int k = 0;

  while ( i < a.length && j < b.length ) { 

    if ( a[i].x <= b[j].x ) {  
      c[k] = a[i]; 
      i++;         
    } 
    
    else {
      c[k] = b[j];  
      j++;         
    }

    k++;  
  }

  
  if ( i == a.length ) 
    for ( int m = j; m < b.length; m++ ) {  
      c[k] = b[m];
      k++;
    } 
    
  else 
    for (int m = i; m < a.length; m++) {  
      c[k] = a[m];
      k++;
    }

  return c;  
}
