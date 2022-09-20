class Point2D {
    int x, y;
    boolean visited; //might need this in the convex hull finding algorithm
    color col;
    
   Point2D(int x, int y) {
        this.x = x;
        this.y = y;
        this.visited = false;
        this.col = color(255,255,0);
    }
    
   void printMe() {
     println("("+this.x+","+this.y+")");
   }
}
