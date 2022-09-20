void moveGas(int ind, int jnd) {
  // Random chance to move in any 4 directions
  int chance = int(random(0,4));
  // Will move in chosen direction unless already high carbon dioxide content or is out of bounds
  if(chance == 0) {
    if(ind+1 >= n) {
    } else if(!carbonNext[ind+1][jnd]) {
      carbonNext[ind+1][jnd] = true;
      carbonNext[ind][jnd] = false;
    }
  } else if(chance == 1) {
    if(ind-1 < 0) {
    } else if(!carbonNext[ind-1][jnd]) {
      carbonNext[ind-1][jnd] = true;
      carbonNext[ind][jnd] = false;
    }
  } else if(chance == 2) {
    if(jnd+1 >= n) {
    } else if(!carbonNext[ind][jnd+1]) {
      carbonNext[ind][jnd+1] = true;
      carbonNext[ind][jnd] = false;
    }
  } else if(chance == 3) {
    if(jnd-1 < 0) {
    } else if(!carbonNext[ind][jnd-1]) {
      carbonNext[ind][jnd-1] = true;
      carbonNext[ind][jnd] = false;
    }
  }
}
