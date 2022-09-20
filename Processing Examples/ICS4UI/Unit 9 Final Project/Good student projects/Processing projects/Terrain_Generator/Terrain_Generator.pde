import g4p_controls.*;

int steps = 0;

boolean rebuild = false;
Mesh_Builder meshBuilder;

// user-set settings
float thresholdValue = 0.5;
boolean useBinaryNoise = false;
Vector3D noiseScale = Vector3D.one;
Vector3D noiseOffset = new Vector3D(0, 0, 0);

Vector3D meshSize = new Vector3D(5, 5, 5);
Vector3D meshDimensions = new Vector3D(15, 15, 15);

void setup() {
  size(800, 800, P3D);

  meshBuilder = new Mesh_Builder();
  meshBuilder.buildMesh();

  createGUI();

 // setups the camera to be able to view the mesh
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/20, cameraZ*20);
}

void draw() {
  background(0);
  camera(80*cos(.01*steps), -60.0, -80.0*sin(.01*steps), //position
    5.0, 5.0, 5.0, //look-at pos
    0, 1.0, 0); //normal

  if (rebuild) {
    meshBuilder.buildMesh();
    rebuild = false;
  }
  
  meshBuilder.loadMesh();
  drawAxes(); // loads the mesh and gives a reference point to interpret the 3D space

  steps++;
}

void updateSettings(boolean rebuildMesh) { // updates the programs parameters w/ the user's choices
  meshBuilder.meshScale = meshSize;  // if any of change affect the noisemap, the program marks
                                     //  the mesh for recalculation next framr
  if (rebuildMesh) {
    meshBuilder.noiseMapGenerator.thresholdValue = thresholdValue;
    meshBuilder.noiseMapGenerator.binaryNoise = useBinaryNoise;
    meshBuilder.noiseMapGenerator.noise.noiseScale = noiseScale;
    meshBuilder.noiseMapGenerator.noise.noiseOffset = noiseOffset;
    
    meshBuilder.noiseMapGenerator.noiseMapDimensions[0] = (int)meshDimensions.x;
    meshBuilder.noiseMapGenerator.noiseMapDimensions[1] = (int)meshDimensions.y;
    meshBuilder.noiseMapGenerator.noiseMapDimensions[2] = (int)meshDimensions.z;

    rebuild = true;
  }
}

// debug drawing functions

void placeDot(float x, float y, float z) {
  translate(x, y, z);
  box(1);
  translate(-x, -y, -z);
}

void drawAxes() {
  stroke(255, 0, 0);
  fill(255, 0, 0);
  line(0, 0, 0, 45, 0, 0);
  placeDot(45, 0, 0);

  stroke(0, 255, 0);
  fill(0, 255, 0);
  line(0, 0, 0, 0, -45, 0);
  placeDot(0, -45, 0);

  stroke(0, 0, 255);
  fill(0, 0, 255);
  line(0, 0, 0, 0, 0, -45);
  placeDot(0, 0, -45);

  stroke(255);
  fill(255);
  placeDot(0, 0, 0);
}
