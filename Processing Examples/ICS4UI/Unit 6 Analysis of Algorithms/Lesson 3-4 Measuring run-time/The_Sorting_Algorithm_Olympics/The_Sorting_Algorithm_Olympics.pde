long numBubbleSortComparisons, numInsertionSortComparisons, numSelectionSortComparisons, numMergeSortComparisons;
long startTime, elapsedTime;

int n = 100;  //ARRAY SIZE
boolean printArrays = true;


void setup() {
  int[] a, aCopy1, aCopy2, aCopy3;

  if (n < 50) 
    printArrays = true;
    
  else
    printArrays = false;

  //MAKES A RANDOM ARRAY OF LENGTH n
  a = new int[ n ];
  
  for ( int i = 0; i < a.length; i++ )  
    a[ i ] = int(random( n*5 ));      

  //MAKES 3 COPIES OF THE ORIGINAL ARRAY
  aCopy1 = a.clone();
  aCopy2 = a.clone();
  aCopy3 = a.clone();

  //PRINTS THE ORIGINAL ARRAY
  if (printArrays) {
    println("The original array");
    printArrayInline( a ); 
    println("");
  }

  //SORTS THE ARRAY USING 3 DIFFERENT ALGORITHMS AND RECORDS THE # OF COMPARISONS AND THE CPU TIME EACH ALGORITHM TOOK
  testMergeSort( a );
  testInsertionSort( aCopy1 );      
  testBubbleSort( aCopy2 );
  //testSelectionSort( aCopy3 );
  
  exit();
}


void swap( int[] a, int x, int y ) {
  int temp = a[x];
  a[x] = a[y];
  a[y] = temp;
}


int[] bubbleSort( int[] a ) {
  int n = a.length;

  for ( int pass = 1; pass <= n-1; pass++ ) {
    for ( int i = 0; i <= n-pass-1; i++ ) {

      if ( a[i] > a[i + 1] ) 
        swap( a, i, i+1 );

      numBubbleSortComparisons++;
    }
  }
  return a;
}


int[] insertionSort( int[] a ) {
  int n = a.length;

  for ( int h = 1; h < n; h++ ) {

    int c = h; 

    while ( c > 0 && a[c-1] > a[c] ) {
      swap( a, c, c-1 );
      c--;

      numInsertionSortComparisons++;
    }
  }
  
  return a;
}


int[] selectionSort( int[] a ) {
  int n = a.length;

  for (int i = 0; i < n; i++) {

    int indexOfMin = i;

    for ( int j = i+1; j < n; j++ ) {
      if ( a[ j ] < a[ indexOfMin ] ) 
        indexOfMin = j; 

      numSelectionSortComparisons++;
    }

    swap( a, i, indexOfMin );
  }
  
  return a;
}


int[] mergeSort(int[] array, int start, int end ) {
  if (start == end) {  
    int[] arrayWithOneElement = { array[start] };
    return arrayWithOneElement;
  } 
  
  else {
    int middle = (end + start) / 2;

    int[] sortedLeftHalf = mergeSort(array, start, middle);         // recursive call
    int[] sortedRightHalf = mergeSort(array, middle + 1, end);      // recursive call

    return mergeTwoSortedLists( sortedLeftHalf, sortedRightHalf );  // merge the two sorted halves
  }
}


int[] mergeTwoSortedLists(int[] a, int[] b) {
  int[] c = new int[a.length + b.length];
  int i = 0;
  int j = 0;
  int k = 0;

  int lenA = a.length, lenB = b.length;

  while ( i < lenA && j < lenB ) {

    if ( a[i] <= b[j] ) {
      c[k] = a[i];
      i++;
    } 
    else {
      c[k] = b[j];
      j++;
    }

    k++;
    numMergeSortComparisons += 3;
  }

  if ( i == lenA ) 
    for (int m = j; m < b.length; m++) {
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


void printArrayInline(int[] a) {
  for (int i = 0; i < n; i++) 
    print(a[i] + " ");

  println("");
}


void testBubbleSort(int[] aCopy) {
  print( "Bubble sort made..." );
  startTime = millis();

  int[] aSorted = bubbleSort( aCopy );
  elapsedTime = millis() - startTime; //the time bubblesort took

  if( printArrays) 
    printArrayInline( aSorted ); 
    
  println( numBubbleSortComparisons + " comparisons and took " + elapsedTime + " milliseconds" + "\n");
}


void testInsertionSort(int[] aCopy) {
  print( "Insertion sort made..." );
  startTime = millis();

  int[] aSorted = insertionSort( aCopy );
  elapsedTime = millis() - startTime; //the time bubblesort took

  if( printArrays) 
    printArrayInline( aSorted ); 
    
  println( numInsertionSortComparisons + " comparisons and took " + elapsedTime + " milliseconds" + "\n");
}


void testSelectionSort(int[] aCopy) {
  startTime = millis();

  int[] aSorted = selectionSort( aCopy );
  elapsedTime = millis() - startTime; //the time bubblesort took

  if( printArrays) 
    printArrayInline( aSorted ); 
    
  println( "Selection sort made " + numSelectionSortComparisons + " comparisons and took " + elapsedTime + " milliseconds" + "\n");
}


void testMergeSort(int[] aCopy) {
  print( "Merge sort made..." );
  startTime = millis();

  int[] aSorted = mergeSort( aCopy, 0, n-1 );
  elapsedTime = millis() - startTime; //the time bubblesort took

  if( printArrays) 
    printArrayInline( aSorted ); 
    
  println( numMergeSortComparisons + " comparisons and took " + elapsedTime + " milliseconds" + "\n");
}
