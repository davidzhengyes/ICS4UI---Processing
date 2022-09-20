// The "Constant" class.

//import Expression.class;

public class Constant extends Expression
{
    Integer value;

    public Constant (int v)
    {
	super ("constant");
	value = new Integer (v);

    }


    public int GetValue ()
    {
	return value.intValue ();
    }


    public int GetDegree ()
    {
	return 0;
    }


    public String Display ()
    {
	if (GetValue () == 0)
	    return "";
	else
	    return value.toString ();
    }


    public void AddUpCoefficients ()
    {
	coefficients [0] = coefficients [0] + GetValue ();
    }
} // Constant class
