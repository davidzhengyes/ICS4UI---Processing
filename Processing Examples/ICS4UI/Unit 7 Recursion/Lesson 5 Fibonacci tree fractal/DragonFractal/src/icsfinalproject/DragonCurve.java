package icsfinalproject;

// Imports used to run program.
import java.util.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import javax.swing.*;
import java.lang.Thread;
import static javax.swing.JFrame.EXIT_ON_CLOSE;

public class DragonCurve extends JFrame{
    
    // Fields used by program
    static Vertex v1;
    static double length;
    static double lengthModifier = Math.sqrt(2) / 2;
    static Vertex v2;
    static Line l;
    static int width=1000, height=1000;
    static int maxLevel;
    static int currLevel = 1;
    static int waitTimeBetweenFrames;
    static Color leftColour = Color.ORANGE;
    static Color rightColour = Color.green;
    static String lineOrientation;
    static Color backgroundColor = Color.darkGray;
    
    static ArrayList <Line> lineList = new ArrayList();
    
    // Method used to split each line and double the Array List of lines to generate the full set of lines to be painted for the fractal.
    public static void splitLine()
    {
        // Variables used to create new lines from old line.
        Line newLine1;
        Line newLine2;
        Vertex breakPoint;
        double x2 = 0, y2 = 0;
        
        // Loop designed to run through each element in the array list and split into two.
        int loopLength  = lineList.size();
        for (int i = 0; i < loopLength; i++) 
        {
            // Series of if-else statements that determine what orientation a line is in and generates the vertex for the new line accordingly.
            if (lineList.get(i).findAngleWithXAxis() == 0)
            {
                x2 = lineList.get(i).start.x + length / 2;
                y2 = lineList.get(i).start.y + length / 2;
            }

            else if (lineList.get(i).findAngleWithXAxis() == Math.PI || lineList.get(i).findAngleWithXAxis() == -Math.PI)
            {
                x2 = lineList.get(i).start.x - length / 2;
                y2 = lineList.get(i).start.y - length / 2;
            }

            else if (lineList.get(i).findAngleWithXAxis() == Math.PI / 2)
            {
                x2 = lineList.get(i).start.x + length / 2;
                y2 = lineList.get(i).start.y - length / 2;
            }

            else if (lineList.get(i).findAngleWithXAxis() == -Math.PI / 2)
            {
                x2 = lineList.get(i).start.x - length / 2;
                y2 = lineList.get(i).start.y + length / 2;
            }

            else if (lineList.get(i).findAngleWithXAxis() == Math.PI / 4)
            {
                x2 = lineList.get(i).end.x;
                y2 = lineList.get(i).start.y;
            }

            else if (lineList.get(i).findAngleWithXAxis() == 3 * Math.PI / 4)
            {
                x2 = lineList.get(i).start.x;
                y2 = lineList.get(i).end.y;
            }

            else if (lineList.get(i).findAngleWithXAxis() == -Math.PI / 4)
            {
                x2 = lineList.get(i).start.x;
                y2 = lineList.get(i).end.y;
            }

            else
            {
                x2 = lineList.get(i).end.x;
                y2 = lineList.get(i).start.y;
            }
  
            // Generation of new lines and replacement of old line.
            breakPoint = new Vertex(x2, y2);
            newLine1 = new Line(lineList.get(i).start, breakPoint);
            newLine2 = new Line(lineList.get(i).end, breakPoint);        
            lineList.set(i, newLine1);
            lineList.add(newLine2);
        }
    }
    
    // Method that pre-generates buffered image to avoid animation sttuer.
    private Image createImage()
    {
      BufferedImage bufferedImage = new BufferedImage( width, height, BufferedImage.TYPE_INT_RGB);
      Graphics G = (Graphics2D) bufferedImage.getGraphics();
      
      G.setColor(backgroundColor);
      G.fillRect(0, 0, width, height);

      // Loop that alternates color of lines.
      for(int i = 0; i < lineList.size(); i ++)
      {
          if (i % 2 == 0)
          {
              lineList.get(i).drawLine(G, leftColour);
          }
          
          else
          {
              lineList.get(i).drawLine(G, rightColour);
          } 
      }
      return bufferedImage;
   }
    
    // Method that paints the buffered image.
    public void paint(Graphics g) {
        Image img = createImage();
        g.drawImage(img, 0, 0, this);
    }
    
    // Method that allows the animation to have a certain speed.
    public static void sleep( int duration ) {
        try {
              Thread.sleep( duration );
            }
        catch (Exception e) {
            }
    }
    
    // Gathers inputs from user to generate the first line and to determine what level the fractal is drawn to.
    public static void gatherInputs()
    {
        double x, y; 
        Scanner in = new Scanner(System.in);
        
        System.out.println("Please give the starting x-coordinate:");
        x = in.nextInt();
        
        System.out.println("Please give the starting y-coordinate:");
        y = in.nextInt();
        
        v1 = new Vertex(x, y);
        
        System.out.println("How long do you wish the starting line to be?");
        length = in.nextInt();
        
        System.out.println("What orientation do you want the line to be in?\nHorizontal?\nVertical?");
        lineOrientation = in.next();
        
        System.out.println("How long between each frame of animation?");
        waitTimeBetweenFrames = in.nextInt();
        
        System.out.println("Please input the level you wish the dragon curve to be drawn to:");
        maxLevel = in.nextInt();
        
        System.out.println("Notice: colors can be directly changed in code.");
    }
 
    // Initializes window and serves as the central point of the class where all other methods are called.
    public static void generateImage() 
    {
        gatherInputs();
        
        if (lineOrientation.charAt(0) == 'H' || lineOrientation.charAt(0) == 'h')
        {
            v2 = new Vertex (v1.x + length, v1.y);
        }
        
        else
        {
            v2 = new Vertex (v1.x, v1.y + length);
        }

        l = new Line(v1, v2);
        
        lineList.add(l);

        // Initializes window.
        DragonCurve t = new DragonCurve();
        t.setTitle("Dragon Curve");
        t.setSize(width, height);
        t.setDefaultCloseOperation(EXIT_ON_CLOSE);  
        t.setVisible(true);
        sleep(waitTimeBetweenFrames);
        
        // Doubles the list as many times as specified by the user.
        while (currLevel != maxLevel)
        {
            splitLine();
            length = length  * lengthModifier;
            currLevel ++;
            t.repaint();
            sleep(waitTimeBetweenFrames);
        }
    } 
}