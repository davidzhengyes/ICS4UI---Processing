import g4p_controls.*;  //Import g4p library. This is used for making the GUI.

int cylinderDetail = 24;  //The cylinders are actually just polygonal prisms. The amount of sides on the base of this prism is the value of this variable minus one. The higher this value is, the closer the prisms will resemble actual cylinders.
int cylindersPerRow = 4;  //This number is how many cylinders are in each row. Default is 4 to make it look like a chess board. There's actually double this amount of cylinders in each row, because the rows extend off-screen. this is to prevent empty space coming into frame when the screen rotates. 
int frameRate = 30;  //Frame rate

float cylinderRadius;   //The radius of a cylinder and also half of its height.
PShape cylinderTube;    //PShape defining the curved "tube like" surface of the cylinder
PShape cylinderTop;     //PShape defining the circlular face on the top of the cylinder
PShape cylinderBottom;  //PShape defining the circlular face on the bottom of the cylinder
PShape cylinder;        //PShape that will group the 3 PShapes above. Used so that shape() only needs to be called once on cylinder rather than 3 times on cylinderTube, cylinderTop, and cylinderBottom.
                        //Using these PShapes makes the program way more efficient because the vertices of a cylinder only need to be defined once and don't need to be defined for every individual one.

float xRotSpeed, yRotSpeed, zRotSpeed;  //These variables keep track of the rotation speed of the cylinders around the 3 axes
float screenRotSpeed;    //This variable keeps track of the rotation speed of the screen
float screenAngle = 0;   //This variable keeps track of the current rotation angle of the screen in


color bgColor = color( 13, 11, 20 );  //This is the color of the background of the animation
color tubeColor = color( 65, 60, 72 );  //This is the color of the tube part of the cylinder
color topBottomColor = color( 24, 23, 31 );  //This is the color of the top and bottom of the cylinder

//These variables are part of the GUI. Whenever the value of one of the interactables of the GUI is changed, instead of immediately assigning its value to its associated variable, 
//one of these booleans will be set to true. The value will only be assigned at the beginning of the next frame. This is required because changing the values of variables midway
//through the calculations of a frame can cause cylinders to go out of sync.
boolean needToGetSpeed = false;
boolean needToResetO = false;
boolean needToResetR = false;
boolean needToSetQG = false;

//These booleans are also part of the GUI and toggle certain options.
boolean paused = false;  //Toggles animation being paused
boolean stroke = false;  //Toggles shape outlines being drawn
boolean inverted = false;  //Toggles whether alternating rows will be inverted.

CylinderRow[] rows; //The array of cylinder rows that makes up the full grid of cylinders


void setup() {
  
  createGUI();    //Create the GUI
  size(600, 600, P3D);   //P3D makes processing use the 3D renderer for this animation. This is needed because the cylinders are 3D objects.
  ortho();    //ortho() changes the viewing persepctive for 3D objects to orthographic and prevents foreshortening. This is required to achieve the effect of making the cylinders form a chess board.
  frameRate(frameRate);  //Sets the frame rate
  
  defineCylinderShape(); //This function defines the all the vertices and colors for the cylinder PShape.
  resetO();    //This function initializes the whole grid of cylinders (it also can be called again to reset the grid orientation, hence its name)
  
}

void draw() {
  
  updateGUI();    //Get values from the GUI and runs any methods that were marked by the GUI to be run at the beginning of this frame
  background( bgColor );    //Clear the screen
  
  
  translate( width/2.0, height/2.0 );  //Translate the origin to the center of the screen so the screen is rotated around its center instead of its topleft corner.
  rotateZ( screenAngle );  //Rotate by the current screen angle.
  translate( -width/2.0, -height/2.0 );  //Translate the origin back to (0,0) so the cylinders can be drawn properly.
  
  for( int i=0; i<rows.length; i++ ) {  //For loop displaying each row and rotating them.
    rows[i].display();  //Display the row.
    rows[i].rotate( xRotSpeed, yRotSpeed, zRotSpeed );    //Rotate the row by the current rotation speed.
  }
  screenAngle += screenRotSpeed;    //Increase the screen angle by the screen rotation speed.

  
}

//Function for defining the vertices and colors for the cylinder PShape
void defineCylinderShape() {
  
  //Define the cylinder radius based on the number of cylinders per row and the screen width
  cylinderRadius = width/float(cylindersPerRow*4);  
  
  //Initialize the three shapes that make up the cylinder
  cylinderTube = createShape();
  cylinderTop = createShape();
  cylinderBottom = createShape();
  
  //Set their colors
  cylinderTube.setFill( tubeColor );
  cylinderTop.setFill( topBottomColor );
  cylinderBottom.setFill( topBottomColor );
  
  //Call .beginShape() so that we can start defining vertices.
  cylinderTube.beginShape(QUAD_STRIP);  //QUAD_STRIP defines this shape as a strip of quadrilaterals. This quad strip is curved around a circle to form the tube. Turn on "Draw shape mesh" in the GUI and you can more clearly see what it looks like.
  cylinderTop.beginShape();
  cylinderBottom.beginShape();
  
  float angle = 360.0 / (cylinderDetail-1); //This angle is the angle between n equally spaced vertices around a circle where n = cylinderDetail-1 
  for (int i = 0; i < cylinderDetail; i++) {  //The for loop loops cylinderDetail times instead of cylinderDetail-1 times so that the last vertices will be coincident with the first vertices. This allows the shape to be closed (.endShape(CLOSE) doesn't work with QUAD_STRIP type shapes).
    
    //x and z values for points around a circle
    float x = cos(radians(i * angle)) * cylinderRadius;  
    float z = sin(radians(i * angle)) * cylinderRadius;  
    
    //Add the vertices for the tube
    cylinderTube.vertex(x, cylinderRadius, z);
    cylinderTube.vertex(x, -cylinderRadius, z);
    
    //Add the vertices for the top and bottom
    cylinderTop.vertex(x, cylinderRadius, z);
    cylinderBottom.vertex(x, -cylinderRadius, z);
  }
  
  //All required vertices have been defined, so .endShape() can be called.
  cylinderTube.endShape();
  cylinderTop.endShape();
  cylinderBottom.endShape();

  cylinder = createShape(GROUP);  //Grouping together the 3 PShape objects.
  cylinder.addChild(cylinderTube);
  cylinder.addChild(cylinderTop);
  cylinder.addChild(cylinderBottom);
  
  cylinder.setStroke(stroke);  //Sets whether or not cylinder outlines should be drawn. 
  
}


//This function exists because changes to values in the GUI should only be applied in between loops of draw(). 
//If the GUI changes were applied halfway through a loop of draw(), the cylinders could go out of sync with each other.
//Since everything is in if statements, the program is more efficient and will only need to get values when they're changed, rather than simply constantly checking on them.
void updateGUI() {   
  
  if( needToGetSpeed ) {  //Only runs if changes were made to the sliders and they need to be applied.
    needToGetSpeed = false;  //Note that we no longer need to update the rotation speed values after this.
    getSpeedValues();    //Function that assigns the slider values to the rotation speed values.
  }
  
  if( needToResetO ) {   //Only runs if the Reset Orientation button was pressed last frame and the reset needs to be applied.
    needToResetO = false;    //Note that we no longer need to reset after this.
    resetO();    //Reset the orientation
  }
  
  if( needToResetR ) {   //Only runs if the Reset Rotation Speed button was pressed last frame and the reset needs to be applied. 
    needToResetR = false;    //Note that we no longer need to reset after this.
    resetR();    //Reset the rotation speed
  }
  
  if( needToSetQG ) {    //Only runs if the Queen's Gambit Settings button was pressed last frame and the settings need to be applied.
    needToSetQG = false;    //Note that we no longer need to apply the settings after this.
    setQG();    //Apply the Queen's Gambit settings
  }
  
  if( stroke != strokeBox.isSelected() ) {    //Only runs if the "Draw shape outlines" box was clicked and the change needs to be applied.
    stroke = strokeBox.isSelected();    //Set stroke to match the check box
    cylinder.setStroke(stroke);    //Turn the shape outline on/off
  }
  
  if( inverted != invertBox.isSelected() ) {    //Only runs if the "Invert alternating rows" box was clicked and the change needs to be applied.
    inverted = invertBox.isSelected();    //Set inverted to match the check box
    for( int i=0; i<rows.length; i++ ) {    //Loop through every row
      if( i%2 == 0 ) {      //If a row has an even index
        rows[i].invert();    //Then invert that row
      }
    }
  }
  
}

//Function that assigns the slider values to the rotation speed values.
void getSpeedValues() {
  
  //Get the values from the sliders in the GUI and store them into their respective variables
  xRotSpeed = xRotation.getValueF();
  yRotSpeed = yRotation.getValueF();
  zRotSpeed = zRotation.getValueF();
  screenRotSpeed = screenRotation.getValueF();
  
  //The GUI is in degrees/second because these units are more familiar to most users. 
  //The rotation speed values are being converted into radians/frame as this is what the program uses for its calculations.
  xRotSpeed = radians(xRotSpeed)/frameRate;
  yRotSpeed = radians(yRotSpeed)/frameRate;
  zRotSpeed = radians(zRotSpeed)/frameRate;
  screenRotSpeed = radians(screenRotSpeed)/frameRate;
  
}

//Initializer and orientation resetter.
void resetO() {
  
  screenAngle = 0;  //Resets the screen's orientation
  inverted = false;  //Initializes the alternating rows as uninverted (they will still get inverted later if the box is checked)
  
  rows = new CylinderRow[cylindersPerRow*4];  //Since half of a row is empty space, there are 2x as many rows as there are cylinders in a row, thus the array of rows is of size cylindersPerRow*4 
  for( int i=0; i<cylindersPerRow*4; i++ ) { 
    float x = -width/2 + cylinderRadius + i%2*cylinderRadius*2;  //Rows extend an extra half screen width to the left and right off screen. This is where the -width/2 comes from. 
                                                                 //Since this x value is of the center and not the left side of the leftmost cylinder, we add cylinderRadius. 
                                                                 //Even indexed rows are staggered by a cylinder width to create the checker pattern so i%2*cylinderRadius*2 is added.
    float y = -height/2 + cylinderRadius + i*cylinderRadius*2;   //The grid starts from half a screen height above the screen and goes to half a screen height under the screen. This is where the -height/2 comes from.
                                                                 //This is once again the center of the cylinder, not the top, so cylinderRadius is added.
                                                                 //Each row is one cylinder width lower than the last so i*cylinderRadius*2 is added.
    
    rows[i] = new CylinderRow( x, y );  //Creates the rows.
  }
  
}

//Resets rotation speeds 
void resetR() {
  //Sets all the rotation speed sliders back to zero
  xRotation.setValue(0);
  yRotation.setValue(0);
  zRotation.setValue(0);
  screenRotation.setValue(0); 
}

//Changes the settings to match the closing credits of The Queen's Gambit
void setQG() {
  
  //Reset orientation
  resetO();    
  
  //Set the slider values to the specific settings which match The Queen's Gambit
  //I got these speeds by timing the clip and roughly measuring the angles rotated
  xRotation.setValue(0);
  yRotation.setValue(70);
  zRotation.setValue(0);
  screenRotation.setValue(34);
  
  //Assign the rotation speed values to their variables.
  //I'm setting each one manually here instead of calling getSpeedValues() because calling .getValueF() immediately after .setValue() doesn't behave properly and gets the value
  //of the slider from before .setValue() is called.
  xRotSpeed = radians(0)/frameRate;
  yRotSpeed = radians(70)/frameRate;
  zRotSpeed = radians(0)/frameRate;
  screenRotSpeed = radians(34)/frameRate;
  
  //Turn off shape outlines and turn on alternate row inverting.
  strokeBox.setSelected( false );
  invertBox.setSelected( true );
}
