
package computeralgebraapp;


public class ComputerAlgebraApp {

    
    public static void main(String[] args) {
        Constant c1 = new Constant(1);
	Constant c2 = new Constant(2);
	Constant c3 = new Constant(3);
	
	Monomial v1 = new Monomial(1,"x",1);
	Monomial v2 = new Monomial(3,"x",1);
	Monomial v3 = new Monomial(4,"x",2);
	Monomial v4 = new Monomial(-7,"x",2);
	Monomial v5 = new Monomial(5,"x",3);
        
        System.out.println(v4.display());

	Expression e1 = c1.add(v1).add(c2).add(v2).add(c3).add(v1).add(v4).add(v1).add(v5).add(v5).add(c1); 
	
	System.out.println( e1.display() );
	System.out.println( e1.simplify().display() ); 	
    }
    
}
