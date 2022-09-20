//This page is for setting up the beggining 

void setGround(){
  for(int i=5;i<n;i++){
  cells[n-1][i]= ground;
  
  }
  for(int i=6;i<n;i++){
    cells[n-2][i]= ground;
  }
  for(int i=7;i<n;i++){
    cells[n-3][i]= ground;
  }
  for(int i=11;i<n;i++){
    cells[n-4][i]= ground;
  }
  for(int i=13;i<n;i++){
    cells[n-5][i]= ground;
  }
  for(int i=14;i<17;i++){
    cells[n-6][i]= ground;
  }
 

}

void setSky(){
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      cells[i][j]=sky;

    }
  }
}

void setSea(){
  for(int i=0;i<5;i++){
  cells[n-1][i]= Sea;
  }
  for(int i=0;i<6;i++){
  cells[n-2][i]= Sea;
  }
  for(int i=0;i<7;i++){
  cells[n-3][i]= Sea;
  }
  

}

void setLake(){
  for(int i=15;i<n;i++){
    cells[n-7][i]= Lake;
  }
  for(int i=17;i<n;i++){
    cells[n-6][i]= Lake;
  }
}

void setCloud(){
  cells[3][1]= cloud;
  cells[3][2]= cloud;
  cells[3][3]= cloud;
  cells[3][4]= cloud;

}

void setStart(){
  setSky();
  setGround();
  setSea();
  setLake();
  setCloud();
}
