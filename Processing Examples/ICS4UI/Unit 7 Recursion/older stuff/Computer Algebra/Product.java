// The "Product" class.
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
    
    public String Display()
    {
	return "(" + left.Display() + ")(" + right.Display() + ")";
    }
    
    public Expression Simplify()
    {
	if(left.GetType() == "constant" & right.GetType() == "constant")
	    return new Constant(left.GetValue() * right.GetValue());
	
	else
	{ 
	    Product simpleProduct = new Product(left.Simplify(), right.Simplify()); 
	    return simpleProduct.Simplify();
	}
    }


} // Product class
