void copyNextGenerationToCurrentGeneration() {
  for (int i=0; i<n; i++) 
    for (int j=0; j<n; j++) 
      cells[i][j] = cellsNext[i][j];
}


int countAdjacentCod(int i, int j) {
  int count = 0;

  for (int a = -1; a <= 1; a++) {  
    for (int b = -1; b <= 1; b++) {  

      try {
        if (cells[i+a][j+b] == gray && !(a==0 && b==0))
          count++;
      }

      catch( IndexOutOfBoundsException e ) {
      }
    }
  }

  return count;
}
