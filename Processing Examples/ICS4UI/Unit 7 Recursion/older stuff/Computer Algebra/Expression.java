// The "Expression" class.
import java.awt.*;
import hsa.Console;

public class Expression
{
    String type;
    public static int[] coefficients;

    public Expression (String t)
    {
	type = t;
    }


    public Expression Add (Expression e)
    {
	return new Sum (this, e);
    }


    public Expression Multiply (Expression e)
    {
	return new Product (this, e);
    }


    public String Display ()
    {
	return null;
    }


    public String GetType ()
    {
	return type;
    }


    public int GetValue ()
    {
	return 0;
    }


    public int GetDegree ()
    {
	return 0;
    }


    public void AddUpCoefficients ()
    {
    }


    public Expression CollectLikeTerms ()
    {
	//Expression expandedExpression = Expand(this);
	Expression simplifiedSum;

	int maxDegree = GetDegree ();
	coefficients = new int [maxDegree + 1];

	Constant constantTerm;
	Variable variableTerms[] = new Variable [maxDegree];


	//initialize array
	for (int i = 0 ; i <= maxDegree ; i++)
	{
	    coefficients [i] = 0;
	}


	//Add up the coefficients in the expression tree
	AddUpCoefficients ();


	//Fill in the simplied terms
	constantTerm = new Constant (coefficients [0]);

	for (int i = 0 ; i < maxDegree ; i++)
	{
	    variableTerms [i] = new Variable (coefficients [i + 1], "x", i + 1);
	}


	//Build new expression
	simplifiedSum = new Sum (constantTerm, variableTerms [0]);

	for (int i = 1 ; i < maxDegree ; i++)
	{
	    simplifiedSum = simplifiedSum.Add (variableTerms [i]);
	}

	return simplifiedSum;
    }

} // Expression class

