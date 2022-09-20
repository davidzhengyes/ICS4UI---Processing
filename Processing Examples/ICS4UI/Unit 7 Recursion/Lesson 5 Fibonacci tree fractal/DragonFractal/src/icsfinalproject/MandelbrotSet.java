package icsfinalproject;

// Imports various items needed to run utilities such as file scanner and JFrame.
import java.awt.*;
import javax.swing.*;
import static javax.swing.JFrame.EXIT_ON_CLOSE;
import java.util.Scanner;
import java.io.FileReader;
import java.io.IOException;

public class MandelbrotSet extends JFrame
{
    // Creates global fields to be used in the program.
    static int bindNum, height = 800, width = 800, numX = 800, numY = 800;
    static double x1, x2, y1, y2, xRange, yRange, pixelSizeX, pixelSizeY, hue, saturation, brightness;
    
    // Central method of class that calls the generation of the fractal.
    public static void generateImage() throws IOException
    {
        // Allows JFrame to be used in main method.
        MandelbrotSet MSMaker = new MandelbrotSet();
        
        // Calls file reader method.
        getFileInputs();

        // Creates graphics.
        MSMaker.initializeWindow();
    }
    
    // Method that gathers file inputs and performs calculations using them.
    public static void getFileInputs () throws IOException
    {
        // Sets up file scanning functionality.
        FileReader MSInputs = new FileReader("Mandelbrot Set Inputs.txt");
        Scanner in = new Scanner(MSInputs);
        Scanner read = new Scanner(System.in);
        
        System.out.println("Check attached file to modify inputs.");
        // Gathers inputs and fills fields.
        x1 = in.nextDouble();
        x2 = in.nextDouble();
        y1 = in.nextDouble();
        y2 = in.nextDouble();
        xRange = Math.abs(x2 - x1);
        yRange = Math.abs(y2 - y1);
        bindNum = in.nextInt();
        pixelSizeX = xRange / numX;
        pixelSizeY = yRange / numY;
        
        System.out.println("Give a hue modifier for the pattern:");
        hue = read.nextDouble();
        
        System.out.println("Give a saturation modifier for the pattern:");
        saturation = read.nextDouble();
        
        System.out.println("Give a brightness modifier for the pattern:");
        brightness = read.nextDouble();
    }
    
    // Method that creates graphics.
    public void paint(Graphics g) 
    {
        double x = x1, y;
        comNum c;
        
        // Nested for-loops that check each pixel for whether or not they are in the MS.
        for (int i = 0; i < numX; i ++)
        {
            y = y1;
            for (int j  = 0; j < numY; j ++)
            {               
                c  = new comNum(x, y);
                // Paints colour of pixel based on whether or not the pixel is in the MS and paints various shades depending on its closeness to the set.
                g.setColor(Color.getHSBColor(comNum.MSBoundsCheck(c, bindNum) * (float)hue, comNum.MSBoundsCheck(c, bindNum) * (float)saturation, comNum.MSBoundsCheck(c, bindNum) * (float)brightness));
                
                //Other option for gray and white version.
                //g.setColor(new Color(comNum.MSBoundsCheck(c, bindNum), comNum.MSBoundsCheck(c, bindNum), comNum.MSBoundsCheck(c, bindNum)));
                g.drawLine(i, j, i+1, j+1);
                y += pixelSizeY;
            }           
            x += pixelSizeX;
        }
    }
    
    // Creates window for graphics.
    public void initializeWindow() {
        setTitle("Mandelbrot Set");
        setSize(height, width);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setBackground(Color.black);
        setVisible(true);
    }
}
