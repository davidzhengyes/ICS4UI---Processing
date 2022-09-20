
package shortestpathfinder;

import java.util.ArrayList;

public class Node {
    
    int label;
    int multiplicity;
    ArrayList<Node> neighbours;
    ArrayList<Edge> edges;
    
    public Node() {
        this.neighbours = new ArrayList();
        this.edges = new ArrayList();
        this.multiplicity = 0;
    }
    
    
    public void printNeighbours() {
        System.out.print( "Node " + label + ": ");
        
        for (int i = 0; i < neighbours.size(); i++) 
            System.out.print( neighbours.get(i).label + " ");  
    }
    
    public int degree(){
        return neighbours.size();
    }
    
    public Node getEdgeMate( Edge e ) {
        if( e.node1.equals(this))
            return e.node2;
        else
            return e.node1;
    }
}
