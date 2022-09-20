//Changeable varibles
int n = 100;
int numTrawlers = 150;
int TrawlerRange = 4;
float pad = 0;
int blinksPerSecond = 15;

//Not changeable varibles
color[][] cells = new color[n][n];
color[][] cellsNext = new color[n][n];
int[][] Trawler = new int[numTrawlers][2];
int dx;
int dy;

float cellSize;
color red = color(255, 0, 0), blue = color(0, 0, 255), gray = color(200);


void RemoveCod (int x, int y) {
  for (int a = -TrawlerRange; a <= TrawlerRange; a++) {  
    for (int b = -TrawlerRange; b <= TrawlerRange; b++) {
      if (x+a < 0 || y+b < 0 || x+a >= n || y+b >= n) {
        continue;
      }
      if (a == 0 && b == 0) {
        continue;
      }
      if (cellsNext[x+a][y+b] == red) {
        continue;
      } else {
        cellsNext[x+a][y+b] = blue;
      }
    }
  }
}


void plantFirstGeneration() {
  for (int i = 0; i < n; i++) 
    for (int j = 0; j < n; j++) {
      cells[i][j]=blue;
      int rand = int(random( 0, 5 ));

      if (rand==0) { 
        cells[i][j] = gray;
      } else {
        cells[i][j] = blue;
      }
    }

  for (int k = 0; k < numTrawlers; k++) {
    Trawler[k][0] = int(random(n));
    Trawler[k][1] = int(random(n));
  }
}


void setNextGeneration() {
  int numAdjacentCod;

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      numAdjacentCod = countAdjacentCod(i, j);
      if (numAdjacentCod < 1 || numAdjacentCod > 3)
        cellsNext[i][j] = blue;
      else if (numAdjacentCod == 3)
        cellsNext[i][j] = gray;
      else
        if (cells[i][j] == red)
          cellsNext[i][j] = blue;
        else
          cellsNext[i][j] = cells[i][j];
    }
  }

  for (int i=0; i<numTrawlers; i++) {
    dx = int(random(3))-1;
    dy = int(random(3))-1;
    Trawler[i][0] = Trawler[i][0] + dx;
    Trawler[i][1] = Trawler[i][1] + dy;
    if (Trawler[i][0] < 0) {
      Trawler[i][0] = 0;
    }
    if (Trawler[i][0] >= n) {
      Trawler[i][0] = n-1;
    }
    if (Trawler[i][1] < 0) {
      Trawler[i][1] = 0;
    }
    if (Trawler[i][1] >= n) {
      Trawler[i][1] = n-1;
    }
    cellsNext[Trawler[i][0]][Trawler[i][1]] = red;

    RemoveCod(Trawler[i][0], Trawler[i][1]);
  }
}





void setup() {
  size(500, 500); 
  frameRate( blinksPerSecond );
  cellSize = (width-2*pad)/n;
  stroke(255);
  plantFirstGeneration();
}

void draw() {
  //background(255,0,0);

  float y = pad;

  for (int i=0; i < n; i++) {

    float x = pad;

    for (int j = 0; j < n; j++) {

      fill( cells[i][j] );
      stroke( cells[i][j]);
      rect(x, y, cellSize, cellSize);   

      x += cellSize;
    }

    y += cellSize;
  }
  setNextGeneration();
  copyNextGenerationToCurrentGeneration();
}
