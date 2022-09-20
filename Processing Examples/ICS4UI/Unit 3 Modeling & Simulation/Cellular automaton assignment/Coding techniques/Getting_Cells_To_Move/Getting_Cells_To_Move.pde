//USER PARAMETERS TO PLAY WITH
int n = 30;
float blinksPerSecond = 3;
float probabilityOfRed = 0.03;  //Recommended below 10%   
color red  = color(255, 0, 0);
color grey = color(100);  //The two colours we're using.  Grey indicates background.  Red indicates a moving object, like a fox or something.


//GLOBAL VARIABLES
color[][] cells = new color[n][n];
color[][] cellsNext = new color[n][n];

//Each cell will have not just a color, but also an x-speed and a y-speed
int[][] xSpeeds = new int[n][n];    
int[][] xSpeedsNext = new int[n][n];

int[][] ySpeeds = new int[n][n];
int[][] ySpeedsNext = new int[n][n];

float cellSize;
float padding = 50;


void setup() {
  size(800, 800); 
  frameRate( blinksPerSecond );
  cellSize = (width-2*padding)/n;
  stroke(255);

  plantFirstGeneration();
}


void plantFirstGeneration() {
  for (int i = 0; i < n; i++) 
    for (int j = 0; j < n; j++) {
      //Determine which color to make cell (i, j) at the beginning

      //With a certain probability, we'll make  the cell red and give it a random x-speed and y-speed
      float rand = random( 0, 1 );

      if ( rand <= probabilityOfRed ) { //If the cell is to be turned red...
        cells[i][j] = red; //...then we set the cell's colour to red

        //Giving the red cell a random x-speed of either 1 (moving right) or -1 (moving left)
       
        xSpeeds[i][j] = round(random(-1, 1));       
        ySpeeds[i][j] = round(random(-1, 1));  
        
        if( xSpeeds[i][j] == 0 && ySpeeds[i][j]==0) //To prevent a red cell from having 0 speed in both directions
          xSpeeds[i][j] = 1;  
      } 
      
      else { //...otherwise, make the cell grey and give it a speed of 0 in both directions.
        cells[i][j] = grey;
        xSpeeds[i][j] = 0;
        ySpeeds[i][j] = 0;
      }
    }
}


//DETERMINES THE COLORS AND SPEEDS OF THE CELLS IN THE NEXT GENERATION.
//THE MAIN IDEA IS THAT IF A RED CELL IS IN POSITION, SAY, (12, 8), AND MOVING AT A SPEED OF (1, -1), THEN IN THE NEXT GENERATION, CELL (13, 7) WILL BE RED AND 
//CELL (12, 8) WILL TURN GREY, TO REFLECT THE FACT THAT THE RED CELL HAS LEFT...**HOWEVER!** WE DON'T ALWAYS WANT TO TURN CELL (12, 8) GREY BECAUSE ANOTHER RED CELL 
//MIGHT BE ABOUT TO MOVE INTO SLOT (12, 8) FROM A DIFFERENT DIRECTION!  FOR EXAMPLE, SUPPOSE CELL (13, 9) IS ALSO RED AND IS MOVING AT A SPEED OF (-1, -1). 
//THEN IN THIS CASE, CELL (12, 8) WILL **STAY RED** BECAUSE THIS SECOND RED CELL WILL BE MOVING INTO CELL (12, 8).  READ THE CODE BELOW TO SEE HOW WE ACCOMPLISH THIS.
void setNextGeneration() {
  scrubNext(); //Clearing out old data from cellsNext, xSpeedsNext and ySpeedsNext before computing the next round

  //For every cell (i, j) in the grid...
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {

      int sx = xSpeeds[i][j];  //Just making these short variable names to save us typing later
      int sy = ySpeeds[i][j];

      if ( cells[i][j] == red ) { //If cell (i, j) is red in this generation...
        try {
          int iNext = i + sy;  //The cell's row in the next gen will be its current row (i) plus its vertical speed (sy)
          int jNext = j + sx;  //The cell's column in the next gen will be its current column (j) plus its vertical speed (sx)

          cellsNext[ iNext ][ jNext ] = red;  //The cell we're moving into (iNext, jNext) will inherit the current cell's color (red) and speed (sx, sy).
          xSpeedsNext[ iNext ][ jNext] = sx;     //This creates the optical illusion that a red block is moving across the screen.
          ySpeedsNext[ iNext ][ jNext ] = sy;
        }

        catch( Exception e) {  //If the "next" cell would have been off screen, then we simply let the cell turn grey and remain motionless in the next generation.
          cellsNext[i][j] = grey;   //This creates the illusion that the cell is flying off the screen and never returns
          xSpeedsNext[i][j] = 0;
          ySpeedsNext[i][j] = 0;
        }
      }

      //Sets cell (i, j) back to grey in the next gen (since the red cell has left) UNLESS another red cell will be moving into slot (i, j) from a different direction.
      if ( cellsNext[i][j] != red ) {  //If  cell (i, j) hasn't already been turned red in the next gen by some other cell moving into it from a different direction, then...
        cellsNext[i][j] = grey; //...then we can go ahead and set the cell's colour to grey and its speed to 0 in the next gen.
        xSpeedsNext[i][j] = 0;        //This creates the illusion that any red square that used to be in position (i, j) has now vacated the cell, leaving it grey.
        ySpeedsNext[i][j] = 0;
      }
    }
  }
}


//RESETS THE 3 NEXT-GENERATION ARRAYS TO EMPTY ARRAYS SO THAT THEY DON'T MIX UP OLD DATA WITH NEW DATA
void scrubNext() {  
  cellsNext = new color[n][n];
  xSpeedsNext = new int[n][n];
  ySpeedsNext = new int[n][n];
}


//This draw() function is exactly the same as in the Game of Life or any other cellular automaton.  Nothing special to see here.
void draw() {
  background(255, 255, 0);
  float y = padding;

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float x = padding + j*cellSize;

      fill( cells[i][j] );        
      rect(x, y, cellSize, cellSize);
    }

    y += cellSize;
  }

  setNextGeneration();  //Just like we do in any cellular automaton
  copyNextGenerationToCurrentGeneration();  //Just like we do in any cellular automaton
}



//Just like Game of Life or any other cellular automaton, EXCEPT that we also copy over the two speed arrays in addition to the color array.
void copyNextGenerationToCurrentGeneration() {
  for (int i = 0; i < n; i++) 
    for (int j = 0; j < n; j++) {
      cells[i][j] = cellsNext[i][j];      //Copying the color array
      xSpeeds[i][j] = xSpeedsNext[i][j];  //Copying the speed arrays, as well
      ySpeeds[i][j] = ySpeedsNext[i][j];
    }
}
