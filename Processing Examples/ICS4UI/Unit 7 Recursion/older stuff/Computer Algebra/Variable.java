// The "Variable" class.
public class Variable extends Expression
{
    private Integer coefficient;
    private String symbol;
    private Integer degree;

    public Variable (int coeff, String sym, int deg)
    {
	super ("variable");
	coefficient = new Integer (coeff);
	symbol = sym;
	degree = new Integer (deg);
    }


    public String Display ()
    {
	String coefficientDisplay;
	String symbolDisplay;
	String degreeDisplay;

	if (GetCoefficient () == 0)
	    return "";

	else
	{

	    if (GetCoefficient () == 1)
		coefficientDisplay = "";

	    else if (GetCoefficient () == -1)
		coefficientDisplay = "-";

	    else
		coefficientDisplay = coefficient.toString ();


	    if (GetDegree () == 0)
	    {
		symbolDisplay = "";
		degreeDisplay = "";
	    }

	    else if (GetDegree () == 1)
	    {
		symbolDisplay = symbol;
		degreeDisplay = "";
	    }

	    else
	    {
		symbolDisplay = symbol + "^";
		degreeDisplay = degree.toString ();
	    }



	    return coefficientDisplay + symbolDisplay + degreeDisplay;
	}
    }


    public int GetDegree ()
    {
	return degree.intValue ();
    }


    public String GetSymbol ()
    {
	return symbol;
    }


    public int GetCoefficient ()
    {
	return coefficient.intValue ();
    }


    public void AddUpCoefficients ()
    {
	int currDegree = GetDegree ();
	coefficients [currDegree] = coefficients [currDegree] + GetCoefficient ();
    }
} // Variable class


