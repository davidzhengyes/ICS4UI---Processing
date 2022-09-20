package computeralgebraapp;

public class Expression
{
    String type;
	
    public Expression( String t)
    {
	this.type = t;
    }
    
    public Expression add( Expression e )
    {
	return new Sum(this, e);
    }
    
    public Expression multiply(Expression e)
    {
	return new Product(this, e);
    }
    
    public String display()
    {
	return null;
    }
    
    public Expression simplify()
    {
	return this;
    }
    
    public String getType()
    {
	return type;
    }
    
    public int getValue()
    {
	return 0;
    }
    
    public void setType(String t)
    {
	type = t;
    }
    
    public static int findMaxDegree (Expression e)
    {
	if ( e.getType().equals("constant") )
	    return 0;

	else if (e.getType ().equals("variable") )
	    return ((Monomial) e).getDegree ();

	else if (e.getType () == "sum")
	{
	    int maxDegreeLeft = findMaxDegree (((Sum) e).left);
	    int maxDegreeRight = findMaxDegree (((Sum) e).right);

	    return Math.max (maxDegreeLeft, maxDegreeRight);
	}
	
	else 
	    return 0;
    }    
} 

