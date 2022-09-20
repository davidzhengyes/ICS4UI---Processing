package icsfinalproject;

public class comNum 
{
    double imaNum, realNum;
    
    // Creates parameters for complex number class.
    public comNum (double x, double y)
    {
        realNum = x;
        imaNum = y;
    }
    
    // Displays complex numbers.
    public static void display (comNum x)
    {
        if (x.realNum != 0 && x.imaNum > 0)
        {
            System.out.println(x.realNum + " + " + x.imaNum + "i");
        }
        
        else if (x.realNum != 0 && x.imaNum == 0)
        {
            System.out.println(x.realNum);
        }
        
        else if (x.realNum != 0 && x.imaNum < 0)
        {
            System.out.println(x.realNum + " - " + Math.abs(x.imaNum) + "i");
        }
        
        else if (x.realNum == 0 && x.imaNum !=0)
        {
            System.out.println(x.imaNum + "i");
        }
    }
    
    // Finds the absolute value of a complex number.
    public double abs ()
    {
        return (Math.pow(Math.pow(realNum, 2) + Math.pow(imaNum, 2), 0.5));
    }
    
    // Finds the conjugate of a complex number.
    public comNum conj ()
    {
        double x, y;
        x = realNum;
        y = -imaNum;
        return new comNum(x, y);
    }
    
    // Adds complex numbers together.
    public comNum add (comNum x)
    {
        double newReal, newIma;
        
        newReal = this.realNum + x.realNum;
        newIma = this.imaNum + x.imaNum;
        
        return new comNum(newReal, newIma);
    }
    
    // Subtracts complex numbers.
    public comNum subtract (comNum x)
    {
        double newReal, newIma;
        
        newReal = this.realNum - x.realNum;
        newIma = this.imaNum - x.imaNum;
        return new comNum(newReal, newIma);
    }
    
    // Multiplies complex numbers using scalar values.
    public comNum multScalar (double x)
    {
        double newRealNum = realNum * x;
        double newImaNum = imaNum * x;
        return new comNum(newRealNum, newImaNum);
    }
    
    
    // Multiplies complex numbers with each other.
    public comNum multComplex (comNum a)
    {
        double x1, x2, y1, y2, real, ima;
        x1 = this.realNum * a.realNum;
        y1 = this.realNum * a.imaNum;
        y2 = a.realNum * this.imaNum;
        x2 = -(a.imaNum * this.imaNum);
        real = x1 + x2;
        ima = y1 + y2;
        return new comNum(real, ima);
    }
    
    
    // Applies exponents to a complex number.
    public comNum expo (int a)
    {
        double real = realNum, ima = imaNum, x, y;
        
        for (int i  = 1; i < a; i ++)
        {
            x = real * realNum + -(ima * imaNum);
            y = ima * realNum + real * imaNum;
            real  = x;
            ima = y;
        }
        return new comNum(real, ima);
    }
    
    
    // Checks if a number is in the MS and returns an int value to be used for colouring.
    public static int MSBoundsCheck (comNum c, int bindNum)
    {
        comNum z = c;
        int escapeCount = 0;
        
        while ((Math.pow(z.realNum, 2) - Math.pow(z.imaNum, 2)) < 4)
        {
           z = c.add(z.expo(2));
           escapeCount ++;
           if (escapeCount == bindNum)
           {
               return escapeCount;
           }
        }
        return escapeCount;
    }
}
