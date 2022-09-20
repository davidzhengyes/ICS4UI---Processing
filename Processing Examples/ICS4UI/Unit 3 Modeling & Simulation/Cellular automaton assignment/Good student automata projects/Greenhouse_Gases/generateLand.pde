void generateLand() {
  boolean breakLoop = false;
  int chance;
  int whichPond = 0;
  int checkedLand = 0;
  int[] pondSizes = new int[pondNum];
  // Creating array of random pond sizes for each pond
  for(int i = 0; i < pondNum; i++) {
    pondSizes[i] = int(random(pondSmall,pondBig+1));
  }
  // Finds random location for each pond, and makes sure the entire pond fits
  for(int i = 0; i < n-pondSizes[whichPond]+1; i++) {
    for(int j = 0; j < n-pondSizes[whichPond]+1; j++) {
      chance = int(random(0,(n-pondSizes[whichPond]+1)*(n-pondSizes[whichPond]+1-i)-j));
      if(chance < 1) {
        for(int k = 0; k < pondSizes[whichPond]; k++) {
          for(int l = 0; l < pondSizes[whichPond]; l++) {
            if(i+k >= n || j+l >= n) {
              continue;
            }
            if(water[i+k][j+l]) {
              totalWater--;
            }
            water[i+k][j+l] = true;
            totalWater++;
          }
        }
        whichPond++;
        i = 0;
        j = 0;
        if(whichPond == pondNum) {
          breakLoop = true;
          break;
        }
      }
    }
    if(breakLoop) {
      break;
    }
  }
  // If there not enough land left for power plants and trees
  if(n*n < powerNum + treeNum + totalWater) {
    println("Warning, not enough tiles to accommodate all land");
  }
  // Randomly generate all power plants and trees with leftover land
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      if(water[i][j]) {
        continue;
      }
      chance = int(random(0,n*n-totalWater-checkedLand));
      if(chance < powerNum) {
        powerPlants[i][j] = true;
        powerNum--;
      } else if(chance < powerNum + treeNum) {
        trees[i][j] = true;
        treeNum--;
      }
      checkedLand++;
    }
  }
}
