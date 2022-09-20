// Controls
//
// s = change material +
// a = change material -
//
// w = brush size +
// q = brush size -
//
// c = clear
// n = step simulation
// Space = play / pause

int d = 100; // Number of cells
int res = 500; // Screen size

int material = 1; // Material selected
int brush = 1; // Brush size
int scale = res / d; // Size of each cell in pixels

boolean play = false;
boolean step = false;

Board cells = new Board(d);

String names[] = {"Ground", "Sand", "Water", "Metal"};

// Board class
class Board {
  private int size;
  private int cells[][];

  public Board() {
    this.size = 10;
    this.cells = new int[10][10];
  }

  public Board(int size) {
    this.size = size;
    this.cells = new int[size][size];
  }

  // Safe way to index cells in the board
  public int at(int x, int y) {
    // If the index requested is out of the board we just treat it as solid
    if (x < 0 || y < 0 || x > this.size - 1 || y > this.size - 1)
      return 4;

    return this.cells[x][y];
  }

  // Safe way to insert cells into the board
  public int replace(int x, int y, int value) {
    // If the index requested is out of the board it can't be replaced
    if (x < 0 || y < 0 || x > this.size - 1 || y > this.size - 1)
      return -1;

    this.cells[x][y] = value;
    return 0;
  }
}

// Key press handling
void keyPressed() {
  // Play / pause
  if (key == ' ') {
    play = !play;
  }

  if (key == 'n') {
    step = true;
  }

  // Change material selected
  if (key == 's') {
    material = constrain(material += 1, 1, 4);
  }

  if (key == 'a') {
    material = constrain(material-= 1, 1, 4);
  }

  // Change brush size
  if (key == 'w') {
    brush = constrain(brush += 1, 1, 8);
  }

  if (key == 'q') {
    brush = constrain(brush -= 1, 1, 8);
  }

  // Clear board
  if (key == 'c') {
    for (int x = 0; x < cells.size; x++) {
      for (int y = 0; y < cells.size; y++) {
        cells.replace(x, y, 0);
      }
    }
  }
}

void setup() {
  size(500, 500);
  noStroke();
}

void draw() {
  background(0, 0, 0);

  // Mouse click handling
  if (mousePressed) {
    for (int ox = -10; ox < 10; ox++) {
      for (int oy = -10; oy < 10; oy++) {
        // Checking brush size 
        if (sqrt(pow((mouseX + ox) - mouseX, 2) + pow((mouseY + oy) - mouseY, 2)) < brush) {
          int px = constrain(mouseX / (500 / d) + ox, 0, d - 1);
          int py = constrain(mouseY / (500 / d) + oy, 0, d - 1);

          cells.replace(px, py, mouseButton == LEFT ? material : 0);
        }
      }
    }
  }

  // Draw the cells
  for (int x = 0; x < cells.size; x++) {
    for (int y = 0; y < cells.size; y++) {

      // If i am a ground cell
      if (cells.at(x, y) == 1) {
        fill(100, 50, 0);

      // If i am a sand cell
      } else if (cells.at(x, y) == 2) {
        fill(250, 250, 150);

      // If i am a water cell
      } else if (cells.at(x, y) == 3) {
        fill(50, 150, 250);

      // If i am a metal cell
      } else if (cells.at(x, y) == 4) {
        fill(100, 100, 100);

      // If i am an air cell
      } else {
        fill(0, 0, 0);
      }

      rect(scale * x, scale * y, scale, scale);
    }
  }

  // Draw the gui
  fill(255, 255, 255);

  text("Brush size: " + brush, 10, 20);
  text("Material: " + (names[material - 1]), 10, 40);

  // Only if the simulation is running
  if (play || step) {
    Board next_cells = new Board(d);

    // Update the each cell of the grid
    for (int x = 0; x < cells.size; x++) {
      for (int y = 0; y < cells.size; y++) {

        // Applying rules of the game

        // If i am a ground tile
        if (cells.at(x, y) == 1) {

          // If there is air below me move down
          if (cells.at(x, y + 1) == 0) {
            next_cells.replace(x, y + 1, cells.at(x, y));

          // Otherwise i will stay where i am
          } else {
            next_cells.replace(x, y, cells.at(x, y));
          }

          // If i am a sand tile
        } else if (cells.at(x, y) == 2) {

          // If there is air below me move down
          if (cells.at(x, y + 1) == 0 && next_cells.at(x, y + 1) == 0) {
            next_cells.replace(x, y + 1, cells.at(x, y));

          // If there is air diagonally to my bottom right corner move down to it
          } else if (cells.at(x + 1, y + 1) == 0 && next_cells.at(x + 1, y + 1) == 0) {
            next_cells.replace(x + 1, y + 1, cells.at(x, y));

          // If there is air diagonally to my bottom left corner move down to it
          } else if (cells.at(x - 1, y + 1) == 0 && next_cells.at(x - 1, y + 1) == 0) {
            next_cells.replace(x - 1, y + 1, cells.at(x, y));

          // Otherwise i will stay where i am
          } else {
            next_cells.replace(x, y, cells.at(x, y));
          }

          // If i am a water tile
        } else if (cells.at(x, y) == 3) {

          // If there is air below me move down
          if (cells.at(x, y + 1) == 0 && next_cells.at(x, y + 1) == 0) {
            next_cells.replace(x, y + 1, cells.at(x, y));

          // If there is ground above me switch places with it
          } else if (cells.at(x, y - 1) == 1 && next_cells.at(x, y - 1) == 1) {
            next_cells.replace(x, y, cells.at(x, y - 1));
            next_cells.replace(x, y - 1, cells.at(x, y));

          // If there is sand above me switch places with it
          } else if (cells.at(x, y - 1) == 2 && next_cells.at(x, y - 1) == 2) {
            next_cells.replace(x, y, cells.at(x, y - 1));
            next_cells.replace(x, y - 1, cells.at(x, y));

          // Otherwise i will move randomly either left or right to equalize the water level
          } else {
            
            // Choosing a random move (either left 1 or right 1)
            int move = random(2) > 1 ? -1 : 1;
            if (cells.at(x + move, y) == 0 && next_cells.at(x + move, y) == 0) {
              next_cells.replace(x + move, y, cells.at(x, y));
            } else {
              next_cells.replace(x, y, cells.at(x, y));
            }
            
          }

          // If i am a metal tile
        } else if (cells.at(x, y) == 4) {

          // Just stay where i am 
          next_cells.replace(x, y, cells.at(x, y));
          
        }
      }
    }

    // Copy the newly next_cellserated cells to the board
    cells = next_cells;

    step = false;
  }
}

// Basile Stathopulos
