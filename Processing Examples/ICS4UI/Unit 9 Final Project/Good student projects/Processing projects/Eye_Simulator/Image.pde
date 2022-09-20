class Image {
  float dist; //distance the image is from the eye in metres
  Eye eye;
  int n; //size of the image
  color[][] px; //used for storing the pixels of the image when blurring
  color[][] currPx;
  color[][] tempPx;
  float nearPoint; //NP and FP to calculate blur
  float farPoint;

  Image(float d, Eye e, int n, String fileName, float np, float fp) {
    this.dist = d;
    this.eye = e;
    this.n = n;

    this.px = new color[n][n];
    this.currPx = new color[n][n];
    this.tempPx = new color[n][n];

    PImage img = loadImage("data/"+fileName);  //loads in an image and stores its pixels (1D array) into the px 2D array
    loadPixels();
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        px[i][j] = color(img.pixels[n*i+j]);
      }
    }
    this.nearPoint = np;
    this.farPoint = fp;
  }

  void changeImage(String fileName) { //loads an image using the same code for another file name. try using included images "blue.png", "penguin.png", or "pattern.png"
    PImage img = loadImage("data/"+fileName);
    loadPixels();
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        px[i][j] = color(img.pixels[n*i+j]);
      }
    }
  }

  void changeNPFP(float NP, float FP) {
    this.nearPoint = NP;
    this.farPoint = FP;
  }
  void boxBlur(int rad) {
    //the "conformity" automaton used a box blur effect by averaging all the pixels in an m by m radius
    //a more efficient algorithm can be attained by blurring in one direction, then the other
    //as well as finding average by removing the last average's leftmost value and adding the next rightward value
    //see more: http://amritamaz.net/blog/understanding-box-blur
    if (rad == 0){
      for (int i=0; i<n; i++){
        for (int j=0; j<n; j++)
          currPx[i][j] = px[i][j];
      }
      return;
    }
    if (px.length < rad) return;

    for (int i = 0; i < px.length; i++) {
      int count = 0;
      int rSum = 0, gSum = 0, bSum = 0;
      for (int offset = 0; offset <= rad; offset++) {
        color c = px[i][offset];
        rSum += (c >> 16) & 0xFF;
        gSum +=  (c >> 8) & 0xFF;
        bSum +=         c & 0xFF;
        count++;
      }

      currPx[i][0] = color(rSum/count, gSum/count, bSum/count);

      int rowLength = px[i].length;

      for (int j = 1; j < rowLength; j++) {
        if (j >= rad) {
          color c = px[i][j - rad];
          rSum -= (c >> 16) & 0xFF;
          gSum -=  (c >> 8) & 0xFF;
          bSum -=         c & 0xFF;
          count--;
        }

        if (j + rad < rowLength) {
          color c = px[i][j + rad];
          rSum += (c >> 16) & 0xFF;
          gSum +=  (c >> 8) & 0xFF;
          bSum +=         c & 0xFF;
          count++;
        }

        currPx[i][j] = color(rSum/count, gSum/count, bSum/count);
      }
    }

    for (int i = 0; i < px[0].length; i++) {
      int count = 0;
      int rSum = 0, gSum = 0, bSum = 0;
      for (int offset = 0; offset <= rad; offset++) {
        color c = currPx[offset][i];
        rSum += (c >> 16) & 0xFF;
        gSum +=  (c >> 8) & 0xFF;
        bSum +=         c & 0xFF;
        count++;
      }

      currPx[0][i] = color(rSum/count, gSum/count, bSum/count);

      int columnLength = px.length;

      for (int j = 1; j < columnLength; j++) {
        if (j >= rad) {
          color c = currPx[j - rad][i];
          rSum -= (c >> 16) & 0xFF;
          gSum -=  (c >> 8) & 0xFF;
          bSum -=         c & 0xFF;
          count--;
        }

        if (j + rad < columnLength) {
          color c = currPx[j + rad][i];
          rSum += (c >> 16) & 0xFF;
          gSum +=  (c >> 8) & 0xFF;
          bSum +=         c & 0xFF;
          count++;
        }

        currPx[j][i] = color(rSum/count, gSum/count, bSum/count);
      }
    }
  }

  void blurE() { //calculates how much blur should be done
    float outOfRange;

    //calculates how far out of the range the image is and uses that to proportion blur
    if (this.dist > abs(farPoint)) {
      outOfRange = (this.dist-abs(farPoint));
    } else if (this.dist < abs(nearPoint)) {
      outOfRange = (abs(nearPoint)-this.dist);
    } else {
      outOfRange = 0;
    }
    this.boxBlur(ceil(outOfRange));
  }

  void drawRepresentation(float y) { //draws a green line representing a side-view of the image, to show the distance and line rays
    stroke(0, 200, 0);
    float x = this.eye.x-15-this.dist*2500;
    line(x, y-20, x, y+20);
    this.eye.drawRays(this.dist);

    textSize(10);
    fill(0, 200, 0);
    text("Image", x, y-20);
    fill(255, 255, 0);
    text("Light Rays", x+50, y-18);
  }

  void drawSelf(float x, float y) { //since drawing a PImage is faster, assembles the pixels into an image and draws that
    PImage tempImg = createImage(256, 256, RGB);
    tempImg.loadPixels();
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        tempImg.pixels[i * n + j] = currPx[i][j];
      }
    }

    tempImg.updatePixels();

    image(tempImg, x, y);
  }
}
