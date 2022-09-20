class BottomStack {
    ArrayList landed;
    
    
    BottomStack() {
        landed = new ArrayList();
        for( int i = 0 ; i < width / 5 ; i++ ) {
            landed.add(new PVector(i * 5, height));
        }
        landed.add(new PVector(width, height));
    }
    
    //True or False for whether the flake has hit the ground or the snowpile
    boolean ifLanded(SnowFlake s) {
        boolean yn = false;
        
        
        for(int i = 0 ; i < landed.size() - 1 ; i++ ) {
            PVector p1 = (PVector)landed.get(i);
            PVector p2 = (PVector)landed.get(i + 1);
            float d = p1.dist(p2);
            
            
            if( p1.dist(s.p) < d && p2.dist(s.p) < d ) {
                float S = triangleArea(p1, p2, s.p);
                float h = 2 * S / p1.dist(p2);
                if( h < s.r ) {
                    yn = true;
                }
            }
        }
        return yn;
    }
    
    //Getting the area from the points of the snowflake to p1 and p2
    float triangleArea(PVector p1, PVector p2, PVector p3) {
        float a = p1.dist(p2);
        float b = p2.dist(p3);
        float c = p3.dist(p1);
        float s = (a + b + c) / 2.0;
        return sqrt(s * (s - a) * (s - b) * (s - c));
    }
    
    // adding where the snowflake lands to be made into a snow pile
    void add(SnowFlake s) {
        for(int i = 0 ; i < landed.size() - 1 ; i++ ) {
          
            //position of flake when landed
            PVector p1 = (PVector)landed.get(i);
            PVector p2 = (PVector)landed.get(i + 1);
            
            // distance from points
            float d = p1.dist(p2);
            
            
            
            if( p1.dist(s.p) < d && p2.dist(s.p) < d ) {
                float r = p1.dist(s.p) / (p1.dist(s.p) + p2.dist(s.p));
                p1.y -= s.r * (1 - r);
                p2.y -= s.r * r;
            }
        }
        
        
        for(int i = 0; i < landed.size() - 1; i++ ) {
            PVector p1 = (PVector)landed.get(i);
            PVector p2 = (PVector)landed.get(i+1);
            
            //Getting the absolute value for the height and width 
            float h = abs(p1.y - p2.y);
            float w = abs(p1.x - p2.x);
            
            //the height should be bigger than 4/3w
            if( w * 1.3 < h ) {
                p1.y = (p1.y + p2.y) / 2.0;
                p2.y = p1.y;
            }
        }
    }
  
    //Drawing the stack at the bottom using a quadrilateral
    void draw() {
        noStroke();
        fill(snowC);
        
        
        for( int i = 0 ; i < landed.size() - 1 ; i++ ) {
            PVector p1 = (PVector)landed.get(i);
            PVector p2 = (PVector)landed.get(i + 1);
            
            //draws the stack 
            quad(p1.x, p1.y, p1.x, height, p2.x + 1, height, p2.x + 1, p2.y);
        }
    }
}
