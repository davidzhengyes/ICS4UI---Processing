
package newtonsmethod;


public class NewtonsMethod {

    public static double f( double x ) {
        return Math.sin(x);
    }
    
    public static double fPrime( double x ) {
        return Math.cos(x);
    }
    
    
    
    public static void main(String[] args) {
        
        double xn = Math.PI/2.1;
        
        while ( Math.abs( f(xn) ) > .0000000000001 ) {
            System.out.println(xn + "\t" + f(xn));
            xn = xn - f(xn) / fPrime(xn);
        }
    }
    
}
