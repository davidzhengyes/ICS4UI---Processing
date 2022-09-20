static class Vector3D { // data type to represent a 3D vector for more convient math
  float x;
  float y;
  float z;

  Vector3D(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  // prints the vector
  
  void debug() {
    println("["+this.x+", "+this.y+", "+this.z+"]");
  }

  // vector arithmatic, doesn't affect the vectors involved in the math

  static Vector3D add(Vector3D a, Vector3D b) {
    return new Vector3D (
      a.x + b.x, 
      a.y + b.y, 
      a.z + b.z);
  }

  static Vector3D sub(Vector3D a, Vector3D b) {
    return new Vector3D (
      a.x - b.x, 
      a.y - b.y, 
      a.z - b.z);
  }

  static Vector3D mult(Vector3D a, Vector3D b) { // uses Hadamard product
    return new Vector3D (
      a.x * b.x, 
      a.y * b.y, 
      a.z * b.z);
  }

  static Vector3D div(Vector3D a, Vector3D b) { // uses Hadamard product w/ b^-1
    return new Vector3D (
      a.x / b.x, 
      a.y / b.y, 
      a.z / b.z);
  }

  static Vector3D mult(Vector3D a, float n) { // scalar multiplier
    return new Vector3D (
      a.x * n, 
      a.y * n, 
      a.z * n);
  }

  static Vector3D div(Vector3D a, float n) {// scalar divisor
    return new Vector3D (
      a.x / n, 
      a.y / n, 
      a.z / n);
  }

  // base Vectors (vector version of 1, 0, and i-hat, j-hat, k-hat)

  static Vector3D zero = new Vector3D(0, 0, 0);
  static Vector3D one = new Vector3D(1, 1, 1);
  
  static Vector3D up = new Vector3D(0, -1, 0);
  static Vector3D forward = new Vector3D(1, 0, 0);
  static Vector3D right = new Vector3D(0, 0, -1);
}
