package computeralgebraapp;

public class Monomial extends Expression
{

    Integer coefficient;
    String symbol;
    Integer degree;

    public Monomial (int coeff, String sym, int deg)
    {
	super ("variable");
	coefficient = new Integer (coeff);
	symbol = sym;
	degree = new Integer (deg);
    }
    

    public String display ()
    {
        String result;
        
        if (coefficient.intValue() == 0) 
            return "0";
        
        else if (coefficient.intValue() == 1) 
            if (degree.intValue() == 1) 
                return symbol;
            else
                return symbol + "^" + degree.toString();
        
        else if (degree.intValue() == 1) 
            return coefficient.toString() + symbol;
        
        else
            return coefficient.toString() + symbol + "^" + degree.toString();
    }


    public int getDegree ()
    {
	return degree.intValue();
    }

    
    public String getSymbol()
    {
	return symbol;
    }


    public int getCoefficient ()
    {
	return coefficient.intValue();
    }


    public boolean areLikeTerms (Expression e)
    {
	if ( e.getType().equals("variable") )
	{
	    if (((Monomial)(e)).getDegree() == this.getDegree ())
		return true;
            
	    else
		return false;
	}
	
	else
	    return false;
    }


    public Expression simplify ()
    {
	return this;
    }
} 
