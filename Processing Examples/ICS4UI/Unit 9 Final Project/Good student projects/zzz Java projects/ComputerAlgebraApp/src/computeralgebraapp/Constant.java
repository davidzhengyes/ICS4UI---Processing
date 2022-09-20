package computeralgebraapp;

public class Constant extends Expression
{
    Integer value;
    
    public Constant(int v)
    {
	super("constant");
	this.value = new Integer(v); 
    }
    
    public int getValue()
    {
	return value.intValue();
    }
    
    public void setValue(int v)
    {
	value = new Integer(v);
    }
    
    public String display()
    {
	return value.toString();
    }
    
    public boolean areLikeTerms(Expression e)
    {
	if ( e.getType().equals("constant") )
	    return true;
	else
	    return false;
    }
    
    public Expression simplify()
    {
	return this;
    }
} 
