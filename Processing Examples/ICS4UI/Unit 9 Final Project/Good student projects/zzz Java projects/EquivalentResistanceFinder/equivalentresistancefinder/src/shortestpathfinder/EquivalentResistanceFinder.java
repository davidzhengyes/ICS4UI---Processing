
package shortestpathfinder;

import java.util.Scanner;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;


public class EquivalentResistanceFinder {
    
    Graph G; 
   
    public static void printArray(int[]a) {
        for (int i = 0; i < a.length; i++) 
            System.out.print(a[i] + " ");                    
    }
    
    //FILLS THE DATA STRUCTURE G USING DATA FROM AN INPUT FILE THAT SPECIFIES
    //THE CONNECTIONS AND THE RESISTANCES
    public Graph getGraphFromFile( String fileName ) throws IOException {
        
        FileReader f = new FileReader( fileName );
        Scanner s = new Scanner(f);
        
        int numNodes = s.nextInt();
        
        Node[] N = new Node[ numNodes ];
        
        for (int i = 0; i < numNodes; i++)
            N[i] = new Node();
               
        Graph G = new Graph( N );
        G.AdjacencyMatrix = new ArrayList[numNodes][numNodes];
        
        for (int i = 0; i < N.length; i++) 
            for (int j = 0; j < N.length; j++) 
                G.AdjacencyMatrix[i][j] = new ArrayList<Double>();
        
        while( s.hasNext() ) {
            int node1 = s.nextInt();
            int node2 = s.nextInt();
            Double resistance = s.nextDouble();
        
            G.addEdge( node1, node2, resistance );           
        }
        
        return G;
    }
    
    
    public void reportEquivalentResistance( int i, int j ) {
        Node a = G.V[i];
        Node b = G.V[j];
        System.out.println( "\nEquivalent resistance = " + ER( a, b ) +"\n" );
    }
    
    
    //RECURSIVE ALGORITHM FOR FINDING THE EQUIVALENT RESISTANCE FROM NODE a TO NODE b
    public double ER( Node a, Node b ) {
        System.out.println("");
        
        System.out.println("Calling E(" + a.label + ", " + b.label + ")");
        
 	/********************
	 *** BASE CASES
	 ********************/
        
        if ( a.equals(b) )
            return 0;

        //IF THE CIRCUIT IS JUST A SINGLE EDGE BETWEEN a AND b, THEN JUST RETURN THE RESISTANCE BETWEEN THEM 
        if ( G.numEdges == 1 ) {             
            if (a.degree() == 1 && b.degree() == 1  ) {
                System.out.println("G is just a single edge " + a.label + "-->" + b.label + " with resistance " + G.getResistance(a, b));
                return G.getResistance(a, b);
            }
        }
        
        //IF NODE a OR b IS SEPARATED FROM THE REST OF THE CIRCUIT, THE RESISTANCE IS INFINITE
        if ( a.degree() == 0 ) {
            System.out.println("Node " + a.label + " has deg 0");
            return Double.POSITIVE_INFINITY;
        }
        
        if ( b.degree() == 0 ) {
            System.out.println("Node " + b.label + " has deg 0");
            return Double.POSITIVE_INFINITY;
        }
        
        
	/********************
	 *** RECURSIVE CASES
	 ********************/

        //DELETE ALL STRAY DEGREE-1 NODES THAT AREN'T a OR b.
        for (int i = 0; i < G.V.length; i++) {
            Node x = G.V[i];
            
            if ( x.degree() == 1 && !x.equals(a) && !x.equals(b) ) {
                Node y = x.neighbours.get(0);
                System.out.println("Deleting extraneous edge" + x.label + "-->" + y.label);
                G.deleteEdge( x, y );
                return ER(a,b);  //IN OTHER WORDS, START OVER. THE GRAPH IS NOW SLIGHTLY SIMPLER
            }
        }
               
        //SIMPLIFY INTERNAL EDGES
        for (int i = 0; i < G.V.length; i++) {
            Node x = G.V[i];
            
            //Eliminate loop edges, if any
            if ( G.AdjacencyMatrix[i][i].size() > 0 ) {  
                G.AdjacencyMatrix[i][i].remove(0); 
                System.out.println( "Deleting loop edge at Node " + i);
                return ER( a, b ); //immediately start over by returning ER(a,b)
            }
            
            //Reduce 2 resistors in series to 1 resistor 
            if ( x.degree() == 2 && !x.equals(a) && !x.equals(b) ) {
                Node n1 = x.neighbours.get(0); 
                Node n2 = x.neighbours.get(1); 
                
                if( ! n1.equals(n2) ) { //if the two edges of x don't lead to the same node, then bridge n1 to n2 over x
                    Double r1 = G.getResistance( x, n1 );
                    Double r2 = G.getResistance( x, n2 );                

                    System.out.println("2 resistors in series found! " + n1.label + "-->" + x.label + "-->" + n2.label + 
                                        ".  Reducing to a single edge " + n1.label + "-->" + n2.label + " with resistance " + (r1+r2));

                    G.deleteEdge( n1, x );
                    G.deleteEdge( x, n2 );
                    G.addEdge( n1, n2, r1+r2 );

                    return ER(a, b); //START OVER. THE GRAPH IS NOW SLIGHTLY SIMPLER
                }
            } 
                                  
            //Reduce resistors in parallel to 1 resistor using the parallel formula
            for (int j = 0; j < G.V.length; j++) {
                int numEdgesFromItoJ = G.AdjacencyMatrix[i][j].size();
                
                if( numEdgesFromItoJ > 1 ) {
                    Double denominator = 0.0;
                    
                    for ( int k = 0; k < numEdgesFromItoJ; k++ ) {
                        Double r = G.AdjacencyMatrix[i][j].get( k ); //resistance of the kth edge of the multiedge between i and j
                        denominator += 1/r;                        
                    }
                    
                    Double equivalentResistanceOfMultiedge = 1/denominator; //the equivalent resistance of the parallel resistors
                    
                    G.deleteMultiedge(i, j); //delete all edges between i and j
                    G.addEdge( i, j, equivalentResistanceOfMultiedge );  //replace them with a single edge that has the equivalent parallel resistance
                    System.out.println("Resistors in parallel found! " + i + "-->" + j + " Reducing to a single edge with resistance " + equivalentResistanceOfMultiedge);
 
                    return ER(a, b);
                }              
            }                                    
        } 
        
        
        //FUSE TWO NODES IF THEY'RE JOINED BY A ZERO-RESISTANCE WIRE
        for (int i = 0; i < G.V.length; i++) {
            for (int j = 0; j < G.V.length; j++) {
                if (G.AdjacencyMatrix[i][j].size() == 1) { //...if there is an edge between i and j...
                   if (G.AdjacencyMatrix[i][j].get(0) == 0) { //...if that edge has 0 resistance (i.e. is just a wire)
                       
                       Node n1; //the node we'll keep
                       Node n2; //the node that will be eliminated
                       
                       if ( G.V[j].equals(b) ) { //If node b is one of them, eliminate the other one
                            n1 = G.V[j];
                            n2 = G.V[i];
                        }
                       
                       else { 
                           n1 = G.V[i];
                           n2 = G.V[j];
                       }
                        G.deleteEdge(n1, n2); //delete the 0-edge between nodes n1 and n2
                        System.out.println("Deleting 0-resitance edge " + i + ", " + j);
   
                       
                       //REROUTE ALL EDGES ADJACENT TO n2 TO n1
                       while(n2.neighbours.size() > 0) {
                           Node x = n2.neighbours.get(0);                          
                           Double r = G.getResistance(n2, x);
                           G.deleteEdge(n2, x);
                           G.addEdge(x, n1, r);
                           System.out.println("Bypassing 0-edge by rerouting " + x.label + " to " + n1.label + " with resistance " + r);                           
                       } 
                       
                       return ER(a, b);                       
                   }                
                }                    
            }               
        }
                       
        //IF WE HAVEN'T RETURNED BY NOW, THEN WE DON'T KNOW HOW TO COMPUTE RESISTANCE FOR THIS CIRCUIT, SO RETURN -1
        return -1;  
              
    } //end function
        
      
        
    public static void main(String[] args) throws IOException {
        EquivalentResistanceFinder erf = new EquivalentResistanceFinder();
        
        //erf.G = erf.getGraphFromFile( "Simple parallel.txt" );
        //erf.G = erf.getGraphFromFile( "A to B one edge.txt" );
        //erf.G = erf.getGraphFromFile( "Two parallels in series.txt" );
        //erf.G = erf.getGraphFromFile( "A connects to B via two routes.txt");
        
       erf.G = erf.getGraphFromFile( "Example 1.txt" );
       erf.G.print();        
       erf.reportEquivalentResistance(0, 6);
    }
}
