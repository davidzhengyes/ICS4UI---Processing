/*
 * Perlin Noise Field Visualization
 *
 * Author: Callum Irving, 2022
 * Date: February 17th, 2022
 *
 * This program uses Perlin noise to generate a grid of vectors.
 * These vectors are then applied to dots as a force, causing them
 * to move in intersting paths.
 *
 * CONTROLS:
 *   Click and drag - create dots
 *   Space - toggle rainbow mode
 *   Backspace -  clear the screen
 *   p - pause and unpause
 *   b - toggle background drawing
 */

// Instead of getting a vector for every pixel, we make a grid of larger cells
// This significantly increases performance
final int CELL_SIZE = 40;

// The amount to increment x and y by in the Perlin noise grid
// Lower = smoother transitions but more uniform
// Try changing for some intersting results
final float STEP = 0.1;

boolean looping = true;
boolean drawBG = false;
boolean rainbowMode = false;

float time;
int rows, cols;

PVector[][] field;

ArrayList<Dot> dots;

void setup() {
  size(800, 600);
  //size(800, 600, P2D); // Increases performance by using OpenGL

  rows = height / CELL_SIZE;
  cols = width / CELL_SIZE;
  field = new PVector[cols][rows];
  dots = new ArrayList<Dot>();

  colorMode(HSB);
  noStroke();
  background(0);
}

void draw() {
  // Draw slightly transparent background
  // Gives the effect of trails.
  if (drawBG) {
    fill(0, 0, 0, 20);
    rect(0, 0, width, height, 0.1);
  }

  // Update vector field
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      float angle = noise(x * STEP, y * STEP, time) * 4 * TWO_PI;
      field[x][y] = PVector.fromAngle(angle);
    }
  }
  time += 0.003;

  for (Dot dot : dots) {
    dot.update();
    dot.wrap();
    dot.show();
  }
}

void mouseDragged() {
  // Create new dots when the mouse is clicked and dragged

  // Restrict dot positions to inside the window
  float dotX = min(max(mouseX, 0), width - 1);
  float dotY = min(max(mouseY, 0), height - 1);

  PVector pos = new PVector(dotX, dotY);
  PVector vel = new PVector(0, 0);
  dots.add(new Dot(pos, vel));
}

void keyPressed() {
  switch (key) {
  case ' ':
    rainbowMode = !rainbowMode;
    background(0);
    break;
  case 'b':
    drawBG = !drawBG;
    break;
  case 'p':
    if (looping)
      noLoop();
    else
      loop();
    looping = !looping;
    break;
  default:
    if (keyCode == BACKSPACE) {
      background(0);
      dots.clear();
    }
  }
}
