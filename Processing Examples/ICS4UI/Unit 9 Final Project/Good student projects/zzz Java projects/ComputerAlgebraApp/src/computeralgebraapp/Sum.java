package computeralgebraapp;

public class Sum extends Expression
{
    Expression left;
    Expression right;

    int[] coefficients;

    public Sum (Expression l, Expression r)
    {
	super ("sum");
	left = l;
	right = r;
    }


    public String display ()
    {
	return left.display() + " + " + right.display();
    }


    public Expression simplify()
    {
	Expression simplifiedSum;

	int maxDegree = findMaxDegree(this);
	coefficients = new int[maxDegree+1];

	Constant constantTerm;
	Monomial variableTerms[] = new Monomial[maxDegree];
	
	//initialize array
	for (int i=0; i <= maxDegree; i++)
	{
	    coefficients[i]=0;
	}
	
	//Add up the coefficients in the expression tree
	addUpCoefficients(this);

	//Fill in the constant term
	constantTerm = new Constant( coefficients[0] );
	
	//Fill in the variable terms
	for (int i=0; i < maxDegree; i++)
	{
	    variableTerms[i] = new Monomial( coefficients[i+1], "x", i+1 );
	}

	//Build new expression
	simplifiedSum = new Sum(constantTerm, variableTerms[0]);
	
	for (int i=1; i < maxDegree; i++)
	{
	    simplifiedSum = simplifiedSum.add( variableTerms[i] );
	}

	return simplifiedSum;
    }


    public void addUpCoefficients( Expression e )
    {
	int currCoefficient;
	
	if ( e.getType().equals("constant") )
	    coefficients[0] = coefficients[0] + ((Constant) e).getValue();

	else if ( e.getType().equals("variable") )
	{
	    int currDegree = ((Monomial) e).getDegree();
	    coefficients[currDegree] = coefficients[currDegree] + ((Monomial) e).getCoefficient();
	}

	else if ( e.getType().equals("sum") )
	{
	    addUpCoefficients( ((Sum) e).left );
	    addUpCoefficients( ((Sum) e).right );   
	}
    }

} 
