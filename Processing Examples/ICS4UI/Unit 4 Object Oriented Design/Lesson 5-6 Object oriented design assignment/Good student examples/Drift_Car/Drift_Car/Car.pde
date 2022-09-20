class Car {
    String name; 
    float xMiddle, yMiddle, friction_coeff, speed, angle, length, width, originalSpeed;
    boolean swing, hasSwung, finished, planC;
    Track track;
    color col;
    int finishFrame;
    Car(String name, float xStart, float yStart, float fCoeff, float speed, Track track, color col) {
        this.name = name;
        this.xMiddle = xStart;
        this.yMiddle = yStart;
        this.friction_coeff = fCoeff;
        this.speed = -1*speed/10.0;
        this.angle = 0;

        this.length = 100;
        this.width = 50;
        this.swing = false;
        this.hasSwung = false;
        this.originalSpeed = this.speed;
        this.track = track;
        this.finished = false;
        this.planC = false;
        this.col = col;
        this.finishFrame = 0;
    }

    void checkForWin(int f) {
        if(this.xMiddle <= 0 && !(this.finished)) {
            println(this.name + " has finished");
            this.finished = true;
            this.finishFrame = f;
        }
    }

    void calculate_car() {
        int startPoint = 1000-this.track.length;

        if(this.planC) {
            this.angle += abs(this.originalSpeed)/15.0;
            this.speed -= 2/30.0 * (90/(110 + 2.0/(this.friction_coeff) * abs(this.originalSpeed*this.originalSpeed/25.0) - 90))/(5.0) * this.friction_coeff;
            if(this.angle >= 90) {
                this.angle = 90;
                this.swing = true;
                this.hasSwung = true;
                this.speed = originalSpeed;
                this.planC = false;
            }
        }

        if(!(this.planC) && this.yMiddle < startPoint && this.angle <= 110 + 2.0/(this.friction_coeff) * abs(this.originalSpeed*this.originalSpeed/25.0) && !(this.swing) && !(this.hasSwung)) {
            this.angle += abs(this.originalSpeed)/2.0;
            this.speed += 1/5.0 * this.friction_coeff;
            if(this.speed >= 0) {
                this.planC = true;
            }
            if(this.angle >= 110 + 2.0/(this.friction_coeff) * abs(this.originalSpeed*this.originalSpeed/25.0)) {
                this.swing = true;
            }
        }
        if(this.swing && this.angle > 90 && !(this.hasSwung)) {
            this.angle -= abs(this.originalSpeed)/3.0;
            this.speed -= 2/3.0 * (90/(110 + 2.0/(this.friction_coeff) * abs(this.originalSpeed*this.originalSpeed/25.0) - 90))/(5.0) * this.friction_coeff;
            if(this.angle <= 90) {
                this.angle = 90;
                this.hasSwung = true;
                this.speed = this.originalSpeed;
            }
        }
        
    }

    void updateCar(int f) {
        checkForWin(f);
        calculate_car();
        this.speed = toPos(this.speed);
        if(!(this.swing) && !(this.planC)) {
            this.yMiddle += this.speed;
        }
        else if(this.planC) {
            this.xMiddle += this.speed * cos(PI/2.0 - radians(this.angle));
            this.yMiddle += this.speed * sin(PI/2.0 - radians(this.angle));
        }
        else if(!(this.hasSwung)) {
            this.xMiddle += this.speed * cos(radians(this.angle) - PI/2.0);
            this.yMiddle -= this.speed * sin(radians(this.angle) - PI/2.0);
        }

        else if (!(this.finished)) {
            this.xMiddle += this.speed;
        }

        else {
            this.xMiddle += this.speed;
            // return;
        }
    }

    
    float toPos(float x) {
        if(x < 0) {
            return x;
        }
        else {
            return 0;
        }
    }

    void drawCar() {
        PVector LeftTop = new PVector(this.xMiddle, this.yMiddle);
        PVector LeftBottom = new PVector(LeftTop.x + (this.length)*cos(PI/2.0 - radians(this.angle)), LeftTop.y + (this.length)*sin(PI/2.0 - radians(this.angle)));
        PVector RightTop = new PVector(LeftTop.x + this.width * cos(radians(this.angle)), LeftTop.y - this.width*sin(radians(this.angle)));
        PVector RightBottom = new PVector(LeftBottom.x + this.width * cos(radians(this.angle)), LeftBottom.y - this.width*sin(radians(this.angle)));

        beginShape();
        fill(this.col);
        strokeWeight(1);
        vertex(LeftTop.x, LeftTop.y);
        vertex(LeftBottom.x, LeftBottom.y);
        vertex(RightBottom.x, RightBottom.y);
        vertex(RightTop.x, RightTop.y);
        endShape();
    }

    void drawPoint() {
        stroke(255);
        strokeWeight(4);
        point(this.xMiddle, this.yMiddle);
    }
}
