class CylinderRow {  //Each instance of this class is a row of Cylinder objects.
  
  Cylinder[] cylinders = new Cylinder[cylindersPerRow*2];   //Array of cylinders that make up this cylinder row. As mentioned at the top of the main tab, 
                                                            //there are actually twice as many cylinders than the value of cylindersPerRow.
  
  float x, y; //This is the x and y value of the center of the leftmost cylinder in this row.
  
  //Constructor that generates the row of cylinders
  CylinderRow( float _x, float _y ) {
    
    //Read in the x and y value.
    this.x = _x;
    this.y = _y;
    
    //For loop that creates all the Cylinder objects in this row.
    for( int i=0; i<cylindersPerRow*2; i++ ) {
      float xC = this.x + i*cylinderRadius*4;  //The x value is increased by 4x the cylinder radius for each successive cylinder. This is because there is a cylinder wide gap between each cylinder. 2 radii come from the width of the cylinder, the other 2 come from the width of the gap, for a total of 4.
      float yC = this.y;   //The y value remains the same across the whole row.
      this.cylinders[i] = new Cylinder( xC, yC, 0, 0 ,0 , HALF_PI );  //Creates the cylinder. The half pi z rotation simply makes the cylinders start off being horizontal.  
    }
    
  }
  
  
  //Method for displaying this row.
  void display() {
    for( int i=0; i<this.cylinders.length; i++ ) {  //Simple for loop that just calls the .display() method for all of the cylinders in this row.
      this.cylinders[i].display();
    }
  }
  
  
  //Method for rotating this row.
  void rotate( float xR, float yR, float zR ) {
    for( int i=0; i<this.cylinders.length; i++ ) {  //Simple for loop that just calls the .rotate() method for all of the cylinders in this row.
      this.cylinders[i].rotate( xR, yR, zR );
    }
  }
  
  //Method that inverts this row.
  void invert() {
    for( int i=0; i<this.cylinders.length; i++ ) {  //Simple for loop that just multiplies the .inversion field by -1 for all of the cylinders in this row.
      this.cylinders[i].inversion *= -1;
    }
  }
 
}
