//Change
int eggRad = 15;
int kidRad = 20;

int numKids = 13;
int numEggs = 50;

float pickupEggSpeed = 11;//The higher you go (best if it's a prime #) the longer the kid takes to pick up the egg
int kidSpeed = 2;
boolean showScore = true;//Score on top of heads?


//No touchy from here down
Score_Board s;
Kid[] kids;
Egg[] eggs;


void setup(){
  size (1000,800);
  
  kids = createKids(numKids);
  eggs = createEggs(numEggs);
  s = new Score_Board ("apples");//A random String that's not EndGame
  
  //getting all the info before we go draw
  kidInfo();
  eggInfo();
  frameRate(30);//If it's going too fast, you can change this number
}


void draw(){
  background (0,200,100);
  
  //Drawing and moving things
  drawEachEgg();
  moveEachKid();
  drawEachKid();
  
  //the decision will change if there are no more eggs left
  //It'll bring you to the ending screen
  if (s.decision =="EndGame"){
    s.drawEnding();
    noLoop();
  } 
}
  

void drawEachEgg(){
  for (int i = 0; i<numEggs; i++){
    eggs[i].drawEgg();
  }
}

void drawEachKid(){
  for (int i = 0; i<numKids; i++){
    kids[i].drawKid();
  }
}

void moveEachKid(){
  for (int i = 0; i<numKids; i++){
    kids[i].moveKid();
  }
}

void eggInfo(){
  for (int i = 0; i<numEggs; i++){
    eggs[i].infoEgg(eggRad, width-eggRad, eggRad, height-eggRad);
  }
}

void kidInfo(){
  for (int i = 0; i<numKids; i++){
    kids[i].infoKid(kidRad, width-kidRad, kidRad, height-kidRad);
  }
}

Kid[] createKids(int numKids){
  int[][] colorsKid = new int[numKids][3];
  Kid[] kids = new Kid[numKids];
  for (int i=0;i<numKids;i++){
    for (int j =0; j<3; j++){
      int c = int (random ( 0,255));
      colorsKid[i][j] = c;
    }
  }
  for (int i=0;i<numKids;i++){
    kids[i] = new Kid(0,kidRad,kidSpeed,color(colorsKid[i][0],colorsKid[i][1],colorsKid[i][2]), showScore);
  } 
  return kids;
}

Egg[] createEggs(int numEgg){
  int[][]colorsEgg = new int[numEgg][3];
  Egg[] eggs = new Egg[numEgg];
  for (int i=0;i<numEgg;i++){
    for (int j =0; j<3; j++){
      int c = int (random ( 0,255));
      colorsEgg[i][j] = c; 
    }
  }
  for (int i=0; i<numEggs; i++){
    eggs[i] = new Egg( eggRad, color(colorsEgg[i][0],colorsEgg[i][1],colorsEgg[i][2]));
  }  
  return eggs;
}
