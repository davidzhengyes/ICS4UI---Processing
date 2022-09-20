// The "Tester" class.
import java.awt.*;
import hsa.Console;

public class Tester
{
    static Console c;           // The output console
    
    public static void main (String[] args)
    {
	c = new Console ();
	
	Constant c1 = new Constant(1);
	Constant c2 = new Constant(2);
	Constant c3 = new Constant(3);
	
	Variable v1 = new Variable(1,"a",1);
	Variable v2 = new Variable(2,"b",1);
	Variable v3 = new Variable(1,"c",2);
	Variable v4 = new Variable(3,"d",2);
	Variable v5 = new Variable(5,"e",0);

	Expression e1 = c1.Add(v1).Add(v2).Add(v3).Add(v4).Add(v5); 
	
	c.println(e1.Display());
	//c.println(e1.CollectLikeTerms().Display()); 
	
	// Place your program here.  'c' is the output console
    } // main method
} // Tester class
