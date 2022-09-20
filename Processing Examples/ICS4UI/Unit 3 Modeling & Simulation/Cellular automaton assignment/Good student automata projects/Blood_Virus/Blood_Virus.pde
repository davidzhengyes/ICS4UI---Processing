String[][] blood;
String[][] fakeblood;
String[] probabilities;

float cellSize;
float SidePadding;
float VerticalPadding;
int NumRows = 60;
int padding = 0;

// TRY CHANGING THE VALUES BELOW 
int ZoomOut = 150;         // Zooms out from the artery as the value increases (Min 150 if you want 0 padding)
int PSpawnRate = 10;       // The spawn rate of pathogens entering the bloodstream
int PHungerRate = 15;      // The rate at which the pathogen eats red blood cells
int VitaminCLevels = 14;   // The rate at which white blood cells destroy the microbial invaders
int VitaminDLevels = 17;   // The rate at which reinforcements arrive once white blood cells have detected pathogens
int RedPercent = 45;       // Percentage of red bloodcells in healthy blood
int WhitePercent = 1;      // Percentage of white bloodcells in healthy blood


void setup(){
  size(1200,775);
  frameRate(30);
  noStroke();
  
  probabilities = new String[100];
  FillProbabilities(RedPercent,WhitePercent);      // This sets percentages for red blood cells and white blood cells respectively
  
  blood = new String[NumRows][ZoomOut];
  fakeblood = new String[NumRows][ZoomOut];
  
  // These lines adjust padding to make all cells as big as possible
  int MaxTopSize = (height-2*padding)/NumRows;
  int MaxSideSize = (width-2*padding)/ZoomOut;
  cellSize = min(MaxSideSize,MaxTopSize);
  SidePadding = (width - ZoomOut*cellSize)/2;      // Vertical and side padding are different to guarantee max cell size
  VerticalPadding = (height - NumRows*cellSize)/2;
  
  setCellValuesRandomly();      // Sets cell types for the first frame of the animation
  
}


void draw() { 
  background(198,108,69);
  float y;
  // This entire section checks the type of cell that should be drawn, and draws it
  for(int i=0;i<NumRows; i++) {
    y =  i*(cellSize) + VerticalPadding;      // The y-value of the current cell to be drawn
    for(int j=0; j<ZoomOut; j++) {
      float x = SidePadding + j*cellSize;      // The x-value of the current cell to be drawn
      if (blood[i][j] == null)
        fill(200,200,0);
      else if (blood[i][j].equals("white"))
        fill(255);
      else if (blood[i][j].equals("pathogen"))
        fill(0,180,0);
      else if (blood[i][j].equals("red"))
        fill(250,0,0);
      else
        fill(100,20,20);
      
      rect(x, y, cellSize+0.5, cellSize+0.5);  // Draws the current cell. I added 0.5 to fix a bug that shows background lines between cells.
    }
  }
  MoveBlood();      // Slides all bloodcells left by 1
  UpdatePathogen();      // Lets pathogens eat stuff
  SpawnNewPathogens();      // Randomely spawns new pathogens
  SpawnNewBloodCells();      // Spawns cells to continue blood flow
  UpdateWhite();      // lets white blood cells destroy pathogens and call for backup
  UpdateArray();      // copies the placeholder array into the current frame's array
}


void UpdateWhite(){
  for(int i=0;i<NumRows; i++) {
    for(int j=0; j<ZoomOut; j++) {
      if (blood[i][j].equals("white")){
        for(int x = -1; x <2; x++){      // These two arrays target an area around the white blood cell
          for(int y = -1; y <2; y++){
            try{
              if (blood[i+y][j+x].equals("pathogen")){      // Looking for adjacent pathogens
                if (random(0,20) < VitaminCLevels){      // Chance for white blood cells to kill the pathogen
                  fakeblood[i+y][j+x] = "plasma";
                  for (int w = -1; w<2 ; w++){      // A chance to call reinforcements close to the destroyed pathogen
                    if (random(0,60) < VitaminDLevels)
                      fakeblood[i+y+w][ZoomOut-1] = "white";
                      }
                    }
                  }
                }
            catch (IndexOutOfBoundsException e) { 
            }
          }
        }
      }
    }
  }
}


void UpdatePathogen(){
  for(int i=0;i<NumRows; i++) {
    for(int j=0; j<ZoomOut; j++) {
      if (blood[i][j].equals("pathogen")){
        fakeblood[i][j] = "pathogen";
        for(int x = -1; x <2; x++){      // These two arrays target an area around the pathogen
          for(int y = -1; y <2; y++){
            try{
              if (blood[i+y][j+x].equals("red")){      // Looking for adjacent red blood cells
                if (random(0,250) < PHungerRate){      // Chance for target pathogen to eat a red blood cell
                  fakeblood[i+y][j+x] = "pathogen";      // This overwrites the location of the red blood cell
                    }
                  }
                }
            catch (IndexOutOfBoundsException e) { 
            }
          }
        }
      }
    }
  }
}


void SpawnNewPathogens(){
  if (random(0,500) < PSpawnRate){
    int i = round(random(0,NumRows-1));
    int j = round(random(0,ZoomOut-1));
    fakeblood[i][j] = "pathogen";
  }
}


void SpawnNewBloodCells(){
  for(int i=0;i<NumRows; i++) {      // Targets the farthest right collumn, where blood cells have just away moved from
    fakeblood[i][ZoomOut-1] = probabilities[round(random(0,99))];
  }
}


void UpdateArray(){
  for(int i=0;i<NumRows; i++) {
    for(int j=0; j<ZoomOut; j++) {
      blood[i][j] = fakeblood[i][j];
    }
  }
}


void MoveBlood(){
  for (int j = 0; j<ZoomOut;j++){
    for (int i = 0; i<NumRows;i++){
      if (!blood[i][j].equals("pathogen") && !blood[i][j].equals("plasma")){      // Targets white and red cells
        try{      // "try" is used because there is a chance we target over the edge of the array
          fakeblood[i][j-1] = blood[i][j];
        }
        catch(IndexOutOfBoundsException e){
        }
        fakeblood[i][j] = "plasma";      // Leaving empty space ("plasma") where the cell used to be
      }
      else      
        fakeblood[i][j] = blood[i][j];      // If it's a cell that shouldn't be moved, we'll just record its place
    }
  }
}


void FillProbabilities(int percentred,int percentwhite){
  for (int i = 0 ; i<percentred ; i++){      // Targets all slots that should be filled by red
    probabilities[i] = "red";
  }
  for (int i = percentred ; i<percentwhite+percentred ; i++){      // Targets all slots that should be filled by white
    probabilities[i] = "white";
  }
  for (int i = percentwhite+percentred ; i<probabilities.length ; i++){      // Fills the rest with plasma
    probabilities[i] = "plasma";
  }
}


void setCellValuesRandomly() {
  for(int i = 0 ; i < NumRows ; i++){
    for(int j = 0 ; j < ZoomOut ; j++) {
      String disCell = probabilities[round(random(0,99))];      // Picks from our custom array where every slot is 1 percent
      if (disCell.equals("red"))
        blood[i][j] = "red";
      else if (disCell.equals("white"))
        blood[i][j] = "white";
      else
        blood[i][j] = "plasma";
  }}
}
