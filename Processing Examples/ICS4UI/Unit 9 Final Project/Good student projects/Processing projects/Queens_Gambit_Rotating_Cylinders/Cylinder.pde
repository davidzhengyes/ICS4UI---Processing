class Cylinder {  //Each instance of this class is an individual cylinder.
  
  float x, y, z;  //These define the location of the cylinder through x, y and z values of the center of the cylinder.
  float xRotation, yRotation, zRotation;   //These define the orientation of the cylinder through how much it is being rotated around the x, y and z axes.
  int inversion = 1;  //When the cylinder is inverted, this value will be -1;
  
  //Simple constructor that just reads in values for the cylinder's location and orientation.
  Cylinder( float _x, float _y, float _z, float _xRotation, float _yRotation, float _zRotation ) {
    this.x = _x;
    this.y = _y;
    this.z = _z;
    this.xRotation = _xRotation;
    this.yRotation = _yRotation;
    this.zRotation = _zRotation;
  }
  
  //Method used to rotate the cylinder. The cylinder's current rotation will be changed based on the parameters specified when this method is called.
  void rotate( float xR, float yR, float zR ) {
    xRotation += xR;
    yRotation += yR;
    zRotation += zR;
  }
  
  //Method used to display the cylinder onto the screen.
  void display() {  
    pushMatrix();  //Save the current tranformation matrix so it can be restored later.
    translate( this.x, this.y, this.z );  //Translate the cylinder from the origin to its desired location.
    rotateX( this.xRotation * inversion );  //Rotate the cylinder around the x-axis by its current rotation angle around the x-axis.
    rotateY( this.yRotation * inversion );  //Rotate the cylinder around the y-axis by its current rotation angle around the y-axis.
    rotateZ( this.zRotation * inversion );  //Rotate the cylinder around the z-axis by its current rotation angle around the z-axis.
                                            //If the cylinder is inverted, the rotations will be counterclockwise instead of clockwise.
    shape(cylinder);  //Draws the cylinder to the screen.
    popMatrix();  //Restore the previously saved transformation matrix. This ensures that the transformations used to draw this cylinder will not affect the drawing of anything else
  }
  
}
