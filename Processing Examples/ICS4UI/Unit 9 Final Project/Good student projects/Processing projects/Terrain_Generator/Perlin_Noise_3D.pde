class Perlin_Noise_3D extends Noise {

  Vector3D perlinScale = Vector3D.mult(Vector3D.one, 1/15.3);
  
  int octaves = 4; // number of noisemaps to merge together

  Perlin_Noise_3D() {
    this.expandPermutation();
  }

  float value(int sampleX, int sampleY, int sampleZ) {
    float x = sampleX*this.perlinScale.x*noiseScale.x + noiseOffset.x;
    float y = sampleY*this.perlinScale.y*noiseScale.y + noiseOffset.y;
    float z = sampleZ*this.perlinScale.z*noiseScale.z + noiseOffset.z;

    float value = 0;
    float frequency = 1;
    float amplitude = 1;
    float maxValue = 0;  // Used for normalizing result to 0.0 - 1.0

    for (int i = 0; i <= this.octaves; i++) { // layers multiple generated noisemaps for increased detail and randomness
      value += amplitude*perlinNoise(x*frequency, y*frequency, z*frequency);

      maxValue += amplitude;

      amplitude /= 2;
      frequency *= 2;
    }

    return value/maxValue;
  }

  float perlinNoise(float x, float y, float z) {

    // Perlin noise calculates decimal values by calculating influence
    // of neighbouring intergers mapped to random values.

    int xi = (int)x & 255; // these lines divide and get the rem for values from 0-255 to allow reference to the table.
    int yi = (int)y & 255; // this causes the noise to repeat every 256 coors, but that's okay because 
    int zi = (int)z & 255; // the noise zoom is fairly high, so it will take a while to have the noise start tiling, and barely be noticable

    //*NOTE* & is used instead of % to modulate b/c [n%(2^i)] = [n&(2^i-1)]

    float dx = x-(int)x;
    float dy = y-(int)y; // calculate the difference from the modulated coor to the actual input
    float dz = z-(int)z;

    float u = easeCurve(dx);
    float v = easeCurve(dy); // smooths the difference for a better transistion b/w points
    float w = easeCurve(dz);

    // gets a random value from the table for each coor
    int aaa, aba, aab, abb, baa, bba, bab, bbb; 
    aaa = expandedP[expandedP[expandedP[ xi ]+  yi ]+  zi ];
    aba = expandedP[expandedP[expandedP[ xi ]+ yi+1]+  zi ];
    aab = expandedP[expandedP[expandedP[ xi ]+  yi ]+ zi+1];
    abb = expandedP[expandedP[expandedP[ xi ]+ yi+1]+ zi+1];  // eg. -> a.x, b.y, b.z
    baa = expandedP[expandedP[expandedP[xi+1]+  yi ]+  zi ];
    bba = expandedP[expandedP[expandedP[xi+1]+ yi+1]+  zi ];
    bab = expandedP[expandedP[expandedP[xi+1]+  yi ]+ zi+1];
    bbb = expandedP[expandedP[expandedP[xi+1]+ yi+1]+ zi+1];

    float x1, x2, y1, y2; // calculates gradient vectors for each 8 verts of the cube
    x1 = lerp(            // then interpolates them together
      grad(aaa, dx, dy, dz ), 
      grad(baa, dx-1, dy, dz ), 
      u);
    x2 = lerp(
      grad(aba, dx, dy-1, dz ), 
      grad(bba, dx-1, dy-1, dz ), 
      u);
    y1 = lerp(x1, x2, v);

    x1 = lerp(
      grad(aab, dx, dy, dz-1), 
      grad(bab, dx-1, dy, dz-1), 
      u);
    x2 = lerp(
      grad(abb, dx, dy-1, dz-1), 
      grad(bbb, dx-1, dy-1, dz-1), 
      u);
    y2 = lerp(x1, x2, v);

    return (lerp(y1, y2, w)+1)/2;
  }

  float easeCurve(float p) { // inputted a value from 0-1, outputs a number 0-1 smoothed from less linear gradients
    return p * p * p * (p * (p * 6 - 15) + 10);
  }

  float grad(int hash, float x, float y, float z) { // uses a weird trick to calculate the 
    switch(hash & 0xF) { // dot product b/w a location vector and a random gradient
    case 0x0: 
      return  x + y;
    case 0x1: 
      return -x + y;
    case 0x2: 
      return  x - y;
    case 0x3: 
      return -x - y;
    case 0x4: 
      return  x + z;
    case 0x5: 
      return -x + z;
    case 0x6: 
      return  x - z;
    case 0x7: 
      return -x - z;
    case 0x8: 
      return  y + z;
    case 0x9: 
      return -y + z;
    case 0xA: 
      return  y - z;
    case 0xB: 
      return -y - z;
    case 0xC: 
      return  y + x;
    case 0xD: 
      return -y + z;
    case 0xE: 
      return  y - x;
    case 0xF: 
      return -y - z;
    default: 
      return 0; // never happens
    }
  }

  int[] expandedP; // doubles the permutation table for easier use
  void expandPermutation() {
    expandedP = new int[512];
    for (int x=0; x<512; x++) {
      expandedP[x] = permutation[x%256];
    }
  }
 // Hash lookup table as defined by Ken Perlin.  This is a randomly arranged array of all numbers from 0-255 inclusive.
  int[] permutation = { 151, 160, 137, 91, 90, 15, 131, 13, 201, 95, 96, 53, 194, 233, 7, 225, 140,
    36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23, 190, 6, 148, 247, 120, 234, 75, 0, 26, 197, 
    62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33, 88, 237, 149, 56, 87, 174, 20, 125, 136, 
    171, 168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166, 77, 146, 158, 231, 83, 111, 229, 122, 
    60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245, 40, 244, 102, 143, 54, 65, 25, 63, 161, 1, 
    216, 80, 73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196, 135, 130, 116, 188, 159, 86, 164, 
    100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123, 5, 202, 38, 147, 118, 126, 255, 
    82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42, 223, 183, 170, 213, 119, 248, 
    152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9, 129, 22, 39, 253, 19, 98, 108, 
    110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228, 251, 34, 242, 193, 238, 210, 
    144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107, 49, 192, 214, 31, 181, 
    199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254, 138, 236, 205, 93, 
    222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180
  };
}
