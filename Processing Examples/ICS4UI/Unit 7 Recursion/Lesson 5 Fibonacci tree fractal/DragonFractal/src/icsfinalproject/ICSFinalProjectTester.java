/**Program: ICS Final Project (Fractal Design Generator)
 * Programmer: Qianshu Wang
 * Last Modified: June 14 2014
 * Description: A program that generates the a user's chosen fractal.
 */

package icsfinalproject;

// Imports for scanning.
import java.io.IOException;
import java.util.Scanner;

public class ICSFinalProjectTester{

    // Number representing fracal choice of user.
    static int choiceNum;
    
    // Calls the fractal and generates the choice of the user.
    public static void main(String[] args) throws IOException 
    {
        askUser();
        
        if (choiceNum == 1)
        {
            PythaTree.generateImage();
        }
        
        else if(choiceNum == 2)
        {
            DragonCurve.generateImage();
        }
        
        else if(choiceNum == 3)
        {
            Sierpinski.generateImage();
        }
        
        else
        {
            MandelbrotSet.generateImage();
        }
    }
    
    
    // Method that determines which fractal the user wishes to see.
    public static void askUser()
    {
        Scanner in = new Scanner(System.in);
        
        System.out.println("Welcome to Qianshu's Fractal Generator! Please select a fractal that you wish to view (use numbers):\n1) Pythagorean Tree\n2) Dragon Curve\n3) Sierpinski Triangle\n4) Mandelbrot Set");
        choiceNum = in.nextInt();
    }
}
