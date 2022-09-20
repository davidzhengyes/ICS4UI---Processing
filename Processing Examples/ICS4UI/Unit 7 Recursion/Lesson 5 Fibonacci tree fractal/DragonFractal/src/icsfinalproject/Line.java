package icsfinalproject;

import java.awt.*;

public class Line {
    Vertex start;
    Vertex end;
    
    // Constructor for the line class that takes two vertices.
    public Line (Vertex a, Vertex b)
    {
        this.start = a;
        this.end = b;
    }
    
    // Draws a line on screen.
    public void drawLine(Graphics g, Color baseColour)
    {
        g.setColor(baseColour);
        g.drawLine((int)start.x, (int)start.y, (int)end.x, (int)end.y);
    }
    
    // Finds the midpoint of a line.
    public Vertex findMidpoint()
    {
        double xPoint = (this.end.x + this.start.x) / 2;
        double yPoint = (this.end.y + this.start.y) / 2;
        
        Vertex v = new Vertex(xPoint, yPoint);
        
        return v;
    }
    
    // Finds the length of a line.
    public double findLength()
    {
        double length = Math.sqrt(Math.pow(this.end.x - this.start.x, 2) + Math.pow(this.end.y - this.start.y, 2));
        return length;
    }
    
    // Finds the angle the line makes with the x-axis.
    public double findAngleWithXAxis()
    {
        double angle = Math.atan2(this.start.y - this.end.y, this.end.x - this.start.x);
        return angle;
    }
    
    // Finds the x-component of the line.
    public double findXComponent()
    {
        double dx;
        dx = this.end.x - this.start.x;
        return dx;
    }
    
    //Finds the y-component of the line.
    public double findYComponent()
    {
        double dy;
        dy = this.end.y - this.start.y;
        return dy;
    }

}
