
void setup(){
  int[] aa = {2,4,-35223476,33,44,26,72,34,67,13};
  aa=bubbleSort(aa);
  printArrayOnOneLine(aa);
}


void printArrayOnOneLine(int[] a){
  for (int i=0;i<a.length;i++){
    print(str(a[i])+" ");  
  }
}

int[] bubbleSort(int[] a){
  
  int n=a.length;
  
  for(int p=1; p<n; p++){
    for (int i=0; i<n-p;i++){
      if (a[i]>a[i+1]){
        int xd = a[i];
        a[i]=a[i+1];
        a[i+1]=xd;
        
      }
      
    }
    
  }
  return a;
}
