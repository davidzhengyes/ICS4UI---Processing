class Noise_Map_Generator {

  boolean binaryNoise; // whether or not the vertex should be
  float thresholdValue;

  Noise noise = new Perlin_Noise_3D();
  float[][][] noiseMap; // weight for each vertices
  int[] noiseMapDimensions = { 15, 15, 15 }; // number of cubes in each axes

  Noise_Map_Generator() {
    this.binaryNoise = true;
    this.thresholdValue = 0;
  }

  Noise_Map_Generator(boolean binary, float threshold) {
    this.binaryNoise = binary;
    this.thresholdValue = threshold;
  }

  void generateNoiseMap () {
    println("generating noise map");
    noiseMap = new float[this.noiseMapDimensions[0]+1][this.noiseMapDimensions[1]+1][this.noiseMapDimensions[2]+1];
/* the noise map is generated with one extra length in each direction because each cube calls on the 
current index and the one after, so an extra layer must be generated for the last cube to function properly*/
    if (this.binaryNoise) {
      for (int i = 0; i < this.noiseMapDimensions[0]+1; i++) {
        for (int j = 0; j < this.noiseMapDimensions[1]+1; j++) {
          for (int k = 0; k < this.noiseMapDimensions[2]+1; k++) {
            float value = this.noise.value(i, j, k);
            if (value > this.thresholdValue) {
              this.noiseMap[i][j][k] = 1;
            } else {
              this.noiseMap[i][j][k] = 0;
            }
          }
        }
      }
    } else {
      for (int i = 0; i < this.noiseMapDimensions[0]+1; i++) {
        for (int j = 0; j < this.noiseMapDimensions[1]+1; j++) {
          for (int k = 0; k < this.noiseMapDimensions[2]+1; k++) {
            float value = this.noise.value(i, j, k);
            this.noiseMap[i][j][k] = value;
          }
        }
      }
    }

    println("completed noise map");
  }

  void printNoiseMap() {
    for (int i = 0; i < this.noiseMapDimensions[0]+1; i++) {
      print("[");
      for (int j = 0; j < this.noiseMapDimensions[1]+1; j++) {
        print("[" +this.noiseMap[i][j][1]);
        for (int k = 1; k < this.noiseMapDimensions[2]+1; k++) {
          print(", " + this.noiseMap[i][j][k]);
        }
        println("]");
      }
      println("]");
    }
    println("]");
  }

  void drawNoiseMap() {
    int dX = width/this.noiseMapDimensions[0];
    int dY = height/this.noiseMapDimensions[1]; //ignores 3rd dimension, simpler to understand

    strokeWeight(0);

    for (int i = 0; i < this.noiseMapDimensions[0]; i++) {
      for (int j = 0; j < this.noiseMapDimensions[1]; j++) {
        fill(map(this.noiseMap[i][j][0], 0, 1, 0, 255));
        rect(i*dX, j*dY, dX, dY);
      }
    }
  }
}
