// Gizmos Simulator 

// Kieran Nieva

// Feel free to change any of the initial values 

// Most of the things worth messing around with are on the GUI when you run the program

// Press 'q' to quit the program

// Press 'm' to show/unshow the field animation on the screen

// Graph colours:

// Blue = Sheep, Red = Wolves, Green = grass

// Blue buttons on the bottom are for different modes (changing sheep & wolves intp icons saved in data folder)

// I wouldn't reccomend using the icons with high numbers because it might crash the program because you are spwaning so many

float numGrass  = 100;
int   numSheep  = 100;
int   numWolves = 0;


//


ArrayList<Wolf> wolves;
ArrayList<Sheep> sheeps;
Grass[][] lawn;


Field field;
Graph graph;
Labels labels;

boolean showField;
int showVersion;


// Main setup function
void setup() {
  size(1200, 800);
  colorMode(HSB, 360, 100, 100);
  field = new Field(2);
  graph = new Graph(0.1);
  labels = new Labels();
  showField = true;
  showVersion=0;
  
  

  lawn = new Grass[field.fieldSize][field.fieldSize];
  sheeps = new ArrayList();
  wolves = new ArrayList();

  //Add grass
  for (int i=0; i<field.fieldSize; i++) {
    for (int j=0; j<field.fieldSize; j++) {
      lawn[i][j] = new Grass();
    }
  }
  //Add sheep
  for (int i=0; i<numSheep; i++) sheeps.add(new Sheep());
  //Add wolves
  for (int i=0; i<numWolves; i++) wolves.add(new Wolf());
}


// Calling the things to be drawn 
void draw() {
  background(70);

  updateWorld();
  graph.update();
  

  graph.show();
  if (showField)field.show();
  labels.show();
}




// Update Function
void updateWorld() {
  
  //Grass 
  for (int i=0; i<field.fieldSize; i++) {
    for (int j=0; j<field.fieldSize; j++) {
      lawn[i][j].update();
    }
  }
  
  // Sheep
  for (int i = 0; i<sheeps.size(); i++) {
    sheeps.get(i).update();
  }
  
  // Wolves
  for (int i = 0; i < wolves.size(); i++) {
    wolves.get(i).update();
  }
  
  
  // Dead sheep and wolves
  for (int i=sheeps.size()-1; i>=0; i--) {
    if (sheeps.get(i).dead()) sheeps.remove(i);
  }
  for (int i=wolves.size()-1; i>=0; i--) {
    if (wolves.get(i).dead()) {
      print("fed:"+wolves.get(i).fedForDays+" lifespan:"+wolves.get(i).lifespan+"/"+wolves.get(i).maxLifespan+"\t");
      wolves.remove(i);
    }
  }
}


// Where the mouse is clicked and what affect it has on the program
void mouseClicked() {
  labels.click();
}


// If any keys were pressed
void keyPressed() {
  switch(key) {
  case 'q' : 
    {
      
      exit();
      break;
    }
  case 'm' : 
    {
      showField = !showField;
      break;
    }
  }
}
