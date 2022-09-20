
package shortestpathfinder;


public class Edge {
    
    Node node1, node2;
    Double resistance;
    
    public Edge( Node v, Node w, Double r ) {
        this.node1 = v;
        this.node2 = w;
        this.resistance = r;
        
        this.node1.edges.add( this );
        this.node2.edges.add( this );
        
        this.node1.neighbours.add( node2 );
        this.node2.neighbours.add( node1 );
    }
    
    
    public boolean is(Node a, Node b) {
        if (node1.equals(a) && node2.equals(b))
            return true;
        
        else if (node1.equals(b) && node2.equals(a)) 
            return true;
        
        else
            return false;
    }
}
