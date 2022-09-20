package computeralgebraapp;

public class Product extends Expression
{
    Expression left;
    Expression right;
    
    public Product(Expression l, Expression r)
    {
	super("product");
	left = l;
	right = r;
    }
    
    public String display()
    {
	return "(" + left.display() + ")(" + right.display() + ")";
    }
    
    public Expression simplify()
    {
	if( left.getType().equals("constant") && right.getType().equals("constant") )
	    return new Constant( left.getValue() * right.getValue() );
	
	else
	{ 
	    Product simpleProduct = new Product(left.simplify(), right.simplify()); 
	    return simpleProduct.simplify();
	}
    }
} 
