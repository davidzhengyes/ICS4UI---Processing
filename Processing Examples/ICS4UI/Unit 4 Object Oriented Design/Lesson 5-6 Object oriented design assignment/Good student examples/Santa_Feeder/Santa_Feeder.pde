//Simulation of santa eating snacks and giving presents
//Brown circles represent cookies, white rectangles represent milk, red square represents Santa. 

//Variables you can change
int tileWidth = 15;
int tileLength = 70;
boolean fancyBackground = false;

int cAmount = 10;
int mAmount = 5;
int snackSpawnPadding = 100;

float eatingSpeed = 1; //larger number means longer delay
int santaSpeed = 3;
int santaSize = 30;
int santaHunger = 5; // how many cookies he'll eat
int santaThirst = 2; //how much milk he'll drink

PVector treeLocation = new PVector(60, 400); // (x,y) values
PVector treeSize = new PVector(110, 160); // (width, height) values


//Creating objects
Santa santa;
Snack[] snacks;
Tree christmasTree;

//Setting initial values of objects
void setup()
{
  size(800, 800);

  santa = new Santa(santaSpeed, color(254, 0, 26), santaSize, santaHunger, santaThirst);
  snacks = createSnacks(cAmount, mAmount);
  christmasTree = new Tree("unlitTree.png", treeLocation, treeSize);
  ;


  santa.spawn(0, width, 0, height);
  spawnSnacks();
  frameRate(60);
}


//Drawing everything
void draw()
{
  if (fancyBackground)
    drawBackGround();
  else
    background(50, 50, 50);

  santa.move();
  drawSnacks();
  santa.drawSanta();

  christmasTree.drawTree();
}



// drawing, spawning and creating array of Snacks
void drawSnacks()
{
  for (int i = 0; i < snacks.length; i ++)
  {
    snacks[i].drawSnack();
  }
}

void spawnSnacks()
{
  for (int i = 0; i < snacks.length; i++)
  {
    snacks[i].spawn(snackSpawnPadding, width - snackSpawnPadding, snackSpawnPadding, height - snackSpawnPadding);
  }
}

Snack[] createSnacks(int cAmount, int mAmount)
{
  Snack[] snacks = new Snack[cAmount + mAmount];
  for (int i = 0; i < cAmount; i ++)
  {
    snacks[i] = new Snack("cookie", color(113, 52, 13), 30, 1);
  }

  for (int i = cAmount; i < cAmount + mAmount; i ++)
  {
    snacks[i] = new Snack("milk", color(255, 255, 240), 30, 1);
  }

  return snacks;
}




//Drawing fancyBackground
void drawBackGround()
{
  int jCount = 0;
  for ( int i = 0; i <= width; i += tileLength)
  {
    for (int j = 0; j <= height; j += tileWidth)
    {
      stroke(68, 53, 28);
      fill(178, 133, 68);

      if (jCount % 2 == 0)
        rect(i - tileLength/2, j, tileLength, tileWidth);

      else
        rect(i, j, tileLength, tileWidth);

      jCount ++;
    }
  }

  stroke(0, 0, 0);
}
