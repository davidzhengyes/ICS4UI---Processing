
void setup(){
  int[] aa = {2,4,-35223476,33,44,26,72,34,67,13};
  aa=newSort(aa);
  printArrayOnOneLine(aa);
  noLoop();
}


void printArrayOnOneLine(int[] a){
  for (int i=0;i<a.length;i++){
    print(str(a[i])+" ");  
  }
}

int[] newSort(int [] a){
  ArrayList<Integer> A = new ArrayList<Integer>();
  for (int i=0; i<a.length; i++){
    A.add(a[i]);
  }
  
  for (int i=0; i<a.length; i++){

    int minimum=A.get(0);
    int indexToDelete=0;
    for (int g=0; g<A.size(); g++){
      if (A.get(g)<minimum ){
        minimum=A.get(g);
        indexToDelete=g;
      }
    }

    a[i]=minimum;
    A.remove(indexToDelete);

  }
  return a;
}

int[] insertionSort(int[] a){
  int n=a.length;
  for (int h=0;h<n;h++){
    int c=h;   
    while (c>0 && a[c-1]>a[c]){
      int xd = a[c];
      a[c]=a[c-1];
      a[c-1]=xd;
      c--;
    }   
  }
  return a;
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
