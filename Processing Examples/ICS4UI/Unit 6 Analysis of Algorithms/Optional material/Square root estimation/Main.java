
package squareroot;


public class Main {
    
    
    public Main() {
    }
    
   
    public static double estimateSquareRootBinarySearch(double x, double tolerance)
    {
        int cnt = 0;
        double s, ub, lb;
        lb = 0;
        
        if (x > 1)
        {
            ub = x;
            lb = 1;
        }
        else if (x < 1)
        {
            ub = 1;
            lb = x;     
        }
        else
            return 1;
       
        s = (lb+ub) / 2;
        
        while(Math.abs(s*s-x) > tolerance && cnt < 50)
        {
            cnt++;
            System.out.println(cnt + ":   " + s + "   " + s*s);
            
            if(s*s > x)
                ub = s;
            else
                lb = s;
            
            s = (lb+ub)/2;  
        }
        
        return s;
    }
    
    public static double estimateSquareRootNewtonsMethod(double x, double tolerance)
    {
        int cnt = 0;
        double s = x;
       
        
        while(Math.abs(s*s-x) > tolerance && cnt < 50)
        {
            cnt++;
            System.out.println(cnt + ":   " + s + "   " + s*s);
            s = (s + x/s) / 2;
        }
        
        return s;
    }
    
    public static void main(String[] args) {
        double x = 10000000;
        double tolerance = .0001;
        
        System.out.println( "Binary:  " + estimateSquareRootBinarySearch(x, tolerance));
        System.out.println( "Newton:  " + estimateSquareRootNewtonsMethod(x, tolerance));
    }
    
}
