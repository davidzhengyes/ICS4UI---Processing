class Noise { // base class for the noise function
  Noise() {}; // allows for creation of custom noise functions through inheiritance

  Vector3D noiseScale = Vector3D.one;
  Vector3D noiseOffset = Vector3D.zero; // allows for scaling and scrolling through noise

  float value(int x, int y, int z) { // function to override w/ custom formulae to output a pseudorandom number
    return 0;
  }
}
