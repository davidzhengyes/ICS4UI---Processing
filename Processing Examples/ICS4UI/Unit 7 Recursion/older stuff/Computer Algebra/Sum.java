// The "Sum" class.

import java.awt.*;
import hsa.Console;

public class Sum extends Expression
{
    Expression left;
    Expression right;
    //static Console c = new Console ();

    public Sum (Expression l, Expression r)
    {
	super ("sum");
	left = l;
	right = r;
    }


    public String Display ()
    {
	return left.Display () + " + " + right.Display ();
    }


    public int GetDegree ()
    {
	int maxDegreeLeft = left.GetDegree ();
	int maxDegreeRight = right.GetDegree ();
	return Math.max (maxDegreeLeft, maxDegreeRight);
    }


    public void AddUpCoefficients ()
    {
	left.AddUpCoefficients ();
	right.AddUpCoefficients ();
    }



} // Sum class
