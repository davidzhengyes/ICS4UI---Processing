
package shortestpathfinder;

import java.util.ArrayList;

public class Graph {
    
    Node[] V; 
    ArrayList<Double>[][] AdjacencyMatrix;
    int numEdges;
    
    public Graph(Node[] v) {
        this.V = v; 
        setLabels();  
        numEdges = 0;
    }
    
    
    public void setLabels() {        
        for (int i = 0; i < V.length; i++) 
            V[i].label = i;        
    }
    
    
    public Double getResistance( Node n1, Node n2 ) {
        int i = n1.label;
        int j = n2.label;
        
        if ( i < j )
            return this.AdjacencyMatrix[i][j].get(0);
        
        else 
            return this.AdjacencyMatrix[j][i].get(0);
    }
    
    
    public void addEdge( int i, int j, Double resistance ) {  //used when building the graph from a file
        
        V[i].neighbours.add( V[j] );
        V[j].neighbours.add( V[i] );
        numEdges++;
        
        //Since the adjacency matrix is symmetric, we use only the upper-right half of it (including the diagonal) to store edges
        if ( i < j ) 
            this.AdjacencyMatrix[i][j].add( resistance );
        
        else 
            this.AdjacencyMatrix[j][i].add( resistance );
    }
    
    
    public void addEdge( Node n1, Node n2, Double resistance ) { //used when spanning a new edge across an intermediate node.
        //System.out.println("Adding a NEW edge between " + n1.label + "," + n2.label);
        int i = n1.label;
        int j = n2.label;
        this.addEdge( i, j, resistance );
    }

    
   
    public void deleteEdge( int i, int j ) {  //used when there's only 1 edge between the nodes    
        V[i].neighbours.remove( V[j] );
        V[j].neighbours.remove( V[i] );  
        numEdges--;
        
        if ( i < j )
            this.AdjacencyMatrix[i][j].remove( 0 );  //0 meaning the index of the first (and only) edge from i to j.

        else
            this.AdjacencyMatrix[j][i].remove( 0 ); 
    }
    
    
    public void deleteEdge( Node n1, Node n2 ) {  //used when there's only 1 edge between the nodes
        int i = n1.label;
        int j = n2.label;
        this.deleteEdge(i, j);
    }

    
    public void deleteMultiedge( int i, int j ) { //deletes all edges between nodes i and j
        if ( i < j ) 
            while( this.AdjacencyMatrix[i][j].size() > 0 )
                this.deleteEdge(i, j);        
        
        else 
            while( this.AdjacencyMatrix[j][i].size() > 0 )
                this.deleteEdge(j, i);
        
    }
    
    
    public void print() {
        for (int i = 0; i < V.length; i++) {
            V[i].printNeighbours();
            System.out.println("");
        }
    }  
}
