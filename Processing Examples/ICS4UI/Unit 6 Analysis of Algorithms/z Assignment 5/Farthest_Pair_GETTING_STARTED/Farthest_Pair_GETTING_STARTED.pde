int pointSize = 12;
int numPoints = 50;
     
Point2D[] S = new Point2D[ numPoints ]; //the set S
Point2D[] farthestPair = new Point2D[ 2 ]; //the two points of the farthest pair
     
ArrayList<Point2D> convexHull = new ArrayList(); //the vertices of the convex hull of S
     
color convexHullColour = color(255);
color genericColour = color(255,255,0);


void setup( ) {
    //no changes are needed in setup().  Just code the blank methods above.
    
    background(0);
    size(800, 800);
    
    makeRandomPoints();
    findConvexHull();        
    findFarthestPair_EfficientWay();        
}

    
    //fills S with random points
void makeRandomPoints() {
    for (int i = 0; i < numPoints; i++) {
        int x = 50 + (int) random(0,500);
        int y = 50 + (int) random(0,500);
        S[i] = new Point2D( x, y );            
    }        
}

void draw() {        
    //draw the points in S
    
    //draw the points in the convex hull
    
    //draw a red line connecting the farthest pair
}
    
    
void findConvexHull() {
    //code this
    //you'll need to make use of the Vector class to help calculate angles in 2D
}
    
void findFarthestPair_EfficientWay() {
    //code this
    //must make use of the convex hull, which will have been calculated by the time this method is called
}
    
void findFarthestPair_BruteForceWay() {
    //code this just for fun, to see how many more distance calculations and comparisons it does than the efficient way
}
    
   
   
