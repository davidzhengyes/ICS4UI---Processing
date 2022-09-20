package icsfinalproject;

// Imports functionality to be used by class.
import java.awt.*;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.lang.Thread;
import java.util.Scanner;

public class Sierpinski extends JPanel {
    
    // Global fields to be used in the class.
    static int height = 800;
    static int width = 1000;
    
    static int maximumLevel;
    static boolean animateAllLevelsUpToMaximum = true;
    static int waitTimeBetweenFrames = 1000;
    static int currLevel = 1;
    static Color backgroundColor = Color.darkGray;
    static Color triangleColor = Color.orange;
    
    static boolean labelsOn = true;
    static int label = 1;
    
    // Recursive method for Sierpinski triangle.
    public void drawSierpinski( Graphics2D g, int level, Point p1, Point p2, Point p3 ) {
       g.setColor(triangleColor);
       
       //BASE CASE
       if (level == 1) {
            fillTriangle(g, p1, p2, p3);
            label++;
        } 
       
        //RECURSIVE CALLS
        else {
            //CALCULATE THE 3 MIDPOINTS 
            Point mid12 = midpoint(p1, p2);
            Point mid23 = midpoint(p2, p3);
            Point mid31 = midpoint(p3, p1);

            // recurse on 3 triangular areas
            drawSierpinski(g, level - 1,   p1,      mid12,    mid31 );
            drawSierpinski(g, level - 1,   mid12,   p2,       mid23 );
            drawSierpinski(g, level - 1,   mid31,   mid23,    p3 );
        }
    }

     //CALCULATES THE MIDPOINT BETWEEN TWO GIVEN POINTS
    public static Point midpoint(Point p1, Point p2) {
        return new Point((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
    }
    
    // Method that draws the triangles of the fractal.
    public static void fillTriangle( Graphics g, Point p1, Point p2, Point p3 ) {
           int[] xvalues = {p1.x, p2.x, p3.x};
           int[] yvalues = {p1.y, p2.y, p3.y};
           
           Polygon triangle = new Polygon( xvalues, yvalues, 3 );
           g.fillPolygon( triangle );
           
           //IF LABELS OPTION IS CHOSEN, WRITE THE NUMBER OF THE TRIANGLE AS ITS DRAWN
           if ( labelsOn && currLevel < 7 ) {
                g.setColor(Color.red);
           
                int xLabel = (p1.x + p2.x + p3.x)/3;
                int yLabel = (p1.y + p2.y + p3.y)/3;
        
                g.drawString( Integer.toString(label), xLabel, yLabel );
           }
    }
    
    // Method that gathers inputs from user and fills fileds.
    public static void gatherInputs()
    {
        Scanner in = new Scanner(System.in);
        
        System.out.println("What level should the fractal go to?");
        maximumLevel = in.nextInt();
    }
    
    // Method that paints the fractal.
    public void paint( Graphics g ) {
        
        Graphics2D g2 = (Graphics2D) g;
        
        int padding = 50;
        
        Point startA = new Point( width/2, padding );
        Point startB = new Point( padding, height-padding);
        Point startC = new Point( width-padding, height-padding );
        
        drawSierpinski( g2, currLevel, startA, startB, startC  );     
   }
    
    // Central method that calls other methods to draw fractal recursively. Also initializes window.
    public static void generateImage() {
        JFrame screen = new JFrame();
        
        gatherInputs();

        screen.add( new Sierpinski() );
        screen.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        screen.setBackground(backgroundColor);
        screen.setSize( width, height );
        screen.setTitle("Sierpinski Triangle");
        screen.setVisible(true);
        
        if ( animateAllLevelsUpToMaximum ) {
            
            for ( int i=1; i < maximumLevel; i++ ) {
                sleep( waitTimeBetweenFrames );
                label = 1;
                screen.repaint();
                currLevel++;
            }  
        }
        
        else
        {
            currLevel = maximumLevel;
        }
   }

    // Method for animation speed.
    public static void sleep( int duration ) {
        try {
              Thread.sleep( duration );
            }
        catch (Exception e) {
            }
    }
    

}