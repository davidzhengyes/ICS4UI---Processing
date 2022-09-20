//Global Variables 
int spawnRate = 50; //percent chance that someone enters in a frame - user can alternate this to see different restrictions of number of people who enter a store 
int aislesXY = 15; //amount of aisles in both directions - user can change this to see the layout of the store differently and the path of people

float cellSize;
int totalPeople;
int currentPeople;
int numProducts = 0;
int curProducts = 0;

//Direction Vectors
int[] up = {-1, 0};
int[] down = {1, 0};
int[] left = {0, -1};
int[] right = {0, 1};

int[][] allDirect = {up, down, left, right};
int[][] prodCoor;
int[][] getCoor;
int[] availableProducts;
int[][] peopleCoor;
int[][] spawnCoor;
int[] targets;
boolean[] gotten;
boolean[] done;

int[][] cells;

//Creating the layout of the store based on the number of aisles horizontally and vertically
int[][] createMap(int r, int c) {
  int[][] cells = new int[r * 4 + 3][c * 4 + 2]; 
  for (int i = 0; i < r * 4 + 3; i = i + 1) {
    if (i ==  r * 4 + 2) {
      continue;
    }
    for (int j = 0; j < c * 4 + 2; j = j + 1) {
    //When i and j are on the 3rd or 4th rotation, the cell is blue and it's value is 4, making it a product
      if ((i % 4 > 1) && (j % 4 > 1)) {
        cells[i][j] = 4;
        curProducts += 1;
        numProducts += 1;
      } 
    }
  }
  //Creating the exit 
  cells[r * 4 + 2][2] = 2;
  cells[r * 4 + 2][3] = 2;
  
  //Creating the entance
  cells[r * 4 + 2][c * 4 -1] = 3;
  cells[r * 4 + 2][c * 4 -2] = 3;
  return cells;
}

void setup() {
  size(700, 700);
  frameRate(10); //User can adjust rate of shoppers to see what maximizes efficency with the layout of the store they can also adjust
  cells = createMap(aislesXY, aislesXY);
  cellSize = ((725)/(aislesXY * 4 + 4));
  peopleCoor = new int[10000][2]; //A big value to store a lot of coordinates 
  targets = new int[10000];
  spawnCoor = new int[2][2];
  gotten = new boolean[10000];
  done = new boolean[10000];
  prodCoor = new int[numProducts + 2][2];
  getCoor = new int[numProducts + 2][2];
  availableProducts = new int[numProducts];
  initialize();
}

void draw() {
  float y = 0;
  for (int i=0; i<cells.length; i = i + 1) {
    for (int j=0; j<cells[0].length; j = j + 1) {
      float x = j*cellSize; //Creating the cell size according to the grid size 
      fill(squareColour(cells[i][j]));
      stroke(255);
      rect(x, y, cellSize, cellSize);
    }
    y = y + cellSize;
  }
  if (random(1) < spawnRate) { 
    spawnPerson();
  }
  run();
} 

void run() {
  for (int i = 0; i < currentPeople; i = i + 1) {
    if (done[i]) { //If the person has left the store
      continue;
    }
    
    if (gotten[i]) {
      //If the person is at the exit 
      if (getCoor[numProducts][0] - peopleCoor[i][0]  == 0 && abs(getCoor[numProducts][1] - peopleCoor[i][1]) == 1) {
        done[i] = true;
        cells[ peopleCoor[i][0]][ peopleCoor[i][1]] = 0;
        continue;
      }
      if (abs(getCoor[numProducts][0] - peopleCoor[i][0])  == 1 && getCoor[numProducts][1] - peopleCoor[i][1] == 0) {
        done[i] = true;
        cells[ peopleCoor[i][0]][ peopleCoor[i][1]] = 0;
        continue;
      }
      if (abs(getCoor[numProducts+1][0] - peopleCoor[i][0])  == 1 && getCoor[numProducts+1][1] - peopleCoor[i][1] == 0) {
        done[i] = true;
        cells[ peopleCoor[i][0]][ peopleCoor[i][1]] = 0;
        continue;
      }
      if (getCoor[numProducts+1][0] - peopleCoor[i][0]  == 0 && abs(getCoor[numProducts+1][1] - peopleCoor[i][1]) == 1) {
        done[i] = true;
        cells[ peopleCoor[i][0]][ peopleCoor[i][1]] = 0;
        continue;
      }
      
      targets[i] = getCoor.length-2; //Last 2 spots in numProducts are exit blocks
      
      if (random(1) < 0.5) { //Try to move side or up with a 50% chance 
        if (tryMoveSide(i)) {
          continue;
        }
        if (tryMoveUp(i)) {
          continue;
        }
      } 
      else {
        if (tryMoveUp(i)) {
          continue;
        }
        if (tryMoveSide(i)) {
          continue;
        }
      }
      
      for (int p = 0; p < 5; p = p + 1) {
       //Choose random direction to move in and make sure you are not getting blocked
        int index = int(random(4));
        
        try {
          if (move(peopleCoor[i], allDirect[index], i)) {
            break;
          }
        } 
        catch (Exception a ) {
        }
      }
      
    } 
    else {
      //Else, go for the product
      if (random(1) < 0.5) {
        if (tryMoveSide(i)) {
          continue;
        }
        if (tryMoveUp(i)) {
          continue;
        }
      } 
      else {
        if (tryMoveUp(i)) {
          continue;
        }
        if (tryMoveSide(i)) {
          continue;
        }
      }

      if (getCoor[targets[i]][0] - peopleCoor[i][0] == 0 && getCoor[targets[i]][1] - peopleCoor[i][1] == 0) {
        //Checking if the customer is at the product
        if (gotten[i] == false) {
          gotten[i] = true;
          if (cells[prodCoor[targets[i]][0]][prodCoor[targets[i]][1]] != 5) {
            curProducts = curProducts - 1;

            cells[prodCoor[targets[i]][0]][prodCoor[targets[i]][1]] = 5;
            
            //Shift values in availableProducts
            boolean on = false;
            for (int k = 0; k < numProducts-1; k = k + 1) {
              if (targets[i] <= availableProducts[k]) {
                on = true;
              }
              if (on) {
                availableProducts[k] = availableProducts[k+1];
              }
            }
          }
        }
      } 
      else {
        //If customers can't move at the product, they should move randomly
        for (int p = 0; p < 5; p = p + 1) {
          int index = int(random(4));
          try {
            if (move(peopleCoor[i], allDirect[index], i)) {
              break;
            }
          } 
          catch (Exception e) {
          }
        }
      }
    }
  }
}

boolean move(int[] coor, int[] direction, int i) {
  try {
    int[] dest = {coor[0] + direction[0], coor[1] + direction[1]};
    if (cells[dest[0]][dest[1]] != 0) {
      return false;
    }
    //If it's an empty spot, move there
    cells[dest[0]][dest[1]] = 1;
    cells[coor[0]][coor[1]] = 0;
    peopleCoor[i][0] = peopleCoor[i][0] + direction[0];
    peopleCoor[i][1] = peopleCoor[i][1] + direction[1];
    return true;
  } 
  catch (Exception e) {
    return false;
  }
}

boolean tryMoveSide(int i) {
  //Moving towards the destination
  if (getCoor[targets[i]][1] - peopleCoor[i][1] < 0) {
    if (move(peopleCoor[i], left, i)) {
      return true;
    }
  } 
  else {
    //If customers are at the destination and the distance is 0, don't move
    //Otherwise move right
    if (getCoor[targets[i]][1] - peopleCoor[i][1] != 0) {
      if (move(peopleCoor[i], right, i)) {
        return true;
      }
    }
  }
  return false;
}

boolean tryMoveUp(int i) {
  //Moving towards destination 
  if (getCoor[targets[i]][0] - peopleCoor[i][0] < 0) {
    if (move(peopleCoor[i], up, i)) {
      return true;
    }
  } 
  else if (getCoor[targets[i]][0] - peopleCoor[i][0] != 0) { 
    if (move(peopleCoor[i], down, i)) {
      return true;
    }
  }
  return false;
}

color squareColour(int value) {
  //Determines colour of cell
  if (value == 2 ) {
    return color(80);
  } else if (value == 1) {
    return color (0);
  } else if (value == 3 ) {
    return color (160);
  } else if (value == 4 ) {
    return color (166, 215, 222);
  } else if (value == 5 ) {
    return color (255, 255, 0);
  } else {
    return color(255);
  }
}

void initialize() {
  //Creating the get coordinate for entrance
  int[] temp = {cells.length-1, 3};
  getCoor[numProducts] =  temp;
  int[] temp2 = {cells.length-1, 2};
  getCoor[numProducts + 1] =  temp2;
  
  for (int i = 0; i < 10000; i = i + 1) {
    gotten[i] = false;
  }
  int counter = 0;
  int pCount = 0;
  boolean start = true;
  
  //Spawns a person in the coordinate above the entrance 
  for (int i=0; i<cells.length; i = i + 1) {
    for (int j=0; j<cells[0].length; j = j + 1) {
      if (cells[i][j] == 3) {
        int[] currentCoor = {i-1, j};
        arrayCopy(currentCoor, spawnCoor[counter]); //Set value of spawnCoor to currentCoor
        counter = counter + 1;
      } 
      else if (cells[i][j] == 4) { //If it's a product
        availableProducts[pCount] = pCount;
        if (start == true) {  //If product is on the left or right side, it changes the coordinate from where the customer picks the product up from
         
          int[] currentCoor = {i, j};
          arrayCopy(currentCoor, prodCoor[pCount]); //Set value of spawnCoor to productCoor

          currentCoor[1] = currentCoor[1] - 1;
          arrayCopy(currentCoor, getCoor[pCount]);

          start = false;
        } 
        else {
          int[] currentCoor = {i, j};
          arrayCopy(currentCoor, prodCoor[pCount]);

          currentCoor[1] = currentCoor[1] + 1;
          arrayCopy(currentCoor, getCoor[pCount]);
          
          start = true;
        }
        pCount = pCount + 1;
      }
    }
  }
}

void spawnPerson() {
  //Finding available spots so that 2 people don't spawn in the same place 
  if (curProducts == 0) {
    return;
  }
  
  int[] available = new int[2];
  int nums = 0;
  for (int i = 0; i <2; i = i +1) {
    if (cells[spawnCoor[i][0]][spawnCoor[i][1]] == 0) {
      available[nums] = i;
      nums = nums + 1;
    }
  }
  
  if (nums == 0) { //When there are no available spots
  } 
  else { //Fill a random available spot with a person
    int chosen = int(random(nums));

    int[] coord = spawnCoor[available[chosen]];
    arrayCopy(coord, peopleCoor[currentPeople]);

    targets[currentPeople] = availableProducts[int(random(curProducts))];

    currentPeople = currentPeople + 1;
    cells[spawnCoor[available[chosen]][0]][spawnCoor[available[chosen]][1]] = 1;
  }
}

//By: Kangan Mahajan
