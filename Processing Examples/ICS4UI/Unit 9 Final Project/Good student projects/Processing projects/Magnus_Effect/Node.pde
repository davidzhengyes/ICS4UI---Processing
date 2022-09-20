class Node extends Ball{
  
  Node(PVector p, PVector v) {
    //Create a ball object that does not update to store historical data
    super(p, v, 0, new PVector(0, 0, 0), 0, 0.03, new Fluid(0));
  }
}