void setup() {        
   int[] a = {4, 7, 10, 13, 16}; //already sorted
   int[] b = {1, 2,  8, 11, 12}; //already sorted
   
   int[] c = merge( a, b );  //should merge the arrays a and b into a single sorted array c
   
   printArray( c ); //should print out 1, 2, 4, 7, 8, 10, 11, 12, 13, 16
}
    
    

int[] merge( int[] a, int[] b ) {
  int[] c = new int[ a.length+b.length ]; //what size should c be?
  
  
  int i = 0;   //i is the current index for a
  int j = 0;   //j is the current index for b 
  int k = 0;   //k is the current index for c
  
  //CODE THE REST
  while(k<c.length){
    
    if (i<a.length && j<b.length){

      if (a[i]<b[j]){
        c[k]=a[i];
        i++;
      }
      else if (j<b.length){
        c[k]=b[j];
        j++;
      }
    }
    
    if (i==a.length){
      for (int q=j; q<b.length;q++){
        c[q+a.length]=b[q];
      }
      
      break;
    }
    if (j==b.length){
      
      for (int q=i; q<a.length;q++){
        c[q+b.length]=a[q];
      }
      
      break;
    }
 
    k++;
  }
    
  return c;
}
    
    
int [] mergeSort(int[] a, int min,int max){
  if(min==max){
    int[] arrayOne = {a[min]};
    return arrayOne;
  }
  
  else{
    int middle=(min+max)/2;
    
    int[]
    
  }
}
    
