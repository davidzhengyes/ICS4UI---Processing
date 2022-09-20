package pythtree;

import java.awt.*;
import java.awt.geom.*;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.lang.Thread;

public class PythTree extends JPanel {
    
    static int height = 800;
    static int width = 1000;
    
    static int maximumLevel = 5;
    static boolean animateAllLevelsUpToMaximum = true;
    static int waitTimeBetweenFrames = 200;
    static int currLevel = 1;
    static double piOver4 = Math.PI/4;
    static double reduction = 1/Math.sqrt(2);
    
    
    
    
    public void drawPythTree( Graphics2D g, int level, double x1, double y1, double length, double theta, Color col ) {
       g.setColor( Color.yellow);
       
       double Lsin = length*Math.sin(theta);
       double Lcos = length*Math.cos(theta);
       double x2 = x1 - Lsin;
       double y2 = y1 - Lcos;
       double x3 = x2 + Lcos;
       double y3 = y2 - Lsin;
       double x4 = x1 + Lcos;
       double y4 = y1 - Lsin;
       
       int[] xpoints = {(int) x1,(int) x2,(int) x3,(int) x4};
       int[] ypoints = {(int) y1,(int) y2,(int) y3,(int) y4};
       Polygon p = new Polygon( xpoints, ypoints, 4);
       g.setColor( col );
       g.fillPolygon( xpoints, ypoints, 4);
       
        //RECURSIVE CALLS
        if (level > 1) {
            double length2 = length * reduction;
            double newTheta = theta + piOver4;
            
            double xPeak = x2 + length2*Math.cos(newTheta);
            double yPeak = y2 - length2*Math.sin(newTheta);

             // recurse on 3 triangular areas
            drawPythTree(g, level - 1, x2, y2, length2, newTheta, Color.blue );
            drawPythTree(g, level - 1, xPeak, yPeak, length2, theta - piOver4, Color.black );
        }
    }

     //CALCULATES THE MIDPOINT BETWEEN TWO GIVEN POINTS
    public static Point midpoint(Point p1, Point p2) {
        return new Point((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
    }
    
    
    
    
    
    public void paint( Graphics g ) {
        
        Graphics2D g2 = (Graphics2D) g;
        
        drawPythTree( g2, currLevel, 400, 700, 150, 0, Color.blue );     
   }
    
    
    public static void main(String[] args) {
        JFrame screen = new JFrame();
        
        screen.add( new PythTree() );
        screen.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        screen.setBackground(Color.yellow);
        screen.setSize( width, height );
        screen.setVisible(true);
        
        if ( animateAllLevelsUpToMaximum ) {
            
            for ( int i=1; i < maximumLevel; i++ ) {
                sleep( waitTimeBetweenFrames );
                
                screen.repaint();
                currLevel++;
            }  
        }
        
        else
            currLevel = maximumLevel;
   }

    
    public static void sleep( int duration ) {
        try {
              Thread.sleep( duration );
            }
        catch (Exception e) {
            }
    }
    

}