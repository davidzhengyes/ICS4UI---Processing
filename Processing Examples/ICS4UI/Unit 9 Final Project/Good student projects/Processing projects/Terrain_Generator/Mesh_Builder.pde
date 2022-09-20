class Mesh_Builder { // class that builds a mesh based off of a noise map using the Marching Cubes algorithm

  Vector3D meshScale = new Vector3D(5, 5, 5); // scales the mesh in 3D space
  ArrayList<Vector3D[]> triangles; //stores the triangles that make up the mesh 
  // (triangles are an array of the 3 vertices that make the triangle)
  Noise_Map_Generator noiseMapGenerator;

  Mesh_Builder() {
    this.noiseMapGenerator = new Noise_Map_Generator(false, 0.5);
  }

  void loadMesh() { // draws the mesh in 3D space with the loaded triangle list
    fill(255);
    stroke(255, 0, 0);

    translate(
      -this.meshScale.x*this.noiseMapGenerator.noiseMapDimensions[0]/2, 
      this.meshScale.y*this.noiseMapGenerator.noiseMapDimensions[1]/2, // slids the "pen" over to draw the center
      this.meshScale.z*this.noiseMapGenerator.noiseMapDimensions[2]/2); // of the mesh in the center of the scene

    for (Vector3D[] triangle : this.triangles) {
      beginShape(TRIANGLES);

      vertex(triangle[0].x*this.meshScale.x, -triangle[0].y*this.meshScale.y, -triangle[0].z*this.meshScale.z);
      vertex(triangle[1].x*this.meshScale.x, -triangle[1].y*this.meshScale.y, -triangle[1].z*this.meshScale.z); // places the triangle at the correct scaled location
      vertex(triangle[2].x*this.meshScale.x, -triangle[2].y*this.meshScale.y, -triangle[2].z*this.meshScale.z);

      endShape();
    }

    translate(
      this.meshScale.x*this.noiseMapGenerator.noiseMapDimensions[0]/2, 
      -this.meshScale.y*this.noiseMapGenerator.noiseMapDimensions[1]/2, // moves the screen back to not mess with camera settings
      -this.meshScale.z*this.noiseMapGenerator.noiseMapDimensions[2]/2);
  }

  void buildMesh() { // generates a new mesh and stores the calculated triangle for future use
    println("building mesh");
    this.noiseMapGenerator.generateNoiseMap(); // generates a noise map
    boolean binary = this.noiseMapGenerator.binaryNoise;

    this.triangles = new ArrayList<Vector3D[]>();

    for (int i = 0; i < this.noiseMapGenerator.noiseMapDimensions[0]; i++) {
      for (int j = 0; j < this.noiseMapGenerator.noiseMapDimensions[1]; j++) {
        for (int k = 0; k < this.noiseMapGenerator.noiseMapDimensions[2]; k++) {
          float[] vertValues = { // gets the noise for the eight vertices of the cube the algorithm
            this.noiseMapGenerator.noiseMap[ i ][ j ][ k ], // is currently building a mesh for
            this.noiseMapGenerator.noiseMap[i+1][ j ][ k ], 
            this.noiseMapGenerator.noiseMap[i+1][ j ][k+1], 
            this.noiseMapGenerator.noiseMap[ i ][ j ][k+1], 
            this.noiseMapGenerator.noiseMap[ i ][j+1][ k ], 
            this.noiseMapGenerator.noiseMap[i+1][j+1][ k ], 
            this.noiseMapGenerator.noiseMap[i+1][j+1][k+1], 
            this.noiseMapGenerator.noiseMap[ i ][j+1][k+1], 
          };

          int tableIndex = getTableIndex(vertValues, binary, this.noiseMapGenerator.thresholdValue); // calculates the index the of the table
          int[] edgeTable = triTable[tableIndex]; // gets the list of edges that triangles need to be generated through

          for (int e = 0; e < edgeTable.length; e+=3) {
            Vector3D v1 = AddEdgeVertex(edgeTable[ e ], new Vector3D(i, j, k), binary);
            Vector3D v2 = AddEdgeVertex(edgeTable[e+1], new Vector3D(i, j, k), binary); // calculates the position of the 3 vertices in a triangle
            Vector3D v3 = AddEdgeVertex(edgeTable[e+2], new Vector3D(i, j, k), binary);

            Vector3D[] vertices = new Vector3D[3];
            vertices[0] = v1;
            vertices[1] = v2;  // and adds the assembled triangle to the list
            vertices[2] = v3;

            this.triangles.add(vertices);
          }
        }
      }
    }

    println("finished mesh");
  }

  Vector3D AddEdgeVertex(int edgePoint, Vector3D origin, boolean binary) { // calculates the where along the edge the vertice falls
    Vector3D p1 = new Vector3D((int)origin.x, (int)origin.y, (int)origin.z);
    Vector3D p2 = new Vector3D((int)origin.x, (int)origin.y, (int)origin.z);
    // p1 & p2 represents the two endpoints of the edge. the points start at the base of the cube 
    switch (edgePoint) { // and are moved to the proper edge based off of the inputted edgePoint
    case 0:
      p2.x += 1;
      break;

    case 1:
      p1.x += 1;

      p2.x += 1;
      p2.z += 1;
      break;

    case 2:
      p1.x += 1;
      p1.z += 1;

      p2.z += 1;
      break;

    case 3:
      p2.z += 1;
      break;

    case 4:
      p1.y += 1;

      p2.x += 1;
      p2.y += 1;
      break;

    case 5:
      p1.x += 1;
      p1.y += 1;

      p2.x += 1;
      p2.y += 1;
      p2.z += 1;
      break;

    case 6:
      p1.x += 1;
      p1.y += 1;
      p1.z += 1;

      p2.y += 1;
      p2.z += 1;
      break;

    case 7:
      p1.y += 1;

      p2.y += 1;
      p2.z += 1;
      break;

    case 8:
      p2.y += 1;
      break;

    case 9:
      p1.x += 1;

      p2.x += 1;
      p2.y += 1;
      break;

    case 10:
      p1.x += 1;
      p1.z += 1;

      p2.x += 1;
      p2.y += 1;
      p2.z += 1;
      break;

    case 11:
      p1.z += 1;

      p2.y += 1;
      p2.z += 1;
      break;
    }

    Vector3D newEdgeVertexPos = Vector3D.zero;

    if (binary) { // if the noise is binary, the vertex is placed on the midpoint of the edge
      newEdgeVertexPos = new Vector3D(
        (p1.x+p2.x)/2, 
        (p1.y+p2.y)/2, 
        (p1.z+p2.z)/2
        );
    } else { // if the noise isn't binary (smooth transitions b/w points), calculates where the vertex 
      // should fall on the edge based a linear interpolation of the weight of the two endpoints
      float v1 = this.noiseMapGenerator.noiseMap[(int)p1.x][(int)p1.y][(int)p1.z];
      float v2 = this.noiseMapGenerator.noiseMap[(int)p2.x][(int)p2.y][(int)p2.z];

      newEdgeVertexPos = Vector3D.sub(p2, p1);
      newEdgeVertexPos = Vector3D.div(newEdgeVertexPos, (v2 - v1));
      newEdgeVertexPos = Vector3D.mult(newEdgeVertexPos, this.noiseMapGenerator.thresholdValue - v1);
      newEdgeVertexPos = Vector3D.add(newEdgeVertexPos, p1);
    }

    return newEdgeVertexPos;
  }

  int getTableIndex(float[] vertValues, boolean binary, float thresholdValue) {
    int index = 0;  // gets the row of the table that dicates what edges the shape passes through based
    if (binary) {   // on what vertices the mesh shape passes through
      thresholdValue = 1;
    }

    for (int i = 7; i >= 0; i--) { // bit set to one if the vert is in the shape, 0 if not
      index += vertValues[i] >= thresholdValue ? 1:0;
      index = index << 1;
    }
    return index >> 1; // binary key is converted to a decimal number that is the table index
  }

  int[][] triTable = { // reference table
    { }, 
    {0, 8, 3}, 
    {0, 1, 9}, 
    {1, 8, 3, 9, 8, 1}, 
    {1, 2, 10}, 
    {0, 8, 3, 1, 2, 10}, 
    {9, 2, 10, 0, 2, 9}, 
    {2, 8, 3, 2, 10, 8, 10, 9, 8}, 
    {3, 11, 2}, 
    {0, 11, 2, 8, 11, 0}, 
    {1, 9, 0, 2, 3, 11}, 
    {1, 11, 2, 1, 9, 11, 9, 8, 11}, 
    {3, 10, 1, 11, 10, 3}, 
    {0, 10, 1, 0, 8, 10, 8, 11, 10}, 
    {3, 9, 0, 3, 11, 9, 11, 10, 9}, 
    {9, 8, 10, 10, 8, 11}, 
    {4, 7, 8}, 
    {4, 3, 0, 7, 3, 4}, 
    {0, 1, 9, 8, 4, 7}, 
    {4, 1, 9, 4, 7, 1, 7, 3, 1}, 
    {1, 2, 10, 8, 4, 7}, 
    {3, 4, 7, 3, 0, 4, 1, 2, 10}, 
    {9, 2, 10, 9, 0, 2, 8, 4, 7}, 
    {2, 10, 9, 2, 9, 7, 2, 7, 3, 7, 9, 4}, 
    {8, 4, 7, 3, 11, 2}, 
    {11, 4, 7, 11, 2, 4, 2, 0, 4}, 
    {9, 0, 1, 8, 4, 7, 2, 3, 11}, 
    {4, 7, 11, 9, 4, 11, 9, 11, 2, 9, 2, 1}, 
    {3, 10, 1, 3, 11, 10, 7, 8, 4}, 
    {1, 11, 10, 1, 4, 11, 1, 0, 4, 7, 11, 4}, 
    {4, 7, 8, 9, 0, 11, 9, 11, 10, 11, 0, 3}, 
    {4, 7, 11, 4, 11, 9, 9, 11, 10}, 
    {9, 5, 4}, 
    {9, 5, 4, 0, 8, 3}, 
    {0, 5, 4, 1, 5, 0}, 
    {8, 5, 4, 8, 3, 5, 3, 1, 5}, 
    {1, 2, 10, 9, 5, 4}, 
    {3, 0, 8, 1, 2, 10, 4, 9, 5}, 
    {5, 2, 10, 5, 4, 2, 4, 0, 2}, 
    {2, 10, 5, 3, 2, 5, 3, 5, 4, 3, 4, 8}, 
    {9, 5, 4, 2, 3, 11}, 
    {0, 11, 2, 0, 8, 11, 4, 9, 5}, 
    {0, 5, 4, 0, 1, 5, 2, 3, 11}, 
    {2, 1, 5, 2, 5, 8, 2, 8, 11, 4, 8, 5}, 
    {10, 3, 11, 10, 1, 3, 9, 5, 4}, 
    {4, 9, 5, 0, 8, 1, 8, 10, 1, 8, 11, 10}, 
    {5, 4, 0, 5, 0, 11, 5, 11, 10, 11, 0, 3}, 
    {5, 4, 8, 5, 8, 10, 10, 8, 11}, 
    {9, 7, 8, 5, 7, 9}, 
    {9, 3, 0, 9, 5, 3, 5, 7, 3}, 
    {0, 7, 8, 0, 1, 7, 1, 5, 7}, 
    {1, 5, 3, 3, 5, 7}, 
    {9, 7, 8, 9, 5, 7, 10, 1, 2}, 
    {10, 1, 2, 9, 5, 0, 5, 3, 0, 5, 7, 3}, 
    {8, 0, 2, 8, 2, 5, 8, 5, 7, 10, 5, 2}, 
    {2, 10, 5, 2, 5, 3, 3, 5, 7}, 
    {7, 9, 5, 7, 8, 9, 3, 11, 2}, 
    {9, 5, 7, 9, 7, 2, 9, 2, 0, 2, 7, 11}, 
    {2, 3, 11, 0, 1, 8, 1, 7, 8, 1, 5, 7}, 
    {11, 2, 1, 11, 1, 7, 7, 1, 5}, 
    {9, 5, 8, 8, 5, 7, 10, 1, 3, 10, 3, 11}, 
    {5, 7, 0, 5, 0, 9, 7, 11, 0, 1, 0, 10, 11, 10, 0}, 
    {11, 10, 0, 11, 0, 3, 10, 5, 0, 8, 0, 7, 5, 7, 0}, 
    {11, 10, 5, 7, 11, 5}, 
    {10, 6, 5}, 
    {0, 8, 3, 5, 10, 6}, 
    {9, 0, 1, 5, 10, 6}, 
    {1, 8, 3, 1, 9, 8, 5, 10, 6}, 
    {1, 6, 5, 2, 6, 1}, 
    {1, 6, 5, 1, 2, 6, 3, 0, 8}, 
    {9, 6, 5, 9, 0, 6, 0, 2, 6}, 
    {5, 9, 8, 5, 8, 2, 5, 2, 6, 3, 2, 8}, 
    {2, 3, 11, 10, 6, 5}, 
    {11, 0, 8, 11, 2, 0, 10, 6, 5}, 
    {0, 1, 9, 2, 3, 11, 5, 10, 6}, 
    {5, 10, 6, 1, 9, 2, 9, 11, 2, 9, 8, 11}, 
    {6, 3, 11, 6, 5, 3, 5, 1, 3}, 
    {0, 8, 11, 0, 11, 5, 0, 5, 1, 5, 11, 6}, 
    {3, 11, 6, 0, 3, 6, 0, 6, 5, 0, 5, 9}, 
    {6, 5, 9, 6, 9, 11, 11, 9, 8}, 
    {5, 10, 6, 4, 7, 8}, 
    {4, 3, 0, 4, 7, 3, 6, 5, 10}, 
    {1, 9, 0, 5, 10, 6, 8, 4, 7}, 
    {10, 6, 5, 1, 9, 7, 1, 7, 3, 7, 9, 4}, 
    {6, 1, 2, 6, 5, 1, 4, 7, 8}, 
    {1, 2, 5, 5, 2, 6, 3, 0, 4, 3, 4, 7}, 
    {8, 4, 7, 9, 0, 5, 0, 6, 5, 0, 2, 6}, 
    {7, 3, 9, 7, 9, 4, 3, 2, 9, 5, 9, 6, 2, 6, 9}, 
    {3, 11, 2, 7, 8, 4, 10, 6, 5}, 
    {5, 10, 6, 4, 7, 2, 4, 2, 0, 2, 7, 11}, 
    {0, 1, 9, 4, 7, 8, 2, 3, 11, 5, 10, 6}, 
    {9, 2, 1, 9, 11, 2, 9, 4, 11, 7, 11, 4, 5, 10, 6}, 
    {8, 4, 7, 3, 11, 5, 3, 5, 1, 5, 11, 6}, 
    {5, 1, 11, 5, 11, 6, 1, 0, 11, 7, 11, 4, 0, 4, 11}, 
    {0, 5, 9, 0, 6, 5, 0, 3, 6, 11, 6, 3, 8, 4, 7}, 
    {6, 5, 9, 6, 9, 11, 4, 7, 9, 7, 11, 9}, 
    {10, 4, 9, 6, 4, 10}, 
    {4, 10, 6, 4, 9, 10, 0, 8, 3}, 
    {10, 0, 1, 10, 6, 0, 6, 4, 0}, 
    {8, 3, 1, 8, 1, 6, 8, 6, 4, 6, 1, 10}, 
    {1, 4, 9, 1, 2, 4, 2, 6, 4}, 
    {3, 0, 8, 1, 2, 9, 2, 4, 9, 2, 6, 4}, 
    {0, 2, 4, 4, 2, 6}, 
    {8, 3, 2, 8, 2, 4, 4, 2, 6}, 
    {10, 4, 9, 10, 6, 4, 11, 2, 3}, 
    {0, 8, 2, 2, 8, 11, 4, 9, 10, 4, 10, 6}, 
    {3, 11, 2, 0, 1, 6, 0, 6, 4, 6, 1, 10}, 
    {6, 4, 1, 6, 1, 10, 4, 8, 1, 2, 1, 11, 8, 11, 1}, 
    {9, 6, 4, 9, 3, 6, 9, 1, 3, 11, 6, 3}, 
    {8, 11, 1, 8, 1, 0, 11, 6, 1, 9, 1, 4, 6, 4, 1}, 
    {3, 11, 6, 3, 6, 0, 0, 6, 4}, 
    {6, 4, 8, 11, 6, 8}, 
    {7, 10, 6, 7, 8, 10, 8, 9, 10}, 
    {0, 7, 3, 0, 10, 7, 0, 9, 10, 6, 7, 10}, 
    {10, 6, 7, 1, 10, 7, 1, 7, 8, 1, 8, 0}, 
    {10, 6, 7, 10, 7, 1, 1, 7, 3}, 
    {1, 2, 6, 1, 6, 8, 1, 8, 9, 8, 6, 7}, 
    {2, 6, 9, 2, 9, 1, 6, 7, 9, 0, 9, 3, 7, 3, 9}, 
    {7, 8, 0, 7, 0, 6, 6, 0, 2}, 
    {7, 3, 2, 6, 7, 2}, 
    {2, 3, 11, 10, 6, 8, 10, 8, 9, 8, 6, 7}, 
    {2, 0, 7, 2, 7, 11, 0, 9, 7, 6, 7, 10, 9, 10, 7}, 
    {1, 8, 0, 1, 7, 8, 1, 10, 7, 6, 7, 10, 2, 3, 11}, 
    {11, 2, 1, 11, 1, 7, 10, 6, 1, 6, 7, 1}, 
    {8, 9, 6, 8, 6, 7, 9, 1, 6, 11, 6, 3, 1, 3, 6}, 
    {0, 9, 1, 11, 6, 7}, 
    {7, 8, 0, 7, 0, 6, 3, 11, 0, 11, 6, 0}, 
    {7, 11, 6}, 
    {7, 6, 11}, 
    {3, 0, 8, 11, 7, 6}, 
    {0, 1, 9, 11, 7, 6}, 
    {8, 1, 9, 8, 3, 1, 11, 7, 6}, 
    {10, 1, 2, 6, 11, 7}, 
    {1, 2, 10, 3, 0, 8, 6, 11, 7}, 
    {2, 9, 0, 2, 10, 9, 6, 11, 7}, 
    {6, 11, 7, 2, 10, 3, 10, 8, 3, 10, 9, 8}, 
    {7, 2, 3, 6, 2, 7}, 
    {7, 0, 8, 7, 6, 0, 6, 2, 0}, 
    {2, 7, 6, 2, 3, 7, 0, 1, 9}, 
    {1, 6, 2, 1, 8, 6, 1, 9, 8, 8, 7, 6}, 
    {10, 7, 6, 10, 1, 7, 1, 3, 7}, 
    {10, 7, 6, 1, 7, 10, 1, 8, 7, 1, 0, 8}, 
    {0, 3, 7, 0, 7, 10, 0, 10, 9, 6, 10, 7}, 
    {7, 6, 10, 7, 10, 8, 8, 10, 9}, 
    {6, 8, 4, 11, 8, 6}, 
    {3, 6, 11, 3, 0, 6, 0, 4, 6}, 
    {8, 6, 11, 8, 4, 6, 9, 0, 1}, 
    {9, 4, 6, 9, 6, 3, 9, 3, 1, 11, 3, 6}, 
    {6, 8, 4, 6, 11, 8, 2, 10, 1}, 
    {1, 2, 10, 3, 0, 11, 0, 6, 11, 0, 4, 6}, 
    {4, 11, 8, 4, 6, 11, 0, 2, 9, 2, 10, 9}, 
    {10, 9, 3, 10, 3, 2, 9, 4, 3, 11, 3, 6, 4, 6, 3}, 
    {8, 2, 3, 8, 4, 2, 4, 6, 2}, 
    {0, 4, 2, 4, 6, 2}, 
    {1, 9, 0, 2, 3, 4, 2, 4, 6, 4, 3, 8}, 
    {1, 9, 4, 1, 4, 2, 2, 4, 6}, 
    {8, 1, 3, 8, 6, 1, 8, 4, 6, 6, 10, 1}, 
    {10, 1, 0, 10, 0, 6, 6, 0, 4}, 
    {4, 6, 3, 4, 3, 8, 6, 10, 3, 0, 3, 9, 10, 9, 3}, 
    {10, 9, 4, 6, 10, 4}, 
    {4, 9, 5, 7, 6, 11}, 
    {0, 8, 3, 4, 9, 5, 11, 7, 6}, 
    {5, 0, 1, 5, 4, 0, 7, 6, 11}, 
    {11, 7, 6, 8, 3, 4, 3, 5, 4, 3, 1, 5}, 
    {9, 5, 4, 10, 1, 2, 7, 6, 11}, 
    {6, 11, 7, 1, 2, 10, 0, 8, 3, 4, 9, 5}, 
    {7, 6, 11, 5, 4, 10, 4, 2, 10, 4, 0, 2}, 
    {3, 4, 8, 3, 5, 4, 3, 2, 5, 10, 5, 2, 11, 7, 6}, 
    {7, 2, 3, 7, 6, 2, 5, 4, 9}, 
    {9, 5, 4, 0, 8, 6, 0, 6, 2, 6, 8, 7}, 
    {3, 6, 2, 3, 7, 6, 1, 5, 0, 5, 4, 0}, 
    {6, 2, 8, 6, 8, 7, 2, 1, 8, 4, 8, 5, 1, 5, 8}, 
    {9, 5, 4, 10, 1, 6, 1, 7, 6, 1, 3, 7}, 
    {1, 6, 10, 1, 7, 6, 1, 0, 7, 8, 7, 0, 9, 5, 4}, 
    {4, 0, 10, 4, 10, 5, 0, 3, 10, 6, 10, 7, 3, 7, 10}, 
    {7, 6, 10, 7, 10, 8, 5, 4, 10, 4, 8, 10}, 
    {6, 9, 5, 6, 11, 9, 11, 8, 9}, 
    {3, 6, 11, 0, 6, 3, 0, 5, 6, 0, 9, 5}, 
    {0, 11, 8, 0, 5, 11, 0, 1, 5, 5, 6, 11}, 
    {6, 11, 3, 6, 3, 5, 5, 3, 1}, 
    {1, 2, 10, 9, 5, 11, 9, 11, 8, 11, 5, 6}, 
    {0, 11, 3, 0, 6, 11, 0, 9, 6, 5, 6, 9, 1, 2, 10}, 
    {11, 8, 5, 11, 5, 6, 8, 0, 5, 10, 5, 2, 0, 2, 5}, 
    {6, 11, 3, 6, 3, 5, 2, 10, 3, 10, 5, 3}, 
    {5, 8, 9, 5, 2, 8, 5, 6, 2, 3, 8, 2}, 
    {9, 5, 6, 9, 6, 0, 0, 6, 2}, 
    {1, 5, 8, 1, 8, 0, 5, 6, 8, 3, 8, 2, 6, 2, 8}, 
    {1, 5, 6, 2, 1, 6}, 
    {1, 3, 6, 1, 6, 10, 3, 8, 6, 5, 6, 9, 8, 9, 6}, 
    {10, 1, 0, 10, 0, 6, 9, 5, 0, 5, 6, 0}, 
    {0, 3, 8, 5, 6, 10}, 
    {10, 5, 6}, 
    {11, 5, 10, 7, 5, 11}, 
    {11, 5, 10, 11, 7, 5, 8, 3, 0}, 
    {5, 11, 7, 5, 10, 11, 1, 9, 0}, 
    {10, 7, 5, 10, 11, 7, 9, 8, 1, 8, 3, 1}, 
    {11, 1, 2, 11, 7, 1, 7, 5, 1}, 
    {0, 8, 3, 1, 2, 7, 1, 7, 5, 7, 2, 11}, 
    {9, 7, 5, 9, 2, 7, 9, 0, 2, 2, 11, 7}, 
    {7, 5, 2, 7, 2, 11, 5, 9, 2, 3, 2, 8, 9, 8, 2}, 
    {2, 5, 10, 2, 3, 5, 3, 7, 5}, 
    {8, 2, 0, 8, 5, 2, 8, 7, 5, 10, 2, 5}, 
    {9, 0, 1, 5, 10, 3, 5, 3, 7, 3, 10, 2}, 
    {9, 8, 2, 9, 2, 1, 8, 7, 2, 10, 2, 5, 7, 5, 2}, 
    {1, 3, 5, 3, 7, 5}, 
    {0, 8, 7, 0, 7, 1, 1, 7, 5}, 
    {9, 0, 3, 9, 3, 5, 5, 3, 7}, 
    {9, 8, 7, 5, 9, 7}, 
    {5, 8, 4, 5, 10, 8, 10, 11, 8}, 
    {5, 0, 4, 5, 11, 0, 5, 10, 11, 11, 3, 0}, 
    {0, 1, 9, 8, 4, 10, 8, 10, 11, 10, 4, 5}, 
    {10, 11, 4, 10, 4, 5, 11, 3, 4, 9, 4, 1, 3, 1, 4}, 
    {2, 5, 1, 2, 8, 5, 2, 11, 8, 4, 5, 8}, 
    {0, 4, 11, 0, 11, 3, 4, 5, 11, 2, 11, 1, 5, 1, 11}, 
    {0, 2, 5, 0, 5, 9, 2, 11, 5, 4, 5, 8, 11, 8, 5}, 
    {9, 4, 5, 2, 11, 3}, 
    {2, 5, 10, 3, 5, 2, 3, 4, 5, 3, 8, 4}, 
    {5, 10, 2, 5, 2, 4, 4, 2, 0}, 
    {3, 10, 2, 3, 5, 10, 3, 8, 5, 4, 5, 8, 0, 1, 9}, 
    {5, 10, 2, 5, 2, 4, 1, 9, 2, 9, 4, 2}, 
    {8, 4, 5, 8, 5, 3, 3, 5, 1}, 
    {0, 4, 5, 1, 0, 5}, 
    {8, 4, 5, 8, 5, 3, 9, 0, 5, 0, 3, 5}, 
    {9, 4, 5}, 
    {4, 11, 7, 4, 9, 11, 9, 10, 11}, 
    {0, 8, 3, 4, 9, 7, 9, 11, 7, 9, 10, 11}, 
    {1, 10, 11, 1, 11, 4, 1, 4, 0, 7, 4, 11}, 
    {3, 1, 4, 3, 4, 8, 1, 10, 4, 7, 4, 11, 10, 11, 4}, 
    {4, 11, 7, 9, 11, 4, 9, 2, 11, 9, 1, 2}, 
    {9, 7, 4, 9, 11, 7, 9, 1, 11, 2, 11, 1, 0, 8, 3}, 
    {11, 7, 4, 11, 4, 2, 2, 4, 0}, 
    {11, 7, 4, 11, 4, 2, 8, 3, 4, 3, 2, 4}, 
    {2, 9, 10, 2, 7, 9, 2, 3, 7, 7, 4, 9}, 
    {9, 10, 7, 9, 7, 4, 10, 2, 7, 8, 7, 0, 2, 0, 7}, 
    {3, 7, 10, 3, 10, 2, 7, 4, 10, 1, 10, 0, 4, 0, 10}, 
    {1, 10, 2, 8, 7, 4}, 
    {4, 9, 1, 4, 1, 7, 7, 1, 3}, 
    {4, 9, 1, 4, 1, 7, 0, 8, 1, 8, 7, 1}, 
    {4, 0, 3, 7, 4, 3}, 
    {4, 8, 7}, 
    {9, 10, 8, 10, 11, 8}, 
    {3, 0, 9, 3, 9, 11, 11, 9, 10}, 
    {0, 1, 10, 0, 10, 8, 8, 10, 11}, 
    {3, 1, 10, 11, 3, 10}, 
    {1, 2, 11, 1, 11, 9, 9, 11, 8}, 
    {3, 0, 9, 3, 9, 11, 1, 2, 9, 2, 11, 9}, 
    {0, 2, 11, 8, 0, 11}, 
    {3, 2, 11}, 
    {2, 3, 8, 2, 8, 10, 10, 8, 9}, 
    {9, 10, 2, 0, 9, 2}, 
    {2, 3, 8, 2, 8, 10, 0, 1, 8, 1, 10, 8}, 
    {1, 10, 2}, 
    {1, 3, 8, 9, 1, 8}, 
    {0, 9, 1}, 
    {0, 3, 8}, 
    { }};
}
