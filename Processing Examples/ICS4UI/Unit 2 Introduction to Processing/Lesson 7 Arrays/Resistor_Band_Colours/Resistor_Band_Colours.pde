
//Resistor color simulator//
// click to change resistor band colors//

String[] colors = {"black 0", "brown 1", "red 2", "orange 3", "yellow 4", "green 5", "blue 6", "violet 7", "grey 8", "white 9", "gold 0.05", "silver 0.1"};
float[] bandValues = new float[colors.length];
int[][] rgbs = {{0, 0, 0}, {150, 75, 0}, {255, 0, 0}, {255, 165, 0}, {255, 215, 0}, {0, 128, 0}, {0, 0, 255}, {238, 130, 238}, {211, 211, 211}, {255, 255, 255}, {204, 153, 102}, {192, 192, 192}};
int[] bands = {0, 0, 0, 0};
float value;

boolean showValue = true;

void updateValue() {
  value = (10 * bandValues[bands[0] % 10] + bandValues[bands[1] % 10]) * pow(10, (bandValues[bands[2] % 10] ));
}

void setup() {
  for (int i = 0; i < colors.length; i++) {
    String[] temp = colors[i].split(" ");
    bandValues[i] = float(temp[1]);
  }
  updateValue();
  size(800, 400);
  background(255);
}
void draw() {
  // draw base resistor
  background(255);
  fill(245, 245, 220);
  rect(100, 100, 600, 200);
  line(100, 200, 0, 200);
  line(700, 200, 800, 200);
  // drawing resistor color bands
  for (int i = 0; i < 4; i++) {
    if (i == 3) {
      fill(rgbs[bands[i]%2 + 10][0], rgbs[bands[i]%2 + 10][1], rgbs[bands[i]%2 + 10][2]);
      rect(170 + 120*i, 100, 100, 200);
    } else {
      fill(rgbs[bands[i]%10 ][0], rgbs[bands[i]%10 ][1], rgbs[bands[i]%10 ][2]);
      rect(170 + 120*i, 100, 100, 200);
    }
  }
  if (showValue) {
    PFont font;
    font = createFont("ComicSansMS", 24);
    fill(0);
    textAlign(CENTER);
    textFont(font);
    text("value :" + value + "\u2126", 400, 350);
    textAlign(LEFT);
    text("Lower limit :" + value * (1 - bandValues[bands[3] % 2 + 10]) + "\u2126", 0, 50);
    textAlign(RIGHT);
    text("Upper limit :" + value * (1 + bandValues[bands[3] % 2 + 10]) + "\u2126", 800, 50);
  }
  noLoop();
}


void mousePressed(){
  if(mouseY < 300 && mouseY > 100){
    for(int i = 0; i < 4; i++){
      if(mouseX > 170 + 120*i && mouseX < 280 + 120*i){
        bands[i] += 1;
        updateValue();
        redraw();
        break;
      }
    }
  }
}
