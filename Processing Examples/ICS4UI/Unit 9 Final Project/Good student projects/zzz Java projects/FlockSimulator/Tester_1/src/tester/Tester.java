/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tester;

import tester.Boid;
import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.Random;
import javax.swing.JFrame;


public class Tester extends JFrame{
    
    int mode = 2;
    boolean dead = false;
    Random r = new Random();
    int numBoids = 200;
    int numPreds = 5;
    ArrayList<Boid> animals = new ArrayList();
    ArrayList<Boid> predators = new ArrayList();
    int radius = 5;
    int di = radius *2;
    double boidVlim = 5;
    double predVlim = 8;

    
    public void initializePositions() {
        for (int i = 0; i < numBoids; i++) {
            animals.add(new Boid(r.nextInt(1000),r.nextInt(1000)));
        }
        for (int i = 0; i < numPreds; i++) {
            predators.add(new Boid(r.nextInt(1000),r.nextInt(1000)));
        }
    }
    
    public double getDist(double x1,double x2,double y1,double y2) {
        return Math.sqrt(Math.pow(x1-x2,2)+Math.pow(y1-y2,2));
    }
    
    public Vector animalV(int i) {
        int num = 0;
        Vector v1 = new Vector(0,0);
        Vector v2 = new Vector(0,0);
        Vector v3 = new Vector(0,0);
        Vector v4 = new Vector(0,0);
        Vector v5 = new Vector(0,0);
        Vector q;
        Vector an = new Vector(animals.get(i).xPos,animals.get(i).yPos);
        Vector ot;
        for (int j = 0; j < predators.size(); j++) {
            double d2 = getDist(predators.get(j).xPos,animals.get(i).xPos,predators.get(j).yPos,animals.get(i).yPos);
            if (d2 <= 15) {
                dead = true;
                return new Vector(0,0);
            }
            else if (d2 <= 100) {
                v4 = v4.subtract(new Vector(predators.get(j).xPos,predators.get(j).yPos).subtract(an));
            }
        }
        for (int j = 0; j < animals.size(); j++) {
            if (j != i) {
                double d1 = getDist(animals.get(j).xPos,animals.get(i).xPos,animals.get(j).yPos,animals.get(i).yPos);
                ot = new Vector(animals.get(j).xPos,animals.get(j).yPos);
                if (d1 <= 100) {
                    num++;
                    v1 = v1.add(ot);
                    if (d1 <= 20) {
                        v2 = v2.subtract(ot.subtract(an));
                    }
                    v3 = v3.add(animals.get(j).v);
                }
            }
        }
        if (num !=0) {
            v1 = v1.divide(num);
        }
        else {
            v1 = new Vector(500,500);
        }
        if (mode == 1) {
            if (animals.get(i).xPos > 1000) {
                v5.xPart -= boidVlim;
            }
            else if (animals.get(i).xPos < 0) {
                v5.xPart += boidVlim;
            }
            if (animals.get(i).yPos > 1000) {
                v5.yPart -= boidVlim;
            }
            else if (animals.get(i).yPos < 0) {
                v5.yPart += boidVlim;
            }
        }
        v1 = (v1.subtract(an)).divide(100);
        v2 = v2.divide(5);
        v3 = v3.divide(100);
        v4 = v4.divide(5);
        v5 = v5.divide(10);
        q = v1.add(v2).add(v3).add(v4).add(v5).add(animals.get(i).v);
        if (q.magnitude() > boidVlim) {
            q = (q.divide(q.magnitude())).divide(1/boidVlim);
        }
        return q;
    }
    public Vector predatorV(int i) {
        int num = 0;
        Vector v1 = new Vector(0,0);
        Vector v2 = new Vector(0,0);
        Vector v3 = new Vector(0,0);
        Vector v4 = new Vector(0,0);
        Vector q;
        Vector an = new Vector(predators.get(i).xPos,predators.get(i).yPos);
        for (int j = 0; j < predators.size(); j++) {
            if (j != i) {
                if (getDist(predators.get(j).xPos,predators.get(i).xPos,predators.get(j).yPos,predators.get(i).yPos) <= 50) {
                    v2 = v2.subtract(new Vector(predators.get(j).xPos,predators.get(j).yPos).subtract(an));
                }
            }
        }
        double d;
        int min = 0;
        double minD = 1000;
        for (int j = 0; j < animals.size(); j++) {
            d = getDist(animals.get(j).xPos,predators.get(i).xPos,animals.get(j).yPos,predators.get(i).yPos);
            if (d <= 500) {
                    num++;
                    v1 = v1.add(new Vector(animals.get(j).xPos,animals.get(j).yPos));
                    if (d < minD) {
                        min = j;
                        minD = d;
                    }
                }
        }
        if (num !=0) {
            v1 = v1.divide(num);
            v3 = new Vector(animals.get(min).xPos,animals.get(min).yPos).subtract(an);
        }
        else {
            v1 = new Vector(500,500);
        }
        if (mode == 1) {
            if (predators.get(i).xPos > 1000) {
                v4.xPart -= predVlim;
            }
            else if (predators.get(i).xPos < 0) {
                v4.xPart += predVlim;
            }
            if (predators.get(i).yPos > 1000) {
                v4.yPart -= predVlim;
            }
            else if (predators.get(i).yPos < 0) {
                v4.yPart += predVlim;
            }
        }
        v1 = (v1.subtract(an)).divide(100);
        v2 = v2.divide(5);
        v3 = v3.divide(1);
        v4 = v4.divide(10);
        q = v1.add(v2).add(v3).add(v4).add(predators.get(i).v);
        if (q.magnitude() > predVlim) {
            q = (q.divide(q.magnitude())).divide(1/predVlim);
        }
        return q;
    }
    
    public void updatePositions() {
        for (int i = 0; i < animals.size(); i++) {
            animals.get(i).v = animalV(i);
            if (dead) {
                numBoids --;
                animals.remove(i);
                i--;
                dead = false;
                continue;
            }
            if (mode == 2) {
                if (animals.get(i).xPos > 1000) {
                    animals.get(i).xPos -= 1000;
                }
                if (animals.get(i).xPos < 0) {
                    animals.get(i).xPos += 1000;
                }
                if (animals.get(i).yPos > 1000) {
                    animals.get(i).yPos -= 1000;
                }
                if (animals.get(i).yPos < 0) {
                    animals.get(i).yPos += 1000;
                }
            }
            animals.get(i).xPos += animals.get(i).v.xPart;
            animals.get(i).yPos += animals.get(i).v.yPart;
        }
        for (int i = 0; i < predators.size(); i++) {
            if (mode == 2) {
                if (predators.get(i).xPos > 1000) {
                    predators.get(i).xPos -= 1000;
                }
                if (predators.get(i).xPos < 0) {
                    predators.get(i).xPos += 1000;
                }
                if (predators.get(i).yPos > 1000) {
                    predators.get(i).yPos -= 1000;
                }
                if (predators.get(i).yPos < 0) {
                    predators.get(i).yPos += 1000;
                }
            }
            predators.get(i).v = predatorV(i);
            predators.get(i).xPos += predators.get(i).v.xPart;
            predators.get(i).yPos += predators.get(i).v.yPart;
        }
    }
    
    public void paint(Graphics g) {
        g.setColor(Color.white);
        g.fillRect(0, 0, 1000, 1000);
        g.setColor(Color.black);
        for (int i = 0; i < animals.size(); i++) {
            g.fillOval((int)animals.get(i).xPos-radius,(int)animals.get(i).yPos-radius,di,di);
        }
        g.setColor(Color.red);
        for (int i = 0; i < predators.size(); i++) {
            g.fillOval((int)predators.get(i).xPos-radius*2,(int)predators.get(i).yPos-radius*2,di*2,di*2);
        }
    }
    
    public static void sleep(int duration) {
        try {
            Thread.sleep( duration );
        } 
        catch (Exception e) {}
    }


    
    public static void main(String[] args) {
        Tester t = new Tester();
        t.setBackground(Color.BLACK);
        t.setSize(1000,1000);
        t.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        t.initializePositions();
        t.setVisible(true); 
        while (true) {
            t.updatePositions();
            t.repaint();
            t.sleep(20);
        }
    }
    
}
