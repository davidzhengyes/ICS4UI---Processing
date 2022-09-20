void plantFirstGen()  {
  for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
         int r = int(random( minBrightness, 255 )); 
         int g = int(random( minBrightness, 255 )); 
         int b = int(random( minBrightness, 255 )); 
         
         if ( greyScale )
           cells[i][j] = color(r,r,r);
           
         else
           cells[i][j] = color(r,g,b);
      } 
  }
}
                    

void copyNextGenToCurrentGen() {
    for(int i=0; i<n; i++) 
      for(int j=0; j<n; j++) 
        cells[i][j] = cellsNext[i][j];
}
