package icsfinalproject;

import java.awt.*;
import java.awt.image.BufferedImage;
import javax.swing.*;
import java.lang.Thread;
import java.util.Scanner;
import static javax.swing.JFrame.EXIT_ON_CLOSE;

public class PythaTree extends JFrame{
    
    // Fields used by class.
    static double x1;
    static double y1;
    static double inputAngle;
    static double theta;
    static int width=1000, height=1000;
    static int maxLevel;
    static int currLevel = 1;
    static double length;
    static int waitTimeBetweenFrames;
    static Color baseColour = Color.pink;
    static Color leftColour = Color.orange;
    static Color rightColour = Color.RED;
    static Color backgroundColor = Color.darkGray;
    
    // Recursive method used to calculate the the new coordinates in the pythagorean Tree fractal.
    public void drawPythaTree(Graphics g, double x1, double y1, double length, double angle, int level, Color colour) {
        //BASE CASE
        if (level==1) {
            drawBlock(g, x1, y1, length, angle, colour);
        }
        
        //RECURSIVE CASE
        else {
            drawBlock(g, x1, y1, length, angle, colour);
            
            double x2 = x1 - length * Math.cos(Math.PI / 2 - angle);
            double y2 = y1 - length * Math.sin(Math.PI / 2 - angle);
            
            length = length * Math.sqrt(2) / 2;
            
            double x3 = x2 + length * Math.cos(Math.PI / 4 + angle);
            double y3 = y2 - length * Math.sin(Math.PI / 4 + angle);

            drawPythaTree(g, x2, y2, length, angle + Math.PI / 4, level - 1, leftColour);
            drawPythaTree(g, x3, y3, length, angle - Math.PI / 4, level - 1, rightColour);
        }
    }
    
    // Method that buffers the image to avoid animation stutter.
    private Image createImage(){
      BufferedImage bufferedImage = new BufferedImage( width, height, BufferedImage.TYPE_INT_RGB);
      Graphics G = (Graphics2D) bufferedImage.getGraphics();
      
      // Generates background color.
      G.setColor(backgroundColor);
      G.fillRect(0, 0, width, height);

      // Initial call of the recursive method.
      drawPythaTree(G, x1, y1, length, theta, currLevel, baseColour);
      return bufferedImage;
   }
    
    // Draws the buffered image.
    public void paint(Graphics g) {
        Image img = createImage();
        g.drawImage(img, 0, 0, this);
    }
    
    
    // Methods that draws a square based on a single given coordinate and the side length of the square.
    public void drawBlock (Graphics g, double x1, double y1, double length, double theta, Color colour)
    {
        double x2 = x1 + length * Math.cos(theta);
        double y2 = y1 - length * Math.sin(theta);
        
        double x3 = x1 + (Math.sqrt(2 * Math.pow(length, 2))) * Math.cos(theta + Math.PI / 4);
        double y3 = y1 - (Math.sqrt(2 * Math.pow(length, 2))) * Math.sin(theta + Math.PI / 4);
        
        double x4 = x1 - length * Math.cos(Math.PI / 2 - theta);
        double y4 = y1 - length * Math.sin(Math.PI / 2 - theta);
        
        int [] xPoints = {(int)x1, (int)x2, (int)x3, (int)x4};
        int [] yPoints = {(int)y1, (int)y2, (int)y3, (int)y4};
        
        g.setColor(colour);
        g.fillPolygon(xPoints, yPoints, xPoints.length);
    }
    
    // Gathers input from the user and fills fields.
    public static void gatherInputs()
    {
        Scanner in = new Scanner(System.in);
        
        System.out.println("What is the starting x-coordinate?");
        x1 = in.nextDouble();
        
        System.out.println("What is the starting y-coordinate?");
        y1 = in.nextDouble();
        
        System.out.println("At what angle will the starting square be at?");
        inputAngle = in.nextDouble();
        theta = inputAngle * (Math.PI / 180);
        
        System.out.println("What is the sidelength of the starting square?");
        length = in.nextDouble();
        
        System.out.println("What level will the fractal be drawn to?");
        maxLevel = in.nextInt();
        
        System.out.println("What is the pause between frames?");
        waitTimeBetweenFrames = in.nextInt();
        
        System.out.println("Notice: color of squares can be directly changed in code.");
    }
    
    // Sleep method for animation.
    public static void sleep( int duration ) {
        try {
              Thread.sleep( duration );
            }
        catch (Exception e) {
            }
    }
    
    // Central method that initializes the window and calls the drawing of the fractal.
    public static void generateImage()
    {
        PythaTree t = new PythaTree();

        gatherInputs();

        t.setTitle("Pythagorean Tree");
        t.setSize(width, height);
        t.setDefaultCloseOperation(EXIT_ON_CLOSE);
        t.setVisible(true);
        
        for (int i = 2; i <= maxLevel + 1; i++) {
            t.repaint();
            sleep(waitTimeBetweenFrames);
            currLevel = i;
        }
    }
}
